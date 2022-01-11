class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def labels(arg)
    labels = localizables.where(type_of: 'label')
    labels = labels.where(language: arg[:language_is]) if arg[:language_is]
    labels
  end

  def descriptions(arg)
    descriptions = localizables.where(type_of: 'description')
    descriptions = descriptions.where(language: arg[:language_is]) if arg[:language_is]
    descriptions
  end

  def label(language)
    label ||= localizables.find_by(type_of: 'label', language: language)
    label ? label.value : nil
  end

  def description(language)
    description ||= localizables.find_by(type_of: 'description', language: language)
    description ? description.value : nil
  end
end
