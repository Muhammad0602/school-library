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
      role = role(person)
      puts "[#{role}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def role(person)
    person.is_a?(Teacher) ? 'Teacher' : 'Student'
  end

  def create_person
    puts 'Do you want to create a: [Input number]'
    puts '1 - Student'
    puts '2 - Teacher'
    puts '0 - Cancel'
    person_role = gets.chomp.to_i

    case person_role
    when 1
      create_student
      puts "Student Created Successfully\n"
    when 2
      print 'Age: '
      age = gets.chomp
      print 'Name: '
      name = gets.chomp
      print 'Specialization: '
      specialization = gets.chomp
      @people << Teacher.new(age, specialization, name)
      puts "Teacher Created Successfully\n"
    when 0
      puts 'Person creation canceled!'
    else
      puts 'Invalid number. Person creation failed'
    end
  end

  def create_student
    age = nil
    loop do
      print 'Age: '
      input = gets.chomp
      if input.match?(/^\d+$/)
        age = input.to_i
        break
      else
        puts 'Please enter a valid age.'
      end
    end
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    gets.chomp.downcase

    @people << Student.new(age, nil, name)
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
    if @books.empty?
      puts 'Rental Creation Failed!'
      puts 'No books available at the moment!'
      return
    end
    puts 'Select a book from the following list by number'

    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book = gets.chomp.to_i

    if @people.empty?
      puts 'Rental Creation Failed!'
      puts 'No people available to rent at the moment!'
      return
    end

    puts 'Select a persoon from the following list by number (not id)'

    @people.each_with_index do |person, index|
      role = role(person)
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
