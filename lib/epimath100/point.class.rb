#encoding: utf-8

require 'myerror'

module EpiMath
extend MyError

class Point
  def initialize x, y, z=nil
    MyError::Error.call "Point::new : a passed argument is not a valid number" if (!x.is_a?Numeric or !y.is_a?Numeric or (z != nil and !z.is_a?Numeric))
    @coord = {:x => x.to_f, :y => y.to_f}
    @coord[:z] = z.to_f if z != nil
  end

  def self.new_a p
    MyError::Error.call "Point::new_a : not a valid array of coord" if !p.is_a?Array or p.size < 2
    return Point.new(*p)
  end

  def +(p)
    if p.is_a?Point
      @coord[:x] += p.x
      @coord[:y] += p.y
      @coord[:z] += p.z if p.z or @coord[:z]
    elsif p.is_a?Numeric
      @coord[:x] += p
      @coord[:y] += p
      @coord[:z] += p if @coord[:z]
    else
      MyError::Error.call "Point::+ : passed argument is invalid"
    end
  end

  def *(p)
    MyError::Error.call "Point::* : passed argument is invalid" if !p.is_a?Numeric

    @coord[:x] *= p
    @coord[:y] *= p
    @coord[:z] *= p if @coord[:z]
  end

  def ==(p)
    MyError::Error.call "Point::== : passed argument is invalid" if !p.is_a?Point
    return true if p.x == self.x and p.y == self.y and p.z == self.z
    return false
  end

  def to_s
    str  = "(#{self.x}; #{self.y}"
    str += "; #{self.z}" if self.z
    str += ")"
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

  def x= v
    @coord[:x] = v
  end

  def y= v
    @coord[:y] = v
  end

  def z= v
    @coord[:z] = v
  end

  def self.get_middle(a, b)
    return Point.get_in(a, b, 0.5)
  end

  def self.get_in(a, b, p)
    MyError::Error.call "Point::get_in : an argument is not a Point" if !a.is_a?Point or !b.is_a?Point

    if a.x != b.x and p.is_a?Float and p >= 0 and p <= 1
      coef = ((b.y-a.y) / (b.x-a.x))
      ordonnee = a.y - coef * a.x
      min = [b.x, a.x].min
      max = [b.x, a.x].max
      mid = (max - min) * p
      return Point.new(min + mid, coef * (mid + min) + ordonnee)
    end
    return nil
  end

end
end
