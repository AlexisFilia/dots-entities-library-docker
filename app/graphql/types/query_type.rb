module Types
  class QueryType < Types::BaseObject
    field :all_fieldtypes, resolver: Resolvers::FieldtypeSearch
    field :all_enumeration_members, resolver: Resolvers::EnumerationMemberSearch
    field :all_fields, resolver: Resolvers::FieldSearch
    field :all_actions, resolver: Resolvers::ActionSearch
    field :all_entities, resolver: Resolvers::EntitySearch
    field :all_sections, resolver: Resolvers::SectionSearch
    field :all_composants, resolver: Resolvers::ComposantSearch
    field :all_localizables, resolver: Resolvers::LocalizableSearch
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # GET INFO FROM ONE ELEMENT
    field :fieldtype, FieldtypeType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one fieldtype'
      argument :language, String, required: false
    end

    field :enumeration_member, EnumerationMemberType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one enumeration_member'
      argument :language, String, required: false
    end

    field :action, ActionType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one action'
      argument :language, String, required: false
    end

    field :field, FieldType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one field'
      argument :language, String, required: false
    end

    field :entity, EntityType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one entity'
      argument :language, String, required: false
    end

    field :section, SectionType, null: true do
      argument :id, ID, required: true,
                        description: 'Get the details of one section'
      argument :language, String, required: false
    end

    # GET specials info
    field :stats, StatisticsType, null: true, description: 'Get the statistics of the database'
    field :clean_database, AnswerType, null: true, description: 'Empty the all database'
    field :seed_database, AnswerType, null: true, description: 'Seed the database'

    # Methods

    def fieldtype(arg)
      find_element_and_localizables(arg, 'Fieldtype')
    end

    def enumeration_member(arg)
      find_element_and_localizables(arg, 'EnumerationMember')
    end

    def field(arg)
      find_element_and_localizables(arg, 'Field')
    end

    def action(arg)
      find_element_and_localizables(arg, 'Action')
    end

    def entity(arg)
      find_element_and_localizables(arg, 'Entity')
    end

    def section(arg)
      find_element_and_localizables(arg, 'Section')
    end

    def stats
      {}
    end

    def seed_database
      Rails.application.load_seed
      {
        status: 200,
        message: 'The database is seeded'
        # errors: [],
        # data: []
      }
    end

    def clean_database
      # ActiveRecord::Base.subclasses.each(&:delete_all)
      Rails.application.eager_load!
      ActiveRecord::Base.connection.disable_referential_integrity do
        ApplicationRecord.descendants.each do |model|
          model.delete_all
        end
      end
      {
        status: 200,
        message: 'The database is clean'
        # errors: [],
        # data: []
      }
    end

    def find_element_and_localizables(arg, klass)
      if arg[:language]
        element = klass.constantize.find(arg[:id])
        data = element.attributes
        data[:label] = element.label(arg[:language])
        data[:description] = element.description(arg[:language])
        data[:description_summary] = element.description_summary(arg[:language])
        data[:default_fields] = element.default_fields
        data[:default_actions] = element.default_actions
        data
      else
        klass.constantize.find(arg[:id])
      end
    end
  end
end
