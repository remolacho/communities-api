class String
  def clean_identifier
    str = self.strip.downcase
    str.split('.').first
  end

  def to_bool
    return true if self =~ (/(true|t|yes|y|1)$/i)
    return false if self.blank? || self =~ (/(false|f|no|n|0)$/i)

    raise ArgumentError, "invalid value for Boolean: \"#{self}\""
  end
  # END
end
