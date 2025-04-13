# frozen_string_literal: true

module Petitions
  module List
    class Policy < BasePolicy
      def can_read!
        loudly do
          role?
        end
      end

      private

      def role?
        user_roles_ids.present? && group_roles_ids.present?
      end

      def group_roles_ids
        @group_roles_ids ||= GroupRoleRelation.where(role_id: user_roles_ids).pluck(:group_role_id).uniq
      end

      def user_roles_ids
        @user_roles_ids ||= current_user.roles.ids
      end
    end
  end
end
