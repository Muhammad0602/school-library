require_relative 'spec_helper'

describe Person do
  let(:person) { Person.new(18, 'John Doe') }
  let(:book) { Book.new('Title', 'Author') }

  describe '#initialize' do
    it 'creates a new person with the specified age and name' do
      expect(person.age).to eq(18)
      expect(person.name).to eq('John Doe')
    end

    it 'generates a random ID for the person' do
      expect(person.id).to be_a(Integer)
    end

    it 'sets the parent permission to true by default' do
      expect(person.parent_permission).to be true
    end

    it 'initializes an empty array of rentals' do
      expect(person.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    context 'when the person is of age' do
      let(:person) { Person.new(21, 'Jane Doe') }

      it 'returns true' do
        expect(person.can_use_services?).to be true
      end
    end

    context 'when the person is not of age but has parent permission' do
      let(:person) { Person.new(17, 'John Doe', parent_permission: true) }

      it 'returns true' do
        expect(person.can_use_services?).to be true
      end
    end

    context 'when the person is not of age and does not have parent permission' do
      let(:person) { Person.new(17, 'John Doe', parent_permission: false) }

      it 'returns false' do
        expect(person.can_use_services?).to be false
      end
    end
  end

  describe '#correct_name' do
    it 'returns the correct name' do
      expect(person.correct_name).to eq('John Doe')
    end
  end

  describe '#add_rental' do
    it 'creates a new rental and adds it to the rentals array' do
      rental = person.add_rental('2023-05-31', book)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the person' do
      expected_hash = {
        id: person.id,
        age: person.age,
        name: person.name,
        rentals: []
      }
      expect(person.to_hash).to eq(expected_hash)
    end
  end
end
