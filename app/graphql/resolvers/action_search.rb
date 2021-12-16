module Resolvers
  class ActionSearch < Resolvers::BaseSearchResolver
    type [Types::ActionType], null: false
    description 'Lists and filters actions'

    scope { Action.all }

    # inline input type definition for the advanced filter
    class ActionFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :name, String, required: false
      argument :name_contains, String, required: false
      argument :inverse, String, required: false
      argument :main, String, required: false
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: ActionFilter, with: :apply_filter
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
      scope = Action.all

      scope = scope.where(name: value[:name]) if value[:name]
      scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]
      scope = scope.where(inverse: value[:inverse]) if value[:inverse]
      scope = scope.where(main: value[:main]) if value[:main]

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
end
