class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  SUMMARY_MAX_LENGTH = 50
  NO_TRANSLATION = {
    en: 'No translation available',
    fr: 'Pas de traduction disponible',
    de: 'Geen vertaling beschikbaar',
    es: 'No hay traducción disponible'
  }

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
    label ? label.value : NO_TRANSLATION[language.to_sym]
  end

  def description(language)
    description ||= localizables.find_by(type_of: 'description', language: language)
    description ? description.value : NO_TRANSLATION[language.to_sym]
  end

  def description_summary(language)
    description ||= localizables.find_by(type_of: 'description', language: language)
    description ? description.value[0...SUMMARY_MAX_LENGTH] : NO_TRANSLATION[language.to_sym]
  end
end
