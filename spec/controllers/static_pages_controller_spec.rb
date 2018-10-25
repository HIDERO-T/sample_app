require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Each action" do
    it "should get home" do
      get :home
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :home
    end

    it "should get help" do
      get :help
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :help
    end

    it "should get about" do
      get :about
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :about
    end

    it "should get contact" do
      get :contact
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :contact
    end
  end

end
