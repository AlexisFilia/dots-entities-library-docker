module Resolvers
  class DatatypeSearch < Resolvers::BaseSearchResolver
    type [Types::DatatypeType], null: false
    description "Lists datatypes"

    scope { Datatype.all }
  
    option(:id, type: GraphQL::Types::ID)   { |scope, value| scope.where id: value }
    option(:name, type: String)   { |scope, value| scope.where name: value }
    option(:labels, type: String)   { |scope, value| scope.where labels: value }
    option(:descriptions, type: String)   { |scope, value| scope.where descriptions: value }
    option(:created_at, type: GraphQL::Types::ISO8601DateTime)   { |scope, value| scope.where created_at: value }
    option(:updated_at, type: GraphQL::Types::ISO8601DateTime)   { |scope, value| scope.where updated_at: value }
  
    def resolve
      []
    end

  end
end