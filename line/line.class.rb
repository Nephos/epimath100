#encoding: utf-8

require_relative '../error/error.class.rb'
require_relative '../vector/vector.class.rb'

class Line
  attr_reader :coord, :v_dir

  def initialize x, y, z, vx, vy, vz
    if !Error.isnum?x or !Error.isnum?y or !Error.isnum?z
      Error.call "Line::new : a passed argument is not a valid number"
    end

    @point = {:x => x.to_f, :y => y.to_f, :z => z.to_f}
    @v_dir = Vector.new vx, vy, vz
    @equ = {:x => 0, :y => 0, :z => 0, :d => 0} # todo : calc that
  end

  def to_s(options={})
    if options == {}
      "droite passant par le point (#{self.x};#{self.y};#{self.z}), de vecteur directeur #{@v_dir.to_s}"
    else
      Error.call "Line::to_s : options is not valid"
    end
  end

  def x
    @point[:x]
  end

  def y
    @point[:y]
  end

  def z
    @point[:z]
  end
end

line = Line.new 1, 2, 3, 1, 1, 1
puts line
puts line.x
puts line.y
puts line.z
