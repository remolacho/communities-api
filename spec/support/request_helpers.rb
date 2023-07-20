module RequestHelpers
  extend ActiveSupport::Concern
  include AuthJwtGo

  def sign_in
    ::Users::BuildJwtService.new(user: current_user).build
  end

  def current_user
    @current_user ||= generate_user
  end

  private

  def generate_user
    FactoryBot.create(:user_enterprise, user_id: user.id, enterprise_id: enterprise.id, active: true)
    user
  end

  def user
    @user ||= FactoryBot.create(:user)
  end

  def enterprise
    @enterprise ||= FactoryBot.create(:enterprise)
  end
end
