#!/usr/bin/ruby
#encoding: utf-8

require_relative '../epimath100/error.class'
require_relative '../epimath100/matrix.class'
require_relative '../epimath100/vector.class'
require_relative '../epimath100/point.class'
require_relative '../epimath100/line.class'
require_relative '../epimath100/polynomial.class'

p = Polynomial.new({0=>-1, 1=>0, 2=>6, 3=>-5, 4=>1})
o = Polynomial.new({0=>0, 1=>0, 2=>0, 3=>0, 4=>0}, true)
puts p
puts o
puts p.coef
puts p.calc 1
