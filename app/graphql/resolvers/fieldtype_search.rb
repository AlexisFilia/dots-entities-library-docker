module Resolvers
  class FieldtypeSearch < Resolvers::BaseSearchResolver
    type [Types::FieldtypeType], null: false
    description 'Lists and filters fieldtypes'

    scope { Fieldtype.all }

    # inline input type definition for the advanced filter
    class FieldtypeFilter < Types::BaseInputObject
      argument :OR, [self], required: false
      argument :type_of, Types::Enum::FieldtypeEnumType, required: false
      argument :name, String, required: false
      argument :name_contains, String, required: false
      argument :labels, String, required: false
      argument :labels_contains, String, required: false
      argument :descriptions, String, required: false
      argument :descriptions_contains, String, required: false
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: FieldtypeFilter, with: :apply_filter
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
      scope = Fieldtype.all

      scope = scope.where(type_of: value[:type_of]) if value[:type_of]
      scope = scope.where(name: value[:name]) if value[:name]
      scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]
      scope = scope.where(labels: value[:labels]) if value[:labels]
      scope = scope.where('labels LIKE ?', "%#{value[:labels_contains]}%") if value[:labels_contains]
      scope = scope.where(descriptions: value[:descriptions]) if value[:descriptions]
      scope = scope.where('descriptions LIKE ?', "%#{value[:descriptions_contains]}%") if value[:descriptions_contains]

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
end
