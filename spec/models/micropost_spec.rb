require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe "Micropost model" do
    before do
      @user = FactoryBot.create(:michael) do |michael|
        @micropost = michael.microposts.create(FactoryBot.attributes_for(:micropost))
      end
    end

    it "should be valid" do
      expect(@micropost).to be_valid
    end

    it "user id should be present" do
      @micropost.user_id = nil
      expect(@micropost).not_to be_valid
    end

    it "content should not be present" do
      @micropost.content = "   "
      expect(@micropost).not_to be_valid
    end

    it "content should be at most characters" do
      @micropost.content = "a" * 141
      expect(@micropost).not_to be_valid
    end

    it "order should be most recent first" do
      pending("Not implemented")
      raise
    end
  end
end

