require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  let!(:michael) { FactoryBot.create(:user) }
  let!(:michael_post) { FactoryBot.create(:micropost, user: michael) }

  context "when not logged in," do
    let(:empty_session) { {} }

    it "should redirect create to login" do
      post :create, params: {micropost: {content: "Lorem ipsum"}}, session: empty_session
      expect(response).to redirect_to login_url
    end

    it "should reject destroy" do
      expect{
        delete :destroy, params: {id: michael_post.id}, session: empty_session
      }.not_to change { Micropost.count}
    end
  end

  context "when logged in as wrong user" do
    let(:archer) { FactoryBot.create(:archer) }

    it "should reject destroy" do
      expect {
        delete :destroy, params: {id:michael_post.id}, session: {id: archer.id}
      }.not_to change {Micropost.count}
    end
  end


end
