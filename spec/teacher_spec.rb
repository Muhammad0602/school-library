require_relative 'spec_helper'

describe Teacher do
  let(:age) { 54 }
  let(:specialization) { 'Programmer' }
  let(:name) { 'Ahmad' }
  let(:teacher) { Teacher.new(age, specialization, name) }

  it 'creates an instance of the teacher class' do
    expect(teacher).to be_an_instance_of(Teacher), 'Incorrect instance of the teacher'
  end

  it 'checks that the specialization is correct' do
    expect(teacher.specialization).to eql('Programmer'), 'Incorrect specialization'
  end

  it 'checks if the can_use_services method returns true' do
    expect(teacher.can_use_services?).to be_truthy, 'Incorrect method'
  end
end
