module Steps
  class RandomNumber
    def self.response options={}
      begin
        number = options[:numbers].split(',').sample
        result = number ? number : ""
      rescue
        result = ''
      end
      "{\"result\": \"#{result}\"}"
    end
  end
end
