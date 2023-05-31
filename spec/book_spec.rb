require_relative 'spec_helper'

RSpec.describe Book do
  let(:book) { Book.new('Title', 'Author') }

  describe '#add_rental' do
    it 'creates a new rental and adds it to the rentals array' do
      date = '2023-05-31'
      person = instance_double('Person')
      rental = book.add_rental(date, person)
      
      expect(rental).to be_a(Rental)
      expect(book.rentals).to include(rental)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the book' do
      rental = instance_double('Rental', to_hash: { date: '2023-05-31' })
      book.rentals << rental
      
      hash = book.to_hash
      
      expect(hash).to be_a(Hash)
      expect(hash[:title]).to eq('Title')
      expect(hash[:author]).to eq('Author')
      expect(hash[:rentals]).to include(rental.to_hash)
    end
  end
end
