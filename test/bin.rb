#!/usr/bin/env ruby
#encoding: utf-8

def test1
  require_relative '../lib/epimath100'
  puts  f = EpiMath::Polynomial.new([1, 2])
  puts  f.calc 0
  puts  f.calc 1
  puts  f.calc 3

  puts  g = EpiMath::Rational.new(EpiMath::Polynomial.new([1, 2]),
                                  EpiMath::Polynomial.new([1])
                                  )
  puts  g.calc 0
  puts  g.calc 1
  puts  g.calc 3
end

def test_line
  require_relative '../lib/epimath100'
  m = EpiMath::Point.get_middle(EpiMath::Point.new(0, 0), EpiMath::Point.new(1,2))
  puts m
end

test_line()
