require 'spec_helper'

describe Decorator do
  let(:nameable) { 'maximilianus' }
  let(:decorator) { Decorator.new(nameable) }

  it 'creates an instance of decorator' do
    expect(decorator).to be_an_instance_of(Decorator)
  end
end

describe CapitalizeDecorator do
  person = Person.new(22, 'bahir')
  capitalize = CapitalizeDecorator.new(person)

  it 'checks the correct_name method' do
    expect(capitalize.correct_name).to eql('Bahir')
  end
end

describe TrimmerDecorator do
  context 'Checks the trimmer method when the name is more than 10 chars' do
    person = Person.new(34, 'maximilianus')
    trimmer = TrimmerDecorator.new(person)

    it 'returns 10 first chars' do
      expect(trimmer.correct_name).to eql('maximilian')
    end
  end

  context 'Checks the trimmer when name is shorter than 10 chars' do
    person = Person.new(53, 'Luis')
    trimmer = TrimmerDecorator.new(person)

    it 'returns the whole name' do
      expect(trimmer.correct_name).to eql('Luis')
    end
  end
end
