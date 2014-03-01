#encoding: utf-8

gem 'myerror'
require_relative 'function.class'
require_relative 'polynomial.class'

module EpiMath
  class Rational < Function
    attr_accessor :verbose

    def initialize poly=Polynomial.new, div=Polynomial.new([1]), verb=2
      #Error.call "Rational::new : Your poly are invalid" if !poly.is_a?Polynomial
      Error.call "Rational::new : Your divider are invalid" if !div.is_a?Polynomial
      @poly = poly #todo : check each element of the array (hash to use select ?)
      @poly.verb = 0
      @div = div
      @div.verb = 0
      @verb = verb
    end

    def derive
      return nil
    end

    def to_s
      max_space = [@poly.to_s.size, @div.to_s.size].max
      top_space = (max_space - @poly.to_s.size) / 2
      bot_space = (max_space - @div.to_s.size) / 2

      string =  "       #{" " * top_space}#{@poly.to_s}\n"
      string += "f(x) = #{"-" * max_space}"
      string << "\n       #{" " * bot_space}#{@div.to_s}"
      return string
    end

    def calc x
      Error.call "Rational::calc: x is not a Numeric value" if !x.is_a?Numeric

      p = @poly.calc x
      q = @div.calc x
      return 0 if q == 0
      return p / q
    end

    #accessors
    def poly= p
      Error.call "Rational::new : Your poly are invalid" if !p.is_a?Polynomial
      @poly = p
    end
    def div= p
      Error.call "Rational::new : Your divider are invalid" if !p.is_a?Polynomial
      @div = p
    end
    def poly
      @poly
    end
    def div
      @div
    end

  end
end
