class Book
    attr_accessor :remaining_qty
    attr_accessor :name, :authors, :qty
    attr_accessor :book_id
    @@id=0
    def initialize(name)
      @name = name
      @authors = []
      @qty = 50
      @@id += 1 
      @book_id = @@id 
      @remaining_qty = @qty
    end
  
    def add_author(new_author)
      authors.push(new_author)
      new_author.add_book(self)
    end
  
    def self.print_all_books_for_this_author(author)
      puts "Books by author #{author.name}:"
      author.books.each do |book|
        puts book.name
      end
    end
  end