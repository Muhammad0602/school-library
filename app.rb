require './person'
require './book'
require './student'
require './teacher'
require './rental'

class App
  def initialize
    if File.exist?('books.json') && File.exist?('rentals.json') && File.exist?('people.json')
      books_json = File.read('books.json')
      rentals_json = File.read('rentals.json') 
      people_json = File.read('people.json')
  
      @books = JSON.parse(books_json)
      @rentals = JSON.parse(rentals_json)
      @people = JSON.parse(people_json)
    else
    @books = []
    @people = []
    @rentals = []
    end
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
      create_teacher
      puts "Teacher Created Successfully\n"
    when 0
      puts 'Person creation canceled!'
    else
      puts 'Invalid number. Person creation failed'
    end
  end

  def create_student
    age = age_validation
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    gets.chomp.downcase

    @people << Student.new(age, nil, name)
  end

  def create_teacher
    age = age_validation
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    @people << Teacher.new(age, specialization, name)
  end

  def age_validation
    age = nil
    loop do
      print 'Age: '
      input = gets.chomp
      if input.match?(/^\d+$/) && input.to_i < 120
        age = input.to_i
        break
      else
        puts 'Please enter a valid age.'
      end
    end
    age
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
    selected_book = select_book

    if @people.empty?
      puts 'Rental Creation Failed!'
      puts 'No people available to rent at the moment!'
      return
    end
    selected_person = select_person

    date = take_date

    @rentals << Rental.new(date, selected_book, selected_person)
    puts 'Rental created successfully'
  end

  def select_book
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    @books[book_index]
  end

  def select_person
    puts 'Select a persoon from the following list by number (not id)'
    @people.each_with_index do |person, index|
      role = role(person)
      puts "#{index}) [#{role}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    @people[person_index]
  end

  def take_date
    print 'Date: '
    gets.chomp
  end

  def list_rentals
    print 'ID of the person: '
    id = gets.chomp.to_i

    puts 'Rentals: '
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}" if rental.person.id == id
    end
  end

# Saving the data 
def save_data
  books_json = @books.to_json
  rentals_json = @rentals.to_json
  people_json = @people.to_json

  File.write('books.json', books_json)
  File.write('rentals.json', rentals_json)
  File.write('people.json', people_json)
end



end
