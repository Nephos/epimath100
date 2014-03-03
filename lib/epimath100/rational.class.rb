#encoding: utf-8

gem 'myerror'
require_relative 'function.class'

module EpiMath100
  class Rational < Function
    attr_accessor :verbose

    def initialize poly=Polynomial.new, div=Polynomial.new([1]), verb=2
      Error.call "Rational::new : Your poly are invalid" if !coef.is_a?=Polynomial
      Error.call "Rational::new : Your divider are invalid" if !div.is_a?=Polynomial
      @poly = poly #todo : check each element of the array (hash to use select ?)
      @div = div
      @verbose = verb
    end

    def derive
      return nil
    end

    def to_s
      string = "#{@poly.to_s}\n"
      if @poly.to_s.size >= @div.to_s.size
        string << "-" * @poly.to_s.size
      else
        string << "-" * @div.to_s.size
      end
      string << "\n#{@div.to_s}"
      return string
    end

    def calc x
      Error.call "Rational::calc: x is not a Numeric value" if !x.is_a?Numeric

      y = 0
      [@coef.size, @div.size].max.times do |coef|
        #calcul
      end

      return y
    end

    #accessors
    def poly= p
      Error.call "Rational::new : Your poly are invalid" if !p.is_a?=Polynomial
      @poly = p
    end
    def div= p
      Error.call "Rational::new : Your divider are invalid" if !p.is_a?=Polynomial
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
