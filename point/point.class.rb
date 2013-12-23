#encoding: utf-8

require_relative '../error/error.class.rb'

class Point
  def initialize x, y, z
    if !x.is_a?Numeric or !y.is_a?Numeric or !z.is_a?Numeric
      Error.call "Point::new : a passed argument is not a valid number"
    end
    @coord = {:x => x.to_f, :y => y.to_f, :z => z.to_f}
  end

  def +(p)
    if p.is_a?Point
      @coord.x += p.x
      @coord.y += p.y
      @coord.z += p.z
    elsif p.is_a?Numeric
      @coord.x += p
      @coord.y += p
      @coord.z += p
    else
      Error.call "Point::+ : passed argument is invalid"
    end
  end

  def *(p)
    if p.is_a?Numeric
      @coord.x *= p
      @coord.y *= p
      @coord.z *= p
    else
      Error.call "Point::+ : passed argument is invalid"
    end
  end

  def x
    @coord[:x]
  end

  def y
    @coord[:y]
  end

  def z
    @coord[:z]
  end
end
