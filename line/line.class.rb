#encoding: utf-8

require_relative '../error/error.class.rb'
require_relative '../point/point.class.rb'
require_relative '../vector/vector.class.rb'

class Line
  attr_reader :point, :v_dir, :equ_para

  def initialize x, y, z, vx, vy, vz
    @point = Point.new x, y, z
    @v_dir = Vector.new vx, vy, vz
    @equ_para = Line::parametric @point, @v_dir
  end

  def point_owned? p
    if p.is_a?Point
      if Line::parametric(p, @v_dir) == Line::parametric(@point, @v_dir)
        true
      else
        false
      end
    else
      false
    end
  end

  def self.parametric point, v_dir
    if !v_dir.is_a?Vector
      Error.call "Line::parametric : Invalid vector"
    elsif !point.is_a?Point
      Error.call "Line::parametric : Invalid point"
    end

    þ = 1 / v_dir.x
    { :x => point.x + þ * v_dir.x,
      :y => point.y + þ * v_dir.y,
      :z => point.z + þ * v_dir.z}
  end

  def to_s(options={})
    if options == {}
      "droite passant par le point (#{@point.x};#{@point.y};#{@point.z}), de vecteur directeur #{@v_dir.to_s}"
    else
      Error.call "Line::to_s : options is not valid"
    end
  end
end

line = Line.new 1, 2, 3, 1, 1, 1
puts line
