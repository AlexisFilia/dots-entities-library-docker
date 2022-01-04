module Resolvers
  class ComposantSearch < Resolvers::BaseSearchResolver
    type [Types::ComposantType], null: false
    description 'Lists and filters composants'

    scope { Composant.all }

    # inline input type definition for the advanced filter
    class ComposantFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :code, String, required: false
      argument :code_contains, String, required: false
      argument :field_ids, [ID], required: false
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: ComposantFilter, with: :apply_filter
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
      scope = Composant.all

      scope = scope.where(code: value[:code]) if value[:code]
      scope = scope.where(entity_id: value[:entity_ids]) unless value[:entity_ids].blank?
      scope = scope.where('code LIKE ?', "%#{value[:code_contains]}%") if value[:code_contains]

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
end
