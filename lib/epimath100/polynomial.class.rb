#encoding: utf-8

gem 'myerror'
require_relative 'function.class'

module EpiMath100
  class Polynomial < Function

    attr_accessor :coef, :verb

    # Initialize the polynominal function
    # Its coeficients are 1, 2, 3, 4 ... with '1'x⁰ + '2'x¹ + '3'x² ... = y
    # Each coeficients has an associated value (exemple : 2 => 1 correspond to 1x²)
    # exemple :
    # a = [] ; a[2] = 1 ; #correspond to 0 + 0x + 2x³
    #
    # == Parameters:
    # coef::
    #   coef is an array which have several keys 0, 1, 2,... which correspond to the coeficients
    # verb:: default is false
    #   It will display more information if turned on when to_s.
    #   It's a integer, it must be in the list :
    #   - 0 : returns ""
    #   - 1 : "y = equation"
    #   - 2 : "f(x) = equation" (default value)
    def initialize coef=[], verb=0
      Error.call "Polynomial::new : Your coef is invalid" if !coef.is_a?Hash and !coef.is_a?Array
      coef = convert_hash(coef) if coef.is_a?Hash
      @coef = coef.select{|v| v.is_a?Numeric}
      @verbose = 2
    end

    #calculate the derivated function of the current polynomial
    # == Returns:
    # Polynomial (the derivated function)
    def derive
      dérivé = Polynomial.new

      if @coef.size > 0
        (1..(@coef.size)).times do |coef|
          dérivé.coef[coef - 1] = dérivé[coef] * coef
        end
      end

      return dérivé
    end

    def to_s
      str = ""
      str = "#{@coef[0].to_i}" + str #if @coef[:a]

      if @coef.size > 0
        (1..(@coef.size)).each do |coef|
          #sign = "+"
          #sign = "-" if value < 0
          str = "#{@coef[coef]}x^#{coef} + " + str if @coef[coef].to_f != 0
        end
      end

      str = "f(x) = " + str     if @verb == 2
      str = "y = " + str        if @verb == 1

      return str
    end

    # Calculate the value of f(x) from x
    def calc x
      y = 0
      [@coef.size].max.times do |coef|
        y += @coef[coef] * x**coef
      end
      return y
    end

  end
end
