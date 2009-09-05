class ActiveRecord::Base
  def self.human_attribute_name(attribute_key_name)
    default = attribute_key_name.humanize
    if self.const_defined?('HUMANIZED_ATTRIBUTES')
      self.const_get('HUMANIZED_ATTRIBUTES')[attribute_key_name.to_sym] || default
    else
      default
    end
  end

end