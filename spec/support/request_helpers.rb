module RequestHelpers
  extend ActiveSupport::Concern
  include AuthJwtGo

  def sign_in
    ::Users::BuildJwtService.new(user: current_user).build
  end

  def current_user
    @current_user ||= generate_user
  end

  def user_enterprise_helper
    @user_enterprise ||= FactoryBot.create(:user_enterprise, user_id: user_helper.id, enterprise_id: enterprise_helper.id, active: true)
  end

  def user_helper
    @user_helper ||= FactoryBot.create(:user)
  end

  def enterprise_helper
    @enterprise_helper ||= FactoryBot.create(:enterprise)
  end

  private

  def generate_user
    user_enterprise_helper
    user_helper
  end
end
