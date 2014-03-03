#encoding: utf-8

gem 'myerror'
require_relative 'function.class'
require_relative 'polynomial.class'

module EpiMath100
  class Rational < Polynomial
    def initialize coef=[], div=[], verb=false
      super(coef, verb)
      Error.call "Rational::new : Your divider hash is invalid" if !div.is_a?Hash and !coef.is_a?Array
      @div = div.select{|v| v.is_a?Numeric}
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
        y += @coef[coef] * x**coef / @div[coef].to_f if @div[coef].to_f != 0
        y += @coef[coef] * x**coef unless @div[coef].to_f != 0
      end

      return y
    end
  end
end
