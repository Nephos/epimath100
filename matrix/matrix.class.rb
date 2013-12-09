#encoding: utf-8

=begin
 ------ DOCUMENTATION ------
 
 columns() => return the number of columns
 lines() => ...
 
 to_s(Integer/String/) => return a readable string
 to_ary() => return an array
 
 new_line([]/) => make a new line. Arguments : An Array with the good values (and plz the good size)
 new_column([]/) => ...
 
 del_line(Integer/) => delete a line properly (by default the last line)
 TODO : del_column(Integer/) => ...
 
 [] => ???
 
 get_val(Integer,Integer) => return the value of the element [x][y]
 set_val(Integer,Integer) => set the value of the element [x][y]
 
 get_line(Integer,Integer) => return to an Array with all values in the line x
 get_column(Integer,Integer) => ...
 
 have_the_same_dimensions(Matrix) => Check if the matrix have the same dimensions than the argument (Matrix)
 mult_arry(Array,Array) => does a multiplication between two arrays of integer. Arrays must have the same size.
 
 * => Multiplie with an integer or a other Matrix
 + => Addition with a other Matrix (or an Integer, which is added to all element of the Matrix)
 get_deter() => get the determinant of te matrix (ONLY WORKS WITH A 2x2 !!!)
=end

require_relative '../error/error.class'

class Matrix
  attr_reader :columns, :lines, :v 
  
  # == Parameters:
  # tab::
  #   tab is a double Array like [ [1,2], [3,4], [1,4] ]. This array should be a valid Matrix tab or an other Matrix
  #
  # == Returns:
  #   nothing
  def initialize tab=[[]]
    @v = tab
    @columns = 0
    @lines = 0

    if tab.is_a?Array and tab.size > 0 and tab[0].is_a?Array
      @columns = tab[0].size
      
      # check if the line have the good size
      tab.size.times do |i|
        @lines += 1
        if (tab[i].size != @columns)
          Error.call "'#{tab[i]}' is not a valid line"
        end
        
      end
    elsif tab.is_a?Matrix
      @v = tab.v
      @columns = tab.columns
      @lines = tab.lines
    else
      Error.call "'#{tab}' is not a valid matrix"
    end
    return
  end
  
  def to_s(type=String)
    out = ""
    
    @v.each do |line|
      out << "["
      
      # display all elements of this line
      line.each do |element|
        if (type == Integer)
          if (element.is_a?(String))
            out << element.ord.to_s << " "
          else
            out << element.to_s << " "
          end
        else
          out << element.to_s << " "
        end
      end
    
      out << "\b]\n" # TODO : FIX THAT broggi_t
    end
    out
  end
  
  def to_ary
    @v
  end
  
  def new_line tab=[]
    @lines += 1
    @v << tab
  end
  
  def new_column tab=[]
    @columns += 1
    if tab.is_a? Array and tab.size == @lines
      @lines.times do |i|
        @v[i] << tab[i]
      end
    else
      @lines.times do |i|
        @v[i] << 0
      end
    end
  end
  
  def del_line x=-1
    if x.is_a?Integer and @v[x] != nil
       @lines -= 1
       @v.delete_at x
     else
       Error.call "Line '#{x}' doesn't exist"
    end
  end
  
  #... ? i don't know if it works
  # == DO NOT USE THIS
  def [](x)
    if x.is_a?Integer
      return @v[x]
    else
      Error.call "'#{x}' is not a correct line"
    end
  end
  
  def get_val x, y
    if !x.is_a?Integer
      Error.call "'#{x}' is not a correct line"
      return nil
    elsif !y.is_a?Integer
      Error.call "'#{y}' is not a correct column"
      return nil
    elsif x < 0 or y < 0 or x >= @lines or y >= @columns
      Error.call "The specified positions are invalids (#{x},#{y})"
      return nil
    else
      return @v[x][y]
    end
  end

  def set_val val, x, y
    if !x.is_a?Integer
      Error.call "'#{x}' is not a correct line"
      return nil
    elsif !y.is_a?Integer
      Error.call "'#{y}' is not a correct column"
      return nil
    elsif x < 0 or y < 0 or x >= @lines or y >= @columns
      Error.call "The specified positions are invalids (#{x} >= #{@lines},#{y} >= #{@columns}) #{self.to_s}"
      return nil
    else
      @v[x][y] = val
      return @v[x][y]
    end
  end
  
  def get_line x
    if !x.is_a?Integer or x < 0 or x >= @lines
      Error.call "Line #{x} doesn't exist"
      return nil
    end
    
    return @v[x]
  end
  
  def get_column y
    if !y.is_a?Integer or y < 0 or y >= @columns
      Error.call "Column #{y} doesn't exist"
      return []
    end
    
    result = []
    @lines.times do |i|
      result << @v[i][y]
    end
    return result
  end
  
  def have_the_same_dimensions matrix
    if (matrix.is_a? Matrix and matrix.columns == @columns and matrix.lines == @lines)
      true
    else
      false
    end
  end
  
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
  # matrix::
  #   This argument is a Matrix or an Integer.
  #   If it's a Matrix, it will do matrix product.
  #   Else, if it's a integer, it will multiply each coeficient of the current Matrix.
  #
  # == Returns:
  # Matrix
  #
  # == Matrix_Product:
  # little explanation::
  #   If matrix is a Matrix, we will multiply 2by2 each coeficient of the column X of the current Matrix and the line X of matrix.
  #   Then, we do the sum of them and we put it in a new Matrix at the position X. The is just a sum up, view the details on wiki bitch.
  def *(matrix)
    #produit matriciel
    if matrix.is_a?Matrix
      if @columns != matrix.lines
        Error.call "Invalid multiplication at line #{matrix.lines} and column #{@columns}"
        return nil
      end
      
      result = []
      @lines.times do |i|
        result << []
      end
      #colonne de resultat = colonne de matrix X
      #ligne de resutlat = ligne de self Y
      @lines.times do |y|
        matrix.columns.times do |x|
          result[y][x] = mult_array(get_line(y), matrix.get_column(x))
        end
      end
      
      return Matrix.new result
    #produit d'un entier et d'une matrix
    elsif matrix.is_a? Integer or matrix.is_a? Float 
      result = @v
      @lines.times do |x|
        @columns.times do |y|
          result[x][y] = result[x][y].to_f * matrix
        end
      end
    return Matrix.new result
    #message d'erreur
    else
      Error.call "Impossible de calculer cela"
      return nil
    end
  end
  
  # == Parameters:
  # matrix:: 
  #   This argument is a Matrix or an Integer. If it's a Matrix, it must have the same dimensions than the current Matrix.
  #   Else, if it's a integer, it will be added to each coeficients of the current Matrix.
  #
  # == Returns:
  # Matrix
  def +(matrix)
    result = @v
    if have_the_same_dimensions matrix
      @lines.times do |x|
        @columns.times do |y|
          result[x][y] += matrix.v[x][y]
        end
      end
    elsif matrix.is_a?Integer
      @lines.times do |x|
        @columns.times do |y|
          result[x][y] += matrix
        end
      end
    else
      Error.call "Impossible de calculer cela"
      result
    end
    Matrix.new result
  end
  
  def get_deter
    if @columns != 2 or @lines != 2
      Error.call "This error comes from get_deter which works only with 2x2 matrix"
    end
    
    det = get_val(0, 0).to_i * get_val(1, 1).to_i
    det -= get_val(0, 1).to_i * get_val(1, 0).to_i
    
    if det == 0
      Error.call "The matrix cannot be reversed (det = 0)"
    end
    
    return det
  end
  
end
