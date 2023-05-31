require_relative 'spec_helper'

RSpec.describe Nameable do
  describe '#initialize' do
    it 'creates a new instance of Nameable' do
      nameable = Nameable.new
      expect(nameable).to be_an_instance_of(Nameable)
    end
  end

  describe '#name' do
    it 'returns the correct name' do
      nameable = Nameable.new
      expect(nameable.name).to be_nil
    end
  end
end

RSpec.describe Person do
  let(:person) { Person.new(20, 'John Doe') }
  let(:book) { double('Book') }

  describe '#initialize' do
    it 'creates a new person with age, name, and parent_permission' do
      expect(person.age).to eq(20)
      expect(person.name).to eq('John Doe')
      expect(person.parent_permission).to be_truthy
      expect(person.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    context 'when the person is of age' do
      it 'returns true' do
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when the person is not of age but has parent permission' do
      let(:person) { Person.new(15, 'Jane Doe', parent_permission: true) }

      it 'returns true' do
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when the person is not of age and does not have parent permission' do
      let(:person) { Person.new(15, 'Jane Doe', parent_permission: false) }

      it 'returns false' do
        expect(person.can_use_services?).to be_falsy
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
      expect(rental).to be_an_instance_of(Rental)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the person' do
      rental = person.add_rental('2023-05-31', book)
      expected_hash = {
        id: person.id,
        age: 20,
        name: 'John Doe',
        rentals: [rental.to_hash]
      }
      expect(person.to_hash).to eq(expected_hash)
    end
  end

  describe '#of_age?' do
    context 'when the person is of age' do
      it 'returns true' do
        expect(person.send(:of_age?)).to be_truthy
      end
    end

    context 'when the person is not of age' do
      let(:person) { Person.new(15, 'Jane Doe') }

      it 'returns false' do
        expect(person.send(:of_age?)).to be_falsy
      end
    end
  end
end
