require './nameable'
require './rental'

class Person < Nameable
  attr_accessor :name, :age, :rentals, :parent_permission
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    super()
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
    # name
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  def to_hash
    {
      id: @id,
      age: @age,
      name: @name,
      rentals: @rentals.map(&:to_hash)
    }
  end

  private

  def of_age?
    age >= 18
  end
end
