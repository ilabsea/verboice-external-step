class Date

  DEFAULT_FORMAT = "%d/%m/%Y"

  def less_than_or_equal? date
    self <= date
  end

  def greater_than_or_equal? date
    self >= date
  end

  def between? from_date, to_date
    from_date <= self && self <= to_date
  end

  def to_string format = Date::DEFAULT_FORMAT
    self.strftime(format)
  end
end
