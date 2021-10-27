module Types
  class QueryType < Types::BaseObject
    field :datatypes, resolver: Resolvers::DatatypeSearch
    field :enumeration_members, resolver: Resolvers::EnumerationMemberSearch
    field :enums, resolver: Resolvers::EnumSearch
    field :fields, resolver: Resolvers::FieldSearch
    field :actions, resolver: Resolvers::ActionSearch
    field :entities, resolver: Resolvers::EntitySearch
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
  end
end
