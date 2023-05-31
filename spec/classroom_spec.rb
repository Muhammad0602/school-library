require_relative 'spec_helper'
require './classroom'
require './student'

RSpec.describe Classroom do
  let(:classroom) { Classroom.new('A') }
  let(:student) { Student.new('John Doe') }

  describe '#initialize' do
    it 'creates a new classroom with a label' do
      expect(classroom.label).to eq('A')
      expect(classroom.instance_variable_get(:@students)).to be_empty
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      classroom.add_student(student)
      expect(classroom.instance_variable_get(:@students)).to include(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end

RSpec.describe Student do
  let(:classroom) { Classroom.new('A') }
  let(:student) { Student.new('John Doe') }

  describe '#initialize' do
    it 'creates a new student with a name' do
      expect(student.name).to eq('John Doe')
      expect(student.classroom).to be_nil
    end
  end

  describe '#classroom=' do
    it 'sets the classroom for the student' do
      student.classroom = classroom
      expect(student.classroom).to eq(classroom)
      expect(classroom.instance_variable_get(:@students)).to include(student)
    end
  end
end
