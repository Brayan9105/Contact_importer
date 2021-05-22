RSpec.shared_context "Api::V1 Sign in user" do
  before(:all) do
    @current_user = create(:user)
    @auth_params = @current_user.create_new_auth_token
    sign_in @current_user
  end

  let(:client) { @auth_params['client'] }
  let(:'access-token'){ @auth_params['access-token'] }
  let(:expiry){ @auth_params['expiry'] }
  let(:'token-type'){ @auth_params['token-type'] }
  let(:uid){ @auth_params['uid'] }
  let!(:current_user){ @current_user }
end
