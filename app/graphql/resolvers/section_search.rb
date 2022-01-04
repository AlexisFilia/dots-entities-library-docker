module Resolvers
  class SectionSearch < Resolvers::BaseSearchResolver
    type [Types::SectionType], null: false
    description 'Lists and filters sections'

    scope { Section.all }

    # inline input type definition for the advanced filter
    class SectionFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :entity_id, ID, required: false
      argument :element_type, Types::Enum::SectionTypeEnumType, required: false
      argument :name, String, required: false
      argument :name_contains, String, required: false
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: SectionFilter, with: :apply_filter
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
      scope = Section.all

      scope = scope.where(entity_id: value[:entity_id]) if value[:entity_id]
      scope = scope.where(element_type: value[:element_type]) if value[:element_type]
      scope = scope.where(name: value[:name]) if value[:name]
      scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
end
