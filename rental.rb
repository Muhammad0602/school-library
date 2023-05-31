class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date, book, person)
    @date = date

    @book = book
    # book.rentals << self

    @person = person
    # person.rentals << self
  end

  def to_hash
    {
      date: @date,
      book: {
        title: @book.title,
        author: @book.author
      },
      person: {
        id: @person.id,
        age: @person.age,
        name: @person.name
      }
    }
  end
end
