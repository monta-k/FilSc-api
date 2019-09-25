module AppHelper
  shared_context :authenticated_user do
    let(:auth_user) { create(:user) }
    before do
      allow_any_instance_of(ApplicationController).to receive(:authenticate)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(auth_user)
    end
  end
end