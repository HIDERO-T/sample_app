require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "User model" do
    context "In case of creating factory of User" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "Test data is created" do
        expect(@user).not_to be_nil
      end

      it "should be valid" do
        expect(@user).to be_valid
      end

      it "name should be present" do
        @user.name = " "
        expect(@user).not_to be_valid
      end

      it "email should be present" do
        @user.email = " "
        expect(@user).not_to be_valid
      end

      it "name should not be too long" do
        @user.name = "a" * 51
        expect(@user).not_to be_valid
      end

      it "email should not be too long" do
        @user.email = "a" * 244 + "@example.com"
        expect(@user).not_to be_valid
      end

      it "email validation should accept valid addresses" do
        valid_addresses = %w|user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn|
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end

      it "email validation should reject invalid addresses" do
        invalid_addresses = %w|user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com|
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_addresses
          expect(@user).not_to be_valid
        end
      end

      it "email addresses should be unique" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        expect(duplicate_user).not_to be_valid
      end

      it "password should be present (nonblank)" do
        @user.password = @user.password_confirmation = " " * 6
        expect(@user).not_to be_valid
      end

      it "password should have a minimum length" do
        @user.password = @user.password_confirmation = "a" * 5
        expect(@user).not_to be_valid
      end

      it "authenticated? should return false for a user with nil digest" do
        expect(@user).not_to be_authenticated(:remember, '')
      end

      it "associated microposts should be destroyed" do
        @user.save
        @user.microposts.create!(content: "Lorem ipsum")
        expect{ @user.destroy }.to change{ Micropost.count }.by(-1)
      end
    end
  end

  describe "User#follow, User#unfollow" do
    let(:michael) { FactoryBot.create(:michael) }
    let(:archer) { FactoryBot.create(:archer) }
    
    context "just after initialized, " do
      subject { michael }
      it { is_expected.not_to be_following archer }
    end

    context "when Michael follows Archer, " do
      before { michael.follow archer }

      it "michael shold be following archer" do
        expect(michael).to be_following archer
      end

#       TODO: 本当はit is expected記法に揃えたい。なぜか反応しない。 
#       subject { michael }
#       it { is_expected.to be_following archer }
#       it { is_expected.to respond_to :following? }

      subject { archer.followers }
      it { is_expected.to include michael }

      context "and then, Michael unfollow Archer, " do
        before { michael.unfollow archer }

        subject { michael }
        it { is_expected.not_to be_following archer }
      end
    end
  end


end
