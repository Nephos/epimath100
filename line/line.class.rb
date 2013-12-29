#encoding: utf-8

require_relative '../error/error.class.rb'
require_relative '../point/point.class.rb'
require_relative '../vector/vector.class.rb'

class Line
  attr_reader :point, :v_dir, :equ_para

  # == Parameters:
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
  # == Parameter:
  # p::
  #     p is a Point
  # == Returns:
  # true/false
  def point_owned? p
    if !p.is_a?Point
      Error.call "Line::point_owned? : #{p} is not a valid Point"
    end

    l = parametric()

    ux = (p.x - l[:x][:p]) / l[:x][:v]
    uy = (p.y - l[:y][:p]) / l[:y][:v]
    uz = (p.z - l[:z][:p]) / l[:z][:v]

    if l[:x][:v] == 0 and p.x == l[:x][:p]
      ux = uy  
    end
    
    if l[:y][:v] == 0 and p.y == l[:y][:p]
      uy = uz  
    end
    
    if l[:z][:v] == 0 and p.z == l[:z][:p]
      uz = ux  
    end
    
    if ux == uy and ux == uz
      true
    else
      false
    end
  end

  # == Returns::
  #     same than self.parametric but with the current object
  def parametric
    return Line::parametric @point, @v_dir
  end

  # == Parameters:
  # point::
  #     point is a Point on the line
  # v_dir::
  #     a vector director of the line
  # == Returns:
  # Hash
  def self.parametric point, v_dir
    if !v_dir.is_a?Vector
      Error.call "Line::parametric : Invalid vector"
    elsif !point.is_a?Point
      Error.call "Line::parametric : Invalid point"
    end

    þ = 1
    { :x => { :p => point.x, :v => þ * v_dir.x},
      :y => { :p => point.y, :v => þ * v_dir.y},
      :z => { :p => point.z, :v => þ * v_dir.z}}
  end

  def to_s(options={})
    if options == {}
      "droite passant par le point (#{@point.x};#{@point.y};#{@point.z}), de vecteur directeur #{@v_dir.to_s}"
    else
      Error.call "Line::to_s : options is not valid"
    end
  end

  # This function returns the point which have x, y, or z == v (the first)
  # We choose the first where self.v_dir.n != 0
  # == Parameters:
  # v::
  #     The value defined the point wich will be return.
  # == Returns:
  # A Point where the x, y, or z value is the v specified and ON the line
  def function v
    if self.nil?
      Error.call "Line::function : unable to execute function : the vector v_dir is null"
    end
    
    if @v_dir.x != 0
      return functionx v
    elsif @v_dir.y != 0
      return functiony v
    elsif @v_dir.z != 0
      return functionz v
    end
  end
  
  # This function returns the point which have a x value equal to the specified value.
  # == Parameters:
  # x::
  #     The value defined the point wich will be return.
  # == Returns:
  # A Point where the x value is the x specified and ON the line
  def functionx x
    if !x.is_a?Numeric
      Error.call "Line::functionx : invalid x value"
    elsif @v_dir.x == 0
      Error.call "Line::functionx : unable to calculate this, because v_dir.x == 0"
    end
    
    lp = parametric()
    u = (x - lp[:x][:p]) / lp[:x][:v]
    Point.new(x, lp[:y][:p] + u * lp[:y][:v], lp[:z][:p] + u * lp[:y][:v])
  end
  
  #Same than functionx but from y
  def functiony y
    if !y.is_a?Numeric
      Error.call "Line::functionx : invalid y value"
    elsif @v_dir.y == 0
      Error.call "Line::functionx : unable to calculate this, because v_dir.y == 0"  
    end
    
    lp = parametric()
    u = (y - lp[:y][:p]) / lp[:y][:v]
    Point.new(lp[:x][:p] + u * lp[:x][:v], y, lp[:z][:p] + u * lp[:z][:v])
  end
  
  #Same than functionx but from z
  def functionz z
    if !z.is_a?Numeric
      Error.call "Line::functionx : invalid z value"
    elsif @v_dir.z == 0
      Error.call "Line::functionx : unable to calculate this, because v_dir.z == 0"  
    end
    
    lp = parametric()
    u = (z - lp[:z][:p]) / lp[:z][:v]
    Point.new(lp[:x][:p] + u * lp[:x][:v], lp[:y][:p] + u * lp[:y][:v], z)
  end

end
