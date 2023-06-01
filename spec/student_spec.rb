require_relative 'spec_helper'

describe Student do
  let(:age) { 22 }
  let(:classroom) { 'Biology' }
  let(:name) { 'Andreana' }
  let(:student) { Student.new(age, classroom, name) }

  it 'creates an instance of student' do
    expect(student).to be_an_instance_of(Student), 'Incorrect instance of the student'
  end

  it 'checks that the age is correct' do
    expect(student.age).to eql(22), 'Incorrect age of the student'
  end

  it 'checks that the classroom is correct' do
    expect(student.classroom).to eql('Biology'), 'Incorrect classroom of student'
  end

  it 'checks the play_hooky method' do
    expect(student.play_hooky).to eql('¯(ツ)/¯')
  end
end
