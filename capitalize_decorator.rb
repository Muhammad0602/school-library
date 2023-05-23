require "./decorator.rb"

class CapitalizeDecorator < Decorator
    def correct_name(nameable)
        @nameable.correct_name.upcase
    end
end