#encoding: utf-8

gem 'myerror'
require_relative 'function.class'

module EpiMath100
  class Rational < Function
    attr_accessor :coef, :div, :verbose

    def initialize coef=[], div=[], verb=false
      Error.call "Rational::new : Your coef are invalid" if !coef.is_a?Array
      Error.call "Rational::new : Your divider are invalid" if !div.is_a?Array
      @coef = coef #todo : check each element of the array (hash to use select ?)
      @div = div
      @verbose = verb
    end

    def derive
      return nil
    end

    def to_s
      return ""
    end

    def calc x
      Error.call "Rational::calc: x is not a Numeric value" if !x.is_a?Numeric

      y = 0
      [@coef.size, @div.size].max.times do |coef|
        #calcul
      end

      return y
    end
  end
end
