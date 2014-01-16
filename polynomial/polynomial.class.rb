#encoding: utf-8

require_relative '../error/error.class'
require_relative '../vector/vector.class'

class Polynomial
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

  attr_accessor :coef

  # Initialize the polynominal function
  # Its coeficients are 1, 2, 3, 4 ... with '1'x⁰ + '2'x¹ + '3'x² ... = y
  # Each coeficients has an associated value (exemple : 2 => 1 correspond to 1x²)
  #
  # == Notes:
  # The function is compatible with the first version, where coeficients keys are :a, :b, ...
  # == Parameters:
  # hash::
  # hash is a hash which have several keys 1, 2,... which correspond to the coeficients
  def initialize hash={}
    Error.call "Polynomial::new : You hash is invalid" if !hash.is_a?Hash

    hash.select{|k,v| k.to_s.match(/[a-z]/)}.each do |k,v|
      key = (k.to_s.ord - "a".ord)
      hash[key] = v if hash[key] == nil
    end

    @coef = hash.select{|coef,value| coef.is_a?Numeric and coef >= 0 and value.is_a?Numeric}
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

  #TODO : improve this shit
  def to_s
    str = " = y"
    str = "#{@coef[0].to_i}" + str #if @coef[:a]

    @coef.select{|coef,value| coef != 0}.each do |coef,value|
      #sign = "+"
      #sign = "-" if value < 0
      str = "#{value}x^#{coef} + " + str #if value != 0
    end

    return str
  end

  def calc x
    Error.call "Polynomial::calc: x is not a Numeric value" if !x.is_a?Numeric

    y = 0
    @coef.each do |coef,value|
      y += value * x**coef
    end

    return y
  end
end
