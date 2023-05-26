require './person'
require './book'
require './student'
require './teacher'
require './rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    print "No books found\n" if @books.empty?

    @books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_people
    print "No people found\n" if @people.empty?

    @people.each do |person|
      role = person.is_a?(Teacher) ? 'Teacher' : 'Student'
      puts "[#{role}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher(2)? [Input the number]: '
    person_role = gets.chomp.to_i

    print 'Age: '
    age = gets.chomp

    print 'Name: '
    name = gets.chomp

    case person_role
    when 1
      print 'Has parent permission? [Y/N]: '
      gets.chomp.downcase

      @people << Student.new(age, nil, name)
      puts "Student Created Successfully\n"
    when 2
      print 'Specialization: '
      specialization = gets.chomp
      @people << Teacher.new(age, specialization, name)
      puts "Teacher Created Successfully\n"
    else
      print 'Invalid person_role. Person creation failed'
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    puts "Book created successfully\n\n"

    @books << Book.new(title, author)
  end

  def create_rental
    puts 'Select a book from the following list by number'

    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book = gets.chomp.to_i

    puts 'Select a persoon from the following list by number (not id)'

    @people.each_with_index do |person, index|
      role = person.is_a?(Teacher) ? 'Teacher' : 'Student'
      puts "#{index}) [#{role}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    @rentals << Rental.new(date, @books[book], @people[person])

    puts 'Rental created successfully'
  end

  def list_rentals
    print 'ID of the person: '
    id = gets.chomp.to_i

    puts 'Rentals: '
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}" if rental.person.id == id
    end
  end
end
