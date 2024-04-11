require "date"
require_relative "book.rb"
require_relative "issued_book.rb"
require_relative "submit_book_transaction.rb"



class Student
    @@id = 0
    @@students = []
    attr_reader :name,:student_id
    attr_reader :student_id,:contactno

    def initialize(name)
      @@id+=1
      @student_id = @@id
      @name = name
      @contactno = rand(1000000000..9999999999)
     
      @@students << self
    end
    # filter by name =================================================================
    def self.filter_by_name(name)
      @@students.select do |obj|
        if obj.name == name
          puts "name founded !!!"
        end
      end
    end
    # def self.filter_by_author_name()
    #   @@students.inspect
    # end

    # get all issued books ============================================================
    def self.get_issued_books
       @@students.each do |student|
        puts student.issued_books.map{|ib| ib.book.name}
      end
    end

    # get all students =================================================================
    def self.get_all_students
      @@students.each do |s|
      puts s.name
     end
   end

  # get total qty of books issued =======================================================
    def self.get_qty_of_books_issued
      @qty_of_issued_books_by_each_student=0
      @sbt = 0
       @@students.each do |s|
         s.issued_books.map do |ib|
          ib.submit_book_transactions.map do |sbt|
           @sbt =  sbt.qty
          end
            @qty_of_issued_books_by_each_student += ib.qty 
        end
      end      
        @qty_of_issued_books_by_each_student - @sbt
   end

    def issue_book(book, qty)
      return "you can't issue more than 5 books" if qty > 20
      return "Quntity can't be zero or negative" if qty.zero? || qty.negative?
      return "Book is not a book type" unless book.is_a?(Book)
      return "You already having 20 book issued. Can't issued more books." if (total_issued_book + qty) > 20
      return "Book is not avabile for given qty: #{qty}, availble qty: #{book.remaining_qty}" if book.remaining_qty < qty
  
      
      issued_book  = IssuedBook.new(book, self, qty)
      @issued_books  << issued_book
      book.remaining_qty = book.remaining_qty - qty
      # @@total_issued_book_by_class_variable += qty
      # puts @@total_issued_book_qty_by_class_variable 
  
      return "#{qty} #{book.name} books are successfully issued "
    end
  
    def is_book_issued?(book)
      @issued_books.any?{|ib| ib.book.object_id == book.object_id && ib.return_date.nil?}
    end

  
    
      def total_issued_book_qty(book)
        find_issued_books(book).sum(&:qty)
      end
    
      def total_issued_book
        @issued_books.select{|ib| ib.return_date.nil? }.sum(&:qty)
      end

      def submit_book(book,qty)

        return "you cant submit more than 20 book" if qty>20
        return "Quntity can't be zero or negative" if qty.zero? || qty.negative?
        return "Book is not a book type" unless book.is_a?(Book)
        return "you dont have any book issued yet" if @issued_books.empty?
        return "you have #{total_issued_book_qty(book)} issued to you . can't submit more than issued books" if qty > total_issued_book_qty(book)
        

        find_issued_books(book).each do |ib|   
            if ib.remaining_book_qty_to_submit >= qty
                
                create_submit_book_txn(ib, qty)
                # @@total_issued_book_by_class_variable -= qty
                # puts @@total_issued_book_by_class_variable
            
                break
            else
              
                remaining_books_qty_to_submit = ib.remaining_books_qty_to_submit
              qty -= remaining_books_qty_to_submit
                
              create_submit_book_txn(ib, remaining_books_qty_to_submit)
            end
          end
        end


        def create_submit_book_txn(ib,qty)
            submit_book_txn = SubmitBookTransaction.new(ib.return_date, qty)
            ib.submit_book_transactions << submit_book_txn
            ib.return_date = Date.today #if ib.remaining_book_qty_to_submit.zero?
            ib.book.remaining_qty += qty
        end

    def find_issued_books(book)
        @issued_books.select do |ib|
            ib.book.name == book.name &&ib.return_date.nil?
        end
    end

      def book_transactions
        puts "================================================================"
        puts "Name: #{@name} ================ Total Issued Books #{@issued_books.size}"
        puts "================================================================"
        puts "Date \t Book Name: \t  Qty \t Return Date \t Expected Return Date"
        puts "================================================================"
        @issued_books.each do |issued_book|
          puts "#{issued_book.issue_date}  \t #{issued_book.book_name} \t #{issued_book.qty} \t #{issued_book.return_date} \t #{issued_book.expected_return_date}"
        end
      end
end
 