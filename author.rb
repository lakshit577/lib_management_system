class Author
    attr_accessor :name, :books
    
    def initialize(name)
      @name = name
      @books = []
    end
    
    def add_book(book)
      books.push(book)
    end
    
    def self.print_all_authors_for_this_book(book)
      puts "Authors of the book #{book.name}:"
      book.authors.each do |author|
        puts author.name
      end
    end
  end
  