require_relative 'spec_helper'
require 'rental'

RSpec.describe Book do
  let(:book) { Book.new('Title', 'Author') }
  let(:person) { double('Person') }

  describe '#initialize' do
    it 'creates a new book with title and author' do
      expect(book.title).to eq('Title')
      expect(book.author).to eq('Author')
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    it 'creates a new rental and adds it to the rentals array' do
      rental = book.add_rental('2023-05-31', person)
      expect(rental).to be_an_instance_of(Rental)
      expect(book.rentals).to include(rental)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the book' do
      rental = book.add_rental('2023-05-31', person)
      expected_hash = {
        title: 'Title',
        author: 'Author',
        rentals: [rental.to_hash]
      }
      expect(book.to_hash).to eq(expected_hash)
    end
  end
end
