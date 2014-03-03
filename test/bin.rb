#!/usr/bin/env ruby
#encoding: utf-8

require_relative '../lib/epimath100/rational.class'

f = EpiMath100::Polynomial.new([1, 2])
puts f.calc 2221
