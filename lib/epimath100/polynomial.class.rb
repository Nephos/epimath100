#encoding: utf-8

gem 'myerror'
require_relative 'rational.class'

module EpiMath100
  class Polynomial < Rational
    EXPOSANT = {"0" => "⁰",
      "1" => "¹",
      "2" => "²",
      "3" => "³",
      "4" => "⁴",
      "5" => "⁵",
      "6" => "⁶",
      "7" => "⁷",
      "8" => "⁸",
      "9" => "⁹"}

    attr_accessor :coef, :verbose

    # Initialize the polynominal function
    # Its coeficients are 1, 2, 3, 4 ... with '1'x⁰ + '2'x¹ + '3'x² ... = y
    # Each coeficients has an associated value (exemple : 2 => 1 correspond to 1x²)
    #
    # == Parameters:
    # hash::
    #   hash is a hash which have several keys 1, 2,... which correspond to the coeficients
    # verb:: default is false
    #   verb is true or false, or a integer. It will display more information if turned on when to_s.
    #   if it's a integer, it must be in the list :
    #   - 0 : returns ""
    #   - 1 : "y = equation"
    #   - 2 : "f(x) = equation" (like true)
    def initialize coef=[], verb=false
      super(coef, [], verb)
    end

    #calculate the derivated function of the current polynomial
    # == Returns:
    # Polynomial (the derivated function)
    def derive
      dérivé = Polynomial.new

      @coef.select{|coef,value| coef != 0}.each do |coef,value|
        dérivé.coef[coef - 1] = value * coef
      end

      return dérivé
    end

    def to_s
      return "" if @verbose == 0

      str = ""
      str = "#{@coef[0].to_i}" + str #if @coef[:a]

      @coef.select{|coef,value| coef != 0}.each do |coef,value|
        #sign = "+"
        #sign = "-" if value < 0
        str = "#{value}x^#{coef} + " + str if value != 0
      end

      str = "f(x) = " + str if @verbose == true or @verbose == 2
      str = "y = " + str if @verbose == 1

      return str
    end
  end
end
