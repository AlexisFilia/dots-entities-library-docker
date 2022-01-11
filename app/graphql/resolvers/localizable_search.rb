module Resolvers
  class LocalizableSearch < Resolvers::BaseSearchResolver
    type [Types::LocalizableType], null: false
    description 'Lists and filters localizables'

    scope { Localizable.all }

    # inline input type definition for the advanced filter
    class LocalizableFilter < Types::BaseInputObject
      argument :OR, [self], required: false
      argument :type_of, String, required: false
      argument :localizable_type, Types::LocalizableEnumType, required: false
      argument :language, String, required: false
      argument :value_contains, String, required: false
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: LocalizableFilter, with: :apply_filter
    # when "pagination" is passed "apply_pagination" would be called to narrow the scope
    option :pagination, type: Pagination, with: :apply_pagination
    # when "order_by" is passed "apply_order_by" would be called to narrow the scope
    option :order_by, type: OrderBy, with: :apply_order_by

    # apply_filter recursively loops through "OR" branches
    def apply_filter(scope, value)
      branches = normalize_filters(value).reduce { |a, b| a.or(b) }
      scope.merge branches
    end

    def normalize_filters(value, branches = [])
      scope = Localizable.all

      scope = scope.where(type_of: value[:type_of]) if value[:type_of]
      scope = scope.where(localizable_type: value[:localizable_type].capitalize) if value[:localizable_type]
      scope = scope.where(language: value[:language].capitalize) if value[:language]
      scope = scope.where('value LIKE ?', "%#{value[:value_contains]}%") if value[:value_contains]

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
end
