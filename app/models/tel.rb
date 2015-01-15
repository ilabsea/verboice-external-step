class Tel
  PREFIXES = ["+855", "855", "0"]

  def initialize number
    @number = number
  end

  def area_code
    area_code = nil

    PREFIXES.each do |prefix|
      prefix_number = @number[0...prefix.length]
      if prefix == prefix_number
        area_code = @number[prefix.length...(prefix.length + 2)]
        break
      end
    end
    
    area_code
  end

  def operator_code
    operator_name = 'other'
    Operator.list.each do |name, area_codes|
      if area_codes.include?(area_code.to_i)
        operator_name = name
        break
      end
    end

    Operator.codes[operator_name]
  end

end