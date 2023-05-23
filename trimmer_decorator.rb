require "./decorator.rb"

class TrimmerDecorator < Decorator
    def correct_name
      if  @nameable.correct_name.length < 10
        @nameable.correct_name
      else
        @nameable.correct_name.slice(0, 10)
      end
    end
end
