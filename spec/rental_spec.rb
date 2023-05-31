require_relative 'spec_helper'


describe Rental do
    let(:book)  { Book.new('Inferno', 'Del Piero') }
    let(:person) { Person.new(22, 'Muller') }
    let(:date) { '2021/11/12' }
    let(:rental) { Rental.new(date, book, person) }

    it 'creates an instance of the rental' do
        expect(rental).to  be_an_instance_of(Rental)
    end

    it 'checks if the date is correct' do
        expect(rental.date).to eql('2021/11/12'), 'Incorrect rental date'
    end

    it 'checks if the book is correct' do
        expect(rental.book.title).to  eql('Inferno'), 'Incorrect rental book'
    end

    it 'checks if the person is correct' do
        expect(rental.person.age).to eql(22), 'Incorrect rental person'
    end

end
