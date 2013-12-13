#encoding: utf-8

require_relative '../error/error.class'
require_relative '../matrix/matrix.class'

class Vector
  attr_accessor :x, :y, :z, :verbose
  attr_reader :matrix_op
  
  # == Parameters:
  # par1::
  #   The first parameter may be a point coordonate x, or a other Vector.
  #   If it's a Vector, it will be copied. Else if it is anything else, it will be converted as Float and stored as a abcissa.
  # par2,par3::
  #   Theses optionals parameters are used if the first parameter is not a Vector. If it occure, par2 is mandatory (but not par3).
  #   They will be stored in @y and @z.
  # verbose::
  #   verbose turn on/off the messages with translate, rotate, ...
  #
  # == Returns:
  # himself
  #
  # == Errors::
  # If a parameter is invalid, it may be crash the programm with an ERR_HIGH
  def initialize par1, par2=nil, par3=nil, verbose=true
    if par1.is_a?Vector #and par2 == nil and par3 == nil
      @x = par1.x
      @y = par1.y
      @z = par1.z
    elsif par1 != nil and par2 != nil
      if par3 == nil
        par3 = 1.0
      end
      @x = par1.to_f
      @y = par2.to_f
      @z = par3.to_f
    else
      Error.call "The vector couldn't be initialisze with theses parameters : :par1 => '#{par1}', :par2 => '#{par2}'"
    end
    @verbose = verbose
    @matrix_op = init_matrix_op
    return self
  end
  
  # == Returns:
  # Matrix.new [[1, 0, 0],[0, 1, 0], [0, 0, 1]]
  def init_matrix_op
    @matrix_op = Matrix.new [[1, 0, 0],[0, 1, 0], [0, 0, 1]]
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
    elsif par1.is_a?Matrix
        return (self.to_matrix * par1).to_vector
    elsif par1.is_a?Vector
      ary1 = [self.x, self.y]
      if out.z != nil
        ary1 << out.z
      end
      
      ary2 = [par1.x, par1.y]
      if out.z != nil
        ary2 << par1.z
      end
      
      aryr = Matrix.mult_array(ary1, ary2)
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
  # par1, par2::
  #     They are the components of the vector to translate.
  # par3::
  #     Optional component (z)
  # see +::
  def translate par1, par2, par3=0.0
    if !Error.isnum? par1 or !Error.isnum? par2 or !Error.isnum? par3
      Error.call "A parameter to the translation is not a valid number"
    end

    s = Matrix.new [[1.0, 0.0, par1.to_f], [0.0, 1.0, par2.to_f], [0.0, 0.0, 1.0]]
    @matrix_op = s
    cpy = self
    cpy.z = 1.0

    #verbose
    if @verbose
      puts "translation de vecteur #{Vector.new(par1,par2,par3).to_s}"
    end

    return (s * cpy.to_matrix).to_vector
  end
  
  # == Parameters:
  # c1,c2,c3::
  #   c1 and c2 are the coeficiens of the homothetie. c3 is optional
  def homothétie c1, c2, c3=1.0
    if c1 == nil or c2 == nil
      Error.call "Coefficients are invalids"
    end

    s = Matrix.new [[c1.to_f, 0, 0], [0, c2.to_f, 0], [0, 0, c3.to_f]]
    @matrix_op = s
    cpy = self
    cpy.z = 1.0

    #verbose
    if @verbose
      puts "homothétie de rapports #{c1.to_f}, #{c2.to_f}"
    end

    return (s * cpy.to_matrix).to_vector
  end
  
  def rotate a
    if a == nil
      Error.call "Angle is invalid"
    end
    
    rad = Math::PI * a.to_f / 180.0
    cpy = self # copy to have the same value in z
    cpy.z = 0.0
    s = Matrix.new [[ Math.cos(rad), -Math.sin(rad), 0], [Math.sin(rad), Math.cos(rad), 0], [0, 0, 1]]
    @matrix_op = s

    #verbose
    if @verbose
      puts "rotation d'angle #{a.to_f}"
    end

    return (s * cpy.to_matrix).to_vector
  end

  # == Parameters :
  # angle::
  #   It is the incline of the line.
  # == Return value:
  # It returns the vector after the translation.
  def symetric angle
    if !Error.isnum? angle.to_s
      Error.call "Variable angle is not a number (#{angle})", Error::ERR_HIGH
    end

    rad = Math::PI * angle.to_f / 180.0
    s = Matrix.new [[Math.cos(2 * rad), Math.sin(2 * rad), 0], [Math.sin(2 * rad), -Math.cos(2 * rad), 0], [0, 0, 1]]
    @matrix_op = s
    cpy = self.to_matrix

    #verbose
    if @verbose
      puts "symétrie par rapport à un axe incliné de #{angle.to_f} degrés"
    end

    return (s * cpy).to_vector
  end
  
  # == Parameters:
  # dim::
  #   Option option to choose the desired number of dimension of the vector (if is it in 3d, it will be flattened)
  # type:: 
  #   Optional and not used yet. It specify the format of the string. It may only be String yet.
  #
  # == Returns: 
  # String
  def to_s dim=2, type=String
    string = ""
    if type == String
      if @y == nil or dim == 1
        string = "(#{@x.to_f.round(3)})"
      elsif @z == nil or dim == 2
        string = "(#{@x.to_f.round(3)};#{@y.to_f.round(3)})"
      elsif dim == 3
        string = "(#{@x.to_f.roung(3)};#{@y.to_f.round(3)};#{@z.to_f.round(3)})"
      else
        Error.call "Vector::to_s : Invalid number of dimension specified"
      end

    else
      Error.call "Vector::to_s : Invalid type conversion", ERR_LOW
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
end
