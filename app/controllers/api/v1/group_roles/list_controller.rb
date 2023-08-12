class Api::V1::GroupRoles::ListController < ApplicationController

  # GET /:enterprise_subdomain/v1/group_roles/list
  def index
    render json: { success: true, data: serializer }
  end

  private

  def serializer
    ActiveModelSerializers::SerializableResource.new(GroupRole.all_actives_petitions,
                                                     each_serializer: ::GroupRoles::DetailSerializer).as_json

  end
end
