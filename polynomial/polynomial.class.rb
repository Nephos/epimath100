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
  # Its coeficients are a, b, c, d ... with ax⁰ + bx¹ + cx² +dx³ ... = 0
  # == Parameters:
  # hash::
  # hash is a hash which have several keys :a,:b,... which correspond to the coeficients
  def initialize hash={}
    Error.call "Polynomial::new : You hash is invalid" if !hash.is_a?Hash

    @coef = hash.select{|coef,value| coef.match(/[a-z]/)}
  end

  #calculate the derivated function of the current polynomial
  # == Returns:
  # Polynomial (the derivated function)
  def derive
    dérivé = Polynomial.new

    @coef.select{|coef,value| !coef.match(/[a]/)}.each do |coef,value|
      dérivé_coef = :"#{(coef.to_s.ord - 1).chr}"
      dérivé.coef[dérivé_coef] = value * (coef.to_s.ord - "a".to_s.ord)
    end

    return dérivé
  end

  #TODO : improve this shit
  def to_s
    str = " = y"
    str = "#{@coef[:a].t_i}" + str #if @coef[:a]

    @coef.select{|coef,value| !coef.match(/[a]/)}.each do |coef,value|
      #sign = "+"
      #sign = "-" if value < 0
      str = "#{value}x^#{(coef.to_s.ord - "a".ord).to_i} + " + str #if value != 0
    end

    return str
  end

  def calc x
    Error.call "Polynomial::calc: x is not an integer" if !x.is_a?Numeric
    
    y = 0
    @coef.each do |coef,value|
      y += value * x**(coef.to_s.ord - "a".ord)
    end

    return y
  end
end
