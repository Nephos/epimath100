#encoding: utf-8

=begin
 Error is a class to display and manage your simple errors 
=end

ERR_HIGH = "Fatal Error"
ERR_MEDIUM = "Error"
ERR_LOW = "Warning"
ERR_COLOR_RED = "0;31"
ERR_COLOR_GREEN = "0;32"
ERR_COLOR_YELLOW = "1;33"
ERR_COLOR_BLUE = "0;34"
ERR_COLOR_ORANGE = "0;33"

class Error
  @@errors = 0
  
  # == Parameters:
  # type:: 
  # ...
  # == Returns: 
  # True/False
  def self.isnum? string
    if string.is_a?String
      if string.to_i.to_s == string or string.to_f.to_s == string
        return true
      else
        return false
      end  
    else
      Error.call "'{string}' is not a String"
      return false
    end
  end
  
  # == Parameters:
  # m::
  #   A String that will be display. You don't need to specify the prefix ("Error :") or the final.
  # level:: 
  #   A optional parameter, wich influence the degree of the error. Default is ERR_HIGH, will kill your programm
  #   So, be carrefull. You can change this value
  #
  # == Returns:
  #   nil
  # call is a function you can acces with Error.call "message", ERR_LEVEL
  # the error's levels are
  # * ERR_HIGH
  # * ERR_MEDIUM
  # * ERR_LOW
  # The level of error influence the color (visibility) and the exit call
  # An ERR_HIGH is only to call exit and stop the programm. So be carrefull.
  # This is the default value, you can change it if yo want
  # def self.call m, level=ERR_MEDIUM
  def self.call m, level=ERR_MEDIUM
    
    if level != ERR_HIGH and level != ERR_MEDIUM and level != ERR_LOW
      self.call "error level invalid", ERR_MEDIUM
    end
    
    #message color
    color = ERR_COLOR_YELLOW
    if level == ERR_HIGH
      color = ERR_COLOR_RED
    elsif level == ERR_MEDIUM
      color = ERR_COLOR_ORANGE
    end
    
    #message display
    if level == ERR_HIGH
      puts "\033[#{color}m#{level} : #{m}.\033[00m"
      exit
    elsif level == ERR_MEDIUM
      puts "\033[#{color}m#{level} : #{m}.\033[00m"
    elsif level == ERR_LOW
      puts "\033[#{color}m#{level} : #{m}.\033[00m"
    end
    
    @@errors += 1
    return self
  end
  
  # Parameters:
  # nothing:; 
  #
  # Returns:
  # Integer which contains the numbr of errors called
  def self.errors
    @@errors
  end
end
