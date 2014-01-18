#encoding: utf-8

# Error is a class to display and manage your simple errors
class Error
  ERR_HIGH = "Fatal Error"
  ERR_MEDIUM = "Error"
  ERR_LOW = "Warning"
  ERR_COLOR_RED = "0;31"
  ERR_COLOR_GREEN = "0;32"
  ERR_COLOR_YELLOW = "1;33"
  ERR_COLOR_BLUE = "0;34"
  ERR_COLOR_ORANGE = "0;33"
  @@errors = 0
  
  # The function will check if the specified value can be converted to a Numerical value.
  # == Parameters:
  # type:: 
  # ...
  # == Returns: 
  # True/False
  def self.isnum? string
    if string.is_a?String and string != nil
      if string.to_i.to_s == string or string.to_f.to_s == string
        return true
      elsif string.to_i.to_s == string[1..-1] or string.to_f.to_s == string[1..-1]
        true
      else
        return false
      end
    elsif string.is_a?Numeric
      true
    else
      Error.call "'#{string}' is not a String"
      return false
    end
  end
  
  # "call" is a function you can acces with:
  #     Error.call "message", ERR_LEVEL
  # == The error's levels are :
  # * ERR_HIGH
  # * ERR_MEDIUM
  # * ERR_LOW
  # The error's level influence the color (visibility) and defined if the programm must exit.
  # An ERR_HIGH is only to call exit and stop the programm. So be carrefull.
  # ERR_MEDIUM and ERR_LOW will just display the message and no more.
  # ERR_HIGH is the default value, you can change it if yo want
  # def self.call m, level=ERR_MEDIUM
  #
  # == Parameters:
  # m::
  #   A String that will be display. You don't need to specify the prefix ("Error :") or the final "."
  # level::
  #   A optional parameter, wich influence the degree of the error. Default is ERR_HIGH, will kill your programm
  #   So, be carrefull. You can change this value. It may be ERR_HIGH (Default), ERR_MEDIUM, ERR_LOW
  #
  # == Returns:
  #   nil
  def self.call m, level=Error::ERR_HIGH
    
    if level != Error::ERR_HIGH and level != Error::ERR_MEDIUM and level != Error::ERR_LOW
      self.call "Error::call : error level invalid", Error::ERR_MEDIUM
    end
    
    #message color
    if level == Error::ERR_HIGH
      color = Error::ERR_COLOR_RED
    elsif level == Error::ERR_MEDIUM
      color = Error::ERR_COLOR_ORANGE
    elsif level == Error::ERR_LOW
      color = Error::ERR_COLOR_YELLOW
    end
    
    #message display
    if level == Error::ERR_HIGH
      puts "\033[#{color}m#{level} : #{m}.\033[00m"
      exit
    elsif level == Error::ERR_MEDIUM
      puts "\033[#{color}m#{level} : #{m}.\033[00m"
    elsif level == Error::ERR_LOW
      puts "\033[#{color}m#{level} : #{m}.\033[00m"
    end
    
    @@errors += 1
    return self
  end
  
  # == Parameters:
  # nothing::
  #
  # == Returns:
  # Integer which contains the numbr of errors called
  def self.errors
    @@errors
  end
end
