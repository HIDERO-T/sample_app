require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "UsersController " do
    before do
      @user = FactoryBot.create(:michael)
      @other_user = FactoryBot.create(:archer)
    end

    # TODO: signup_path to be tested at routing test!!
    it "returns new when called signup" do
      get :new
      expect(response).to render_template :new
    end

    context "when not logged in" do
      before do
        @empty_session = {}
      end

      it "should redirect edit to login" do
        get :edit, params: {id: @user.id}, session: @empty_session
        expect(response).to redirect_to login_path
      end
      
      it "should redirect update to login" do
        get :update, params: {id: @user.id}, session: @empty_session
        expect(response).to redirect_to login_path
      end

      it "should redirect index to login" do
        get :index, params: {id: @user.id}, session: @empty_session
        expect(response).to redirect_to login_path
      end

      it "should redirect destroy to login" do
        get :destroy, params: {id: @user.id}, session: @empty_session
        expect(response).to redirect_to login_path
      end

      it "should redirect following to login" do
        get :following, params: {id: @user.id}, session: @empty_session
        expect(response).to redirect_to login_path
      end

      it "should redirect followers to login" do
        get :followers, params: {id: @user.id}, session: @empty_session
        expect(response).to redirect_to login_path
      end
    end

    context "when logged in as wrong user" do
      before do
        session[:user_id] = @other_user.id
      end

      it "should redirect edit to root" do
        get :edit, params: {id: @user.id}
        expect(response).to redirect_to root_url
      end

      it "should redirect update to root" do
        patch :update, params: {id: @user.id}
        expect(response).to redirect_to root_url
      end
    end

    context "when logged in as a non-admin" do
      before do
        session[:user_id] = @other_user.id
      end

      it "should redirect destroy to root" do
        expect{ delete :destroy, params: {id: @user.id} }.not_to change {User.count}
        expect(response).to redirect_to root_url
      end
    end
  end
end
