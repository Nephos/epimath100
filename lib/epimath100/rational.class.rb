#encoding: utf-8

gem 'myerror'
require_relative 'function.class'

module EpiMath100
  class Rational < Function
    attr_accessor :coef, :div, :verbose

    def initialize coef=[], div=[], verb=false
      Error.call "Polynomial::new : Your coef is invalid" if !coef.is_a?Hash and !coef.is_a?Array

      Error.call "Rational::new : Your divider hash is invalid" if !div.is_a?Hash and !coef.is_a?Array
      coef = convert_hash(coef) if coef.is_a?Hash
      @coef = coef.select{|v| v.is_a?Numeric}
      @div = div.select{|v| v.is_a?Numeric}
      @verbose = verb
    end

    def convert_hash hash
      coef = []
      hash.select{|k,v| k.to_s.match(/[a-z]/)}.each do |k,v|
        key = (k.to_s.ord - "a".ord).to_i
        hash[key] = v if hash[key] == nil
      end
      return coef
    end

    def derive
      return nil
    end

    def to_s
      string = "#{@coef.to_s}\n"
      if @coef.to_s.size >= @div.to_s.size
        string << "_" * @coef.to_s.size
      else
        string << "_" * @div.to_s.size
      end
      string << "\n#{@div.to_s}"
      return string
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

    def get_degree_max
      return @coef.keys.max
    end

    def get_degree x
      return @coef[x]
    end
  end
end
