
class Library
  attr_accessor :books,:lib_name
  @@Lib_id = 0
  def initialize(lib_name )
    @address = rand(10..20)
    @books = []
    @lib_name = lib_name
    @@Lib_id += 1
    @issued_book = []
    @enrol_student = []
  end
  
  def add_book(book, qty)
    return "the book qty can't be more than #{book.remaining_qty}" if qty > book.remaining_qty 
    return "the book does not exist" unless book 
    
    existing_book = search_book(@books,book.name)
    
    if existing_book
      existing_book[:qty] += qty
      book.remaining_qty -= qty
    else
      @books << { :book_id=>book.book_id,:book => book.name, :qty => qty,:lib_name => self.lib_name }
      book.remaining_qty -= qty
    end
    end


    def enrol_student(student)
      @enrol_student << student
    end


    def issue_book(student,book_name,qty)
      book = @books.find { |b| b[:book] == book_name }
      return "Book '#{book_name}' not found in the library." if !book
      return "student is not enrolled in this library" if !@enrol_student.include?(student)
      available_qty = book[:qty]

      if qty > available_qty
        return "qty is more than available qty"
      else
        book[:qty] -= qty

        # existing_book = @issued_book.find { |b| b[:book] == book_name }
        existing_book = search_book(@issued_book , book_name)
        # puts existing_book
        # add_book_in_array(@issued_book, existing_book , book,qty )
        if existing_book
          existing_book[:qty] += qty
        else
          @issued_book << {:book_id=>book[:book_id],:book => book_name , :qty => qty ,:library => self.lib_name} 
        end
      end
    end


    def submit_book(student, book_name , qty)
      book = search_book(@issued_book ,  book_name )
      return "Book '#{book_name}' is not issued yet!!" if !book
      return "student is not enrolled in this library!!" if !@enrol_student.include?(student)
      if qty > book[:qty]
        return "given qty is more than the issued qty"
      else
        book[:qty] -= qty
        existing_book = search_book(@books , book_name)
        add_book_in_array( @books,existing_book , book,qty )
        # if existing_book
        #   existing_book[:qty] += qty

        # else
        #   @books << { :book_id =>book.id ,:book => book.name, :qty => qty,:lib_name => self.lib_name }
          
        # end
        return "book returned Successfully !!!"
      end
    end


    # List details ==========================================================================================

    def all_available_book_details_for_specific_library
      puts "Avalibale books in #{self.lib_name}"
      print_books(@books)
    end


    def students_details_enrolled_in_this_library
      puts "enrolled students details in #{self.lib_name}===================================================="
      @enrol_student.each do |student|
        puts "#{student.student_id} #{student.name} #{student.contactno}  "
      end
    end


    def details_of_issued_book
      puts "Issued books in #{self.lib_name}"
      print_books(@issued_book)
    end
    

    protected
    def available_books_in_library
      @books.map{ |book| book[:book] }
    end
    def total_qty_of_books_availbale_in_the_library
      @books.map{ |book| book[:qty] }.sum
    end
    
    private
    def print_books(book_arr)
      book_arr.each do |book|
       puts  "#{book[:book_id]}\t#{book[:book]}\t\t#{book[:qty]}"
      end
      
    end
    def search_book(book_arr,book_name)
      book_arr.find{|b| b[:book]==book_name}
    end  
    def add_book_in_array(book_arr,existing_book , book ,qty)

       if existing_book
        existing_book[:qty] += qty

        else
          book_arr << { :book_id =>book.id ,:book => book.name, :qty => qty,:lib_name => self.lib_name }
          
        end
    end
end