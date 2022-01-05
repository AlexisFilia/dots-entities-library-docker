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
      argument :fieldtype_id, GraphQL::Types::ID, required: false, default_value: nil
    end

    def count(args)
      return nil if args[:model].blank?

      args[:model].upcase_first.constantize.count
    end

    def number_of_entity_actions(args)
      return nil if args[:entity_id].blank?

      data = Action.joins(:sections).where(sections: { entity_id: args[:entity_id] })
      if !!args[:is_default] == args[:is_default]
        ids = Entity.find(args[:entity_id]).child_order
        data = data.where(id: ids)
      end
      data.count
    end

    def number_of_entity_fields(args)
      return nil if args[:entity_id].blank?

      data = Field.joins(:sections).where(sections: { entity_id: args[:entity_id] })
      if !!args[:is_default] == args[:is_default]
        ids = Entity.find(args[:entity_id]).child_order
        data = data.where(id: ids)
      end
      data.count
    end

    def number_of_enumeration_members(args)
      return nil if args[:fieldtype_id].blank?

      EnumerationMember.where(fieldtype_id: args[:fieldtype_id]).count
    end
  end
end
