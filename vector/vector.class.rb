#encoding: utf-8

=begin
        This is a class
=end

require_relative '../error/error.class'
require_relative '../matrix/matrix.class'

class Vector
  attr_accessor :x, :y, :z
  
  # == Parameters:
  # par1::
  #   The first parameter may be a point coordonate x, or a other Vector.
  #   If it's a Vector, it will be copied. Else if it is anything else, it will be converted as Float and stored as a abcissa.
  # par2,par3::
  #   Theses optionals parameters are used if the first parameter is not a Vector. If it occure, par2 is mandatory (but not par3).
  #   They will be stored in @y and @z.
  #
  # == Returns:
  # himself
  #
  # == Errors::
  # If a parameter is invalid, it may be crash the programm with an ERR_HIGH
  def initialize par1, par2, par3=nil
    if par1.is_a?Vector #and par2 == nil and par3 == nil
      @x = par1.x
      @y = par1.y
      @z = par1.z
    elsif par1 != nil and par2 != nil
      @x = par1.to_f
      @y = par2.to_f
      @z = par3.to_f
    else
      Error.call "The vector couldn't be initialisze with theses parameters : :par1 => '#{par1}', :par2 => '#{par2}'"
    end
    return self
  end
  
  # TODO : cp doc from matrix
  def mult_array(t1, t2)
    if (!t1.is_a?Array or !t2.is_a?Array)
      Error.call "Can't multiply this. One of the arguments is not an array."
    elsif (t1.size != t2.size)
      Error.call "Can't multiply this. Arrays do not have the same size."
    end
    
    result = 0
    t1.size.times do |i|
      result = (result + t1[i].to_f * t2[i].to_f).to_f
    end
    return result
  end
  
  # == Parameters:
  # par1::
  #   It may be a point coordonate x, or a other Vector.
  #   If it's a Vector, it will be used as a couple of coordonates. Else if it is anything else, it will be converted as Float added to @x
  #
  # == Returns:
  # nothing
  #
  # == Errors:: 
  # If a parameter is invalid, it may be crash the programm with an ERR_HIGH
  # If the vectors do not have the same dimensions, it will display a warning
  def +(par1)
    out = Vector.new(self)

    if par1 != nil and par1.is_a?Vector #and par2 == nil and par3 == nil
      out.x += par1.x
      out.y += par1.y
      
    elsif par1 != nil
      par1 = par1.to_f
      out.x += par1
      out.y += par1
      
      if out.z != nil and par1 == nil
        Error.call "The vector #{Vector.new(par1, par1, par1).to_s} do not have the same dimensions than #{out.to_s}", ERR_LOW
      elsif out.z != nil
        out.z += par1
      end
    else
      Error.call "The vector couldn't be added with this parameters : #{par1}"
    end
    return out
  end
  
  # == Usage:
  # It is simply like + buf multiply by -1 par1
  def -(par1)
    if par1 == nil
      Error.call "Can't sub nil from vector"
    end
    return (self.+(par1 * -1))
  end
  
  # == Parameters:
  # par1:
  #     This parameter may be a Vector or a number. If it's a Number, it will multiply all coponents of the Vector.
  #     If it's an other vector, we will multiplie their components 2by2
  # == Returns:
  # Vector
  def *(par1)
    out = Vector.new(self)
    if par1.is_a?Numeric
      out.x *= par1
      out.y *= par1
      if out.z != nil
        out.z *= par1
      end
      
    elsif par1.is_a?Vector
      ary1 = [self.x, self.y]
      if out.z != nil
        ary1 << out.z
      end
      
      ary2 = [par1.x, par1.y]
      if out.z != nil
        ary2 << par1.z
      end
      
      aryr = mult_array(ary1, ary2)
      out.x = aryr[0]
      out.y = aryr[1]
      if aryr[2] != nil
        out.z = aryr[2]
      end
    else
      Error.call "Unable to add '#{par1} to this vector", ERR_LOW  
    end
    return out
  end
  
  # == Parameters:
  # c1,c2,c3::
  #   c1 and c2 are the coeficiens of the homothetie. c3 is optional
  def homothétie c1, c2, c3=nil
    if c1 == nil or c2 == nil
      Error.call "Coefficients invalids"
    end
    hømø = nil
    if c3 == nil or @z == nil
      hømø = Matrix.new [[c1, 0], [0, c2]]
    else
      hømø = Matrix.new [[c1, 0, 0], [0, c2, 0], [0, 0, c3]]
    end
    return (hømø * self.to_matrix)
  end
  
  def rotate a
    if a == nil
      Error.call "Angle invalid"
    end
    a = Math::PI * a / 180.0
    røt = nil
    if @z == nil
      røt = Matrix.new [[Math.cos(a), -Math.sin(a)],[Math.sin(a), Math.cos(a)]]
    else
      røt = Matrix.new [[1, 0, 0], [0, Math.cos(a), -Math.sin(a)], [0, Math.sin(a), Math.cos(a)]]
    end
    return (røt * self.to_matrix)
  end
  
  # see +:: 
  def translate par1
    return (self+par1)
  end
  
  # == Parameters:
  # type:: 
  #   Optional and not used yet. It specify the format of the string. It may only be String yet.
  #
  # == Returns: 
  # String
  def to_s type=String
    string = ""
    if type == String
      if @z == nil
        string = "(#{@x};#{@y})"
      else
        string = "(#{@x};#{@y};#{@z})"
      end
    else
      Error.call "Invalid type conversion", ERR_LOW
    end
    return string
  end
  
  # == Parameters:
  # type:: 
  #   Optionnal. It specify the format of the array returned. It may be "h" (1) or "w" (0).
  #   * If it's "w" or 0, the Array will be [x,y]
  #   * If it's "h" or 1, the Array returned will be [[x],[y]]
  #
  # == Returns: 
  # Array or an Array of Array
  def to_ary type=0
    array = []
    if type == 0 or type == "w" # everytime true... for the moment
      array << @x << @y
      if @z != nil
        array << @z
      end
    else
      array << [@x] << [@y]
      if @z != nil
        array << [@z]
      end
    end
    return array
  end
  
  # == Parameters::
  # Nothing 
  #
  # == Returns: 
  # Matrix
  def to_matrix
    return Matrix.new self.to_ary(1)
  end
  
  # == Parameters:
  # type:: 
  #   It specify the return. It may be String or Array.
  #
  # == Returns: 
  # String, Array, nil (see type::)
  #
  # == Errors: 
  # nil return occures only if the parameter types:: is not supported. 
  def to_a type=String
    if type == String
      return self.to_s
    elsif type == Array
      return self.to_ary
    elsif type == Matrix
      return self.to_matrix
    else
      return nil
    end
  end

  def symetric vector, angle
    if !Error.isnum angle
      Error.call "Variable angle is not a number (#{angle})", ERR_HIGH
    end
    if !vector.is_a?Vector
      Error.call "Variable vectore is not a correct vector (#{vector})", ERR_HIGH
    end
    angle = Math::PI * angle / 180.0
    S = Matrix.new [[Math.cos(2 * angle), Math.sin(2 * angle)], [Math.sin(2 * angle), - Math.cos(2 * angle)]];
    return vector.to_matrix * S
  end
end
