module Types
  class QueryType < Types::BaseObject
    field :all_datatypes, resolver: Resolvers::DatatypeSearch
    field :all_enumeration_members, resolver: Resolvers::EnumerationMemberSearch
    field :all_enums, resolver: Resolvers::EnumSearch
    field :all_fields, resolver: Resolvers::FieldSearch
    field :all_actions, resolver: Resolvers::ActionSearch
    field :all_entities, resolver: Resolvers::EntitySearch
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # GET INFO FROM ONE ELEMENT
    field :datatype, DatatypeType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one datatype'
    end

    field :enumeration_member, EnumerationMemberType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one enumeration_member'
    end

    field :enum, EnumType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one enum'
    end

    field :action, ActionType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one action'
    end

    field :field, FieldType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one field'
    end

    field :entity, EntityType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one entity'
    end

    def datatype(arg)
      Datatype.find(arg[:id])
    end

    def enumeration_member(arg)
      EnumerationMember.find(arg[:id])
    end

    def enum(arg)
      Enum.find(arg[:id])
    end

    def field(arg)
      Field.find(arg[:id])
    end

    def action(arg)
      Action.find(arg[:id])
    end

    def entity(arg)
      Entity.find(arg[:id])
    end
  end
end
