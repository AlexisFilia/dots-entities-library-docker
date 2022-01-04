module Types
  class StatisticsType < Types::BaseObject
    field :count, Integer, null: true do
      argument :model, Types::Enum::TableEnumType, required: false, default_value: nil
    end
    field :number_of_entity_fields, Integer, null: true do
      argument :entity_id, GraphQL::Types::ID, required: false, default_value: nil
      argument :is_default, Boolean, required: false, default_value: nil
    end
    field :number_of_entity_actions, Integer, null: true do
      argument :entity_id, GraphQL::Types::ID, required: false, default_value: nil
      argument :is_default, Boolean, required: false, default_value: nil
    end
    field :number_of_enumeration_members, Integer, null: true do
      argument :enum_id, GraphQL::Types::ID, required: false, default_value: nil
    end

    def count(args)
      return nil if args[:model].blank?

      args[:model].upcase_first.constantize.count
    end

    def number_of_entity_fields(args)
      return nil if args[:entity_id].blank?

      data = Field.joins(:section).where(section: { entity_id: args[:entity_id] })
      data = data.where(is_default: args[:is_default]) if !!args[:is_default] == args[:is_default]
      data.count
    end

    def number_of_entity_actions(args)
      return nil if args[:entity_id].blank?

      data = Action.joins(:section).where(section: { entity_id: args[:entity_id] })
      data = data.where(is_default: args[:is_default]) if !!args[:is_default] == args[:is_default]
      data.count
    end

    def number_of_enumeration_members(args)
      return nil if args[:enum_id].blank?

      EnumerationMember.where(enum_id: args[:enum_id]).count
    end
  end
end
