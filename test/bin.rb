#!/usr/bin/env ruby
#encoding: utf-8

def test1
  require_relative '../lib/epimath100'
  puts  f = EpiMath100::Polynomial.new([1, 2])
  puts  f.calc 0
  puts  f.calc 1
  puts  f.calc 3

  puts  g = EpiMath100::Rational.new(EpiMath100::Polynomial.new([1, 2]),
                                     EpiMath100::Polynomial.new([1])
                                     )
  puts  g.calc 10
end

def test2
  require "epimath100"
  puts  f = Polynomial.new([1, 2])
  puts  f.calc 10

  puts  g = Rational.new(Polynomial.new([1, 2]),
                                     Polynomial.new([1])
                                     )
  puts  g.calc 10
end

test1()
