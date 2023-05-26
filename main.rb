require './app'
APP = App.new

class Main
  puts "Welcome to Shcool Library App\n\n\n"

  loop do
    puts 'Please choose an option by entering a number: '
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    user_choice = gets.chomp.to_i

    case user_choice
    when 1
      APP.list_books
    when 2
      APP.list_people
    when 3
      APP.create_person
    when 4
      APP.create_book
    when 5
      APP.create_rental
    when 6
      APP.list_rentals
    when 7
      puts 'Thanks for using our app!'
      break
    else
      puts 'Invalid Option. Please try again'
    end
  end
end