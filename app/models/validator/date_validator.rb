module Validator
  class DateValidator < ActiveModel::EachValidator
    # implement the method called during validation
    def validate_each(record, attribute, value)
      raise "#{self.class} require date format options for date " if options[:date_format].nil?

      begin 
        Parser::DateParser.parse(record.send(attribute), options[:date_format])
      rescue
        field = options[:field] || attribute
        record.send("#{field}=",nil);
        record.errors[field] <<  "incorrect format"
      end 
    end
  end
end
