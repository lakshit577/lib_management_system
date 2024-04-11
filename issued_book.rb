require "date"
class IssuedBook
    
    attr_reader :issue_date, :expected_return_date, :book, :student, :qty
    attr_accessor :return_date, :submit_book_transactions

    def initialize(book, student, qty)
        @issue_date = Date.today
        @expected_return_date =  Date.today - 7
        @return_date = nil
        @book = book
        @student = student
        @qty = qty
        @submit_book_transactions = []
      end
      def book_name
        @book.name
      end

      def submitted_book_qty
        @submit_book_transactions.sum(&:qty)
      end

      def  remaining_book_qty_to_submit
         @qty - submitted_book_qty 
      end

end





