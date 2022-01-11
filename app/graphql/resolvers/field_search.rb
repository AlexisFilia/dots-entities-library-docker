module Resolvers
  class FieldSearch < Resolvers::BaseSearchResolver
    type [Types::FieldType], null: false
    description 'Lists and filters fields'

    scope { Field.all }

    # inline input type definition for the advanced filter
    class FieldFilter < Types::BaseInputObject
      argument :OR, [self], required: false
      argument :name, String, required: false
      argument :name_contains, String, required: false
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: FieldFilter, with: :apply_filter
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
      scope = Field.all

      scope = scope.where(name: value[:name]) if value[:name]
      scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
end
