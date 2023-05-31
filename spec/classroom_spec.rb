require_relative 'spec_helper'

describe Classroom do
  let(:classroom) { Classroom.new('Physics') }
  let(:student) { Student.new(18, classroom, 'John Doe') }

  describe '#initialize' do
    it 'creates a new classroom with a label' do
      expect(classroom.label).to eq('Physics')
    end

    it 'initializes an empty array of students' do
      expect(classroom.instance_variable_get(:@students)).to be_empty
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      classroom.add_student(student)
      expect(classroom.students).to include(student)
    end

     it 'sets the classroom for the student' do
      classroom.add_student(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
