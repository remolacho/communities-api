# frozen_string_literal: true

module Enterprises
  module Profile
    class Policy < BasePolicy
      def can_read!
        loudly do
          role?
        end
      end

      private

      def role?
        group_role.present? && !group_role_relations.zero?
      end

      def group_role_relations
        @group_role_relations ||= group_role.group_role_relations.where(role_id: user_roles_ids).count
      end

      def group_role
        @group_role ||= GroupRole.find_by(code: :show_enterprise, entity_type: Enterprise::ENTITY_TYPE)
      end

      def user_roles_ids
        @user_roles_ids ||= current_user.roles.ids
      end
    end
  end
end
