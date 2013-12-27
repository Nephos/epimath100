#encoding: utf-8

require_relative '../error/error.class.rb'
require_relative '../point/point.class.rb'
require_relative '../vector/vector.class.rb'

class Line
  attr_reader :point, :v_dir, :equ_para

  # Parameters:
  # x,y,z::
  #     There is the coordonates of the first point [TODO : directly take a point]
  # vx, vy, vz::
  #     The same, but init the line direction vector [TODO : same]
  def initialize x, y, z, vx, vy, vz
    @point = Point.new x, y, z
    @v_dir = Vector.new vx, vy, vz
    @equ_para = Line::parametric @point, @v_dir
  end

  # Check if the point specified is ON the line
  # Parameter:
  # p::
  #     p is a Point
  # Returns:
  # true/false
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

  # TODO : wtf ?
  # Parameters:
  # point::
  #     point is a Point on the line
  # v_dir::
  #     a vector director of the line
  # Returns:
  # Hash 
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
