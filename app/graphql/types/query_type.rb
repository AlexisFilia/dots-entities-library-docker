module Types
  class QueryType < Types::BaseObject
    field :all_fieldtypes, resolver: Resolvers::FieldtypeSearch
    field :all_enumeration_members, resolver: Resolvers::EnumerationMemberSearch
    field :all_fields, resolver: Resolvers::FieldSearch
    field :all_actions, resolver: Resolvers::ActionSearch
    field :all_entities, resolver: Resolvers::EntitySearch
    field :all_sections, resolver: Resolvers::SectionSearch
    field :all_composants, resolver: Resolvers::ComposantSearch
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # GET INFO FROM ONE ELEMENT
    field :fieldtype, FieldtypeType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one fieldtype'
    end

    field :enumeration_member, EnumerationMemberType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one enumeration_member'
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

    field :section, SectionType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one section'
    end

    # GET specials info
    field :stats, StatisticsType, null: true, description: 'Get the statistics of the database'

    # Methods

    def fieldtype(arg)
      Fieldtype.find(arg[:id])
    end

    def enumeration_member(arg)
      EnumerationMember.find(arg[:id])
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

    def section(arg)
      Section.find(arg[:id])
    end

    def stats
      {}
    end
  end
end
