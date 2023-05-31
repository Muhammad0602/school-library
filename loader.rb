require 'json'
require './book'
require './person'
require './rental'

class Loader
  def initialize
    load_data
  end

  def load_data
    @books = load_books
    @rentals = load_rentals
    @people = load_people
  end

  def load_books
    return [] unless File.exist?('storage/books.json')

    books_json = File.read('storage/books.json')
    return [] if books_json.empty?

    books_data = JSON.parse(books_json)
    books_data.map { |data| Book.new(data['title'], data['author']) }
  end

  def load_rentals
    return [] unless File.exist?('storage/rentals.json')

    rentals_json = File.read('storage/rentals.json')
    return [] if rentals_json.empty?

    rentals_data = JSON.parse(rentals_json)
    rentals_data.map do |data|
      book_data = data['book']
      person_data = data['person']
      book = @books.find { |b| b.title == book_data['title'] && b.author == book_data['author'] }
      person = create_person_from_data(person_data)
      Rental.new(data['date'], book, person)
    end
  end

  def load_people
    return [] unless File.exist?('storage/people.json')

    people_json = File.read('storage/people.json')
    return [] if people_json.empty?

    people_data = JSON.parse(people_json)
    people_data.map { |data| create_person_from_data(data) }
  end

  def create_person_from_data(data)
    if data['specialization']
      Teacher.new(data['age'], data['specialization'], data['name'])
    else
      Student.new(data['age'], data['parent_permission'], data['name'])
    end
  end

  attr_reader :books, :people, :rentals
end
