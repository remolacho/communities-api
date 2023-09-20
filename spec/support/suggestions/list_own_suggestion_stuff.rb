shared_context 'list_own_suggestions_stuff' do
  include RequestHelpers

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:suggestions_anonymous) {
    [
      { message: FFaker::Name.first_name * 10, anonymous: true },
      { message: FFaker::Name.first_name * 10, anonymous: true }
    ].map do |data|
      ::Suggestions::CreateService.new(user: user, data: data).call
    end
  }

  let(:suggestions) {
    [
      { message: FFaker::Name.first_name * 10 },
      { message: FFaker::Name.first_name * 10 }
    ].map do |data|
      ::Suggestions::CreateService.new(user: user, data: data).call
    end
  }

  let(:suggestions_readed) {
    [
      { message: FFaker::Name.first_name * 10, read: true },
      { message: FFaker::Name.first_name * 10, read: true }
    ].map do |data|
      ::Suggestions::CreateService.new(user: user, data: data).call
    end
  }

  let(:suggestions_anonymous_readed) {
    [
      { message: FFaker::Name.first_name * 10, read: true, anonymous: true },
      { message: FFaker::Name.first_name * 10, read: true, anonymous: true }
    ].map do |data|
      ::Suggestions::CreateService.new(user: user, data: data).call
    end
  }
end
