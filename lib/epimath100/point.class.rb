#encoding: utf-8

gem 'myerror'

module EpiMath
class Point
  def initialize x, y, z=nil
    Error.call "Point::new : a passed argument is not a valid number" if (!x.is_a?Numeric or !y.is_a?Numeric or (z != nil and !z.is_a?Numeric))
    @coord = {:x => x.to_f, :y => y.to_f}
    @coord[:z] = z.to_f if z != nil
  end

  def self.new_a p
    Error.call "Point::new_a : not a valid array of coord" if !p.is_a?Array or p.size < 2
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
      Error.call "Point::+ : passed argument is invalid"
    end
  end

  def *(p)
    Error.call "Point::* : passed argument is invalid" if !p.is_a?Numeric

    @coord[:x] *= p
    @coord[:y] *= p
    @coord[:z] *= p if @coord[:z]
  end

  def ==(p)
    Error.call "Point::== : passed argument is invalid" if !p.is_a?Point
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
    Error.call "Point::get_middle : an argument is not a Point" if !a.is_a?Point or !b.is_a?Point

    if a.x != b.x
      coef = ((b.y-a.y) / (b.x-a.x))
      ordonnee = a.y - coef * a.x
      mid = ([b.x, a.x].max - [b.x, a.x].min) / 2.0
      return Point.new(mid, coef * mid + ordonnee)
    end
    return nil
  end

end
end
