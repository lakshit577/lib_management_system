require_relative "book.rb"
require_relative "author.rb"
require_relative "student.rb"
require_relative "issued_book.rb"
require_relative "submit_book_transaction.rb"
require_relative "library.rb"



ruby = Book.new("ruby")
java = Book.new("java")
c = Book.new("c")

a1 = Author.new("dave")
a2 = Author.new("david")
a3 = Author.new("don")

ruby.add_author(a1)
ruby.add_author(a2)
ruby.add_author(a3)

c.add_author(a1)
 
java.add_author(a1)
java.add_author(a3)

# Author.print_all_authors_for_this_book(ruby)
# Author.print_all_authors_for_this_book(java)
# Book.print_all_books_for_this_author(a1)



s1 = Student.new("Lakshit")
s2 = Student.new("Rahul")
s3 = Student.new("Maru")



# puts s1.issue_book(ruby , 4).inspect
# puts s2.issue_book(java , 3).inspect
# puts s2.issue_book(java , 5).inspect

# s2.book_transactions


# create libraries=========================================
l1 = Library.new("Krishna Library")
l2 = Library.new("Sudama Library")
l3 = Library.new("Lakshya Library")
# add books to the libraries===========================================
puts 
puts 


l1.add_book(ruby,20)
l1.add_book(ruby,20)
l1.add_book(java,2)
l1.add_book(java,2)    
l1.add_book(java,2)    
l2.add_book(java,7)
 


l1.enrol_student(s1)
l1.all_available_book_details_for_specific_library

l1.issue_book(s1,"ruby",2)
puts l1.issue_book(s2,"ruby",2)
 l1.issue_book(s1,"java",2)
l1.issue_book(s1,"java",2)

l1.details_of_issued_book

#   "return  books to the library =============================="
l1.submit_book(s1,"java",2)
l1.submit_book(s1,"java",2)

puts
puts  "specific library available book details ============================="


l1.students_details_enrolled_in_this_library



# puts 
# puts "after returning __________________________________"
# puts 
# puts s2.submit_book(java,1) 

# s2.book_transactions
# puts        
# puts "get all issued books_____________________ "
# Student.get_issued_books
# puts "get all students_________________________"
# Student.get_all_students
# puts "get qty of issued books_________________________"


# Student.filter_by_name("Lakshit") 

# puts "total number of books issued============================"
# puts Student.get_qty_of_books_issued
# # puts a1.a_id
# puts Student.filter_by_author_name




 

 