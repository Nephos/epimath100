#encoding: utf-8

module EpiMath
  EXPOSANT = {"0" => "⁰",
    "1" => "¹",
    "2" => "²",
    "3" => "³",
    "4" => "⁴",
    "5" => "⁵",
    "6" => "⁶",
    "7" => "⁷",
    "8" => "⁸",
    "9" => "⁹"}
  class Function
    def calc x
    end

    def convert_hash hash
      coef = []
      hash.select{|k,v| k.to_s.match(/[a-z]/)}.each do |k,v|
        key = (k.to_s.ord - "a".ord).to_i
        hash[key] = v if hash[key] == nil
      end
      return coef
    end

    def get_degree_max
      return @coef.keys.max
    end

    def get_degree x
      return @coef[x]
    end
  end
end
