#encoding: utf-8

gem 'myerror'
require_relative 'point.class.rb'
require_relative 'vector.class.rb'

module EpiMath
class Line
  attr_reader :point, :v_dir, :equ_para

  # == Parameters:
  # point::
  #     Any point on the line. It must be a Point (../point/point.class.rb)
  # vector::
  #     Any vector director of the line. It must be a Vector (../vector/vector.class.rb)
  def initialize point, vector
    Error.call "Line::new : '#{point}' is not a Point" if !point.is_a?Point
    Error.call "Line::new : '#{vector}' is not a Vector" if !vector.is_a?Vector
    Error.call "Line::new : '#{vector}' can't be Null" if vector.nil?

    @point = point
    @v_dir = vector
    @equ_para = Line::parametric @point, @v_dir
  end

  # TODO : fix if if if if if
  # Check if the point specified is ON the line
  # == Parameter:
  # p::
  #     p is a Point
  # == Returns:
  # true/false
  def point_owned? p
    Error.call "Line::point_owned? : #{p} is not a valid Point" if !p.is_a?Point

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
    Error.call "Line::parametric : Invalid vector" if !v_dir.is_a?Vector
    Error.call "Line::parametric : Invalid point" if !point.is_a?Point

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

  # This function returns the point on the line where x = v * vx + px, ...
  # == Parameters:
  # v::
  #     The value defined the point wich will be return.
  # == Returns:
  # The choosed Point one the line from v (lambda)
  def function v
    Error.call "Line::function : unable to execute function : the vector v_dir is null" if self.nil?
    Error.call "Line::functionx : invalid lambda ( #{v} ) value" if !v.is_a?Numeric

    lp = parametric()
    Point.new(lp[:x][:p] + v * lp[:x][:v], lp[:y][:p] + v * lp[:y][:v], lp[:z][:p] + v * lp[:z][:v])
  end

end
end
