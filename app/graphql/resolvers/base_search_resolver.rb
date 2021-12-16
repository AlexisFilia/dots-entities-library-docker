module Resolvers
  class BaseSearchResolver < GraphQL::Schema::Resolver
    require 'search_object'
    require 'search_object/plugin/graphql'
    include SearchObject.module(:graphql)

    # inline input type definition for the pagination
    class Pagination < ::Types::BaseInputObject
      argument :first, Integer, required: false
      argument :skip, Integer, required: false
    end

    # inline input type definition for the order_by
    class OrderBy < ::Types::BaseInputObject
      argument :order_by, String, required: false
      argument :direction, Types::DirectionEnumType, required: false
    end

    def apply_pagination(scope, value)
      normalize_pagination(value, scope).reduce { |a, b| a.or(b) }
    end

    def apply_order_by(scope, value)
      normalize_order_by(value, scope).reduce { |a, b| a.or(b) }
    end

    def normalize_pagination(value, scope, branches = [])
      scope = scope.limit(value[:first]) if value[:first]
      scope = scope.offset(value[:skip]) if value[:skip]

      scope.merge branches

      branches << scope
    end

    def normalize_order_by(value, scope, branches = [])
      unless value[:order_by].blank? || value[:direction].blank?
        scope = scope.order(value[:order_by] => value[:direction])
      end

      scope.merge branches

      branches << scope
    end
  end
end
