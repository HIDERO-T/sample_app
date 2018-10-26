require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:michael) { FactoryBot.create(:user) }
  let(:archer) { FactoryBot.create(:user) }
  let(:relationship){FactoryBot.create(:relationship,
                                       follower: michael,
                                       followed: archer)}

  subject { relationship }
  it { is_expected.to be_valid }

  context "in case with no follwer_id" do
    before { relationship.follower_id = nil }

    subject { relationship }
    it { is_expected.not_to be_valid }
  end

  context "in case with no followed_id" do
    before { relationship.followed_id = nil }

    subject { relationship }
    it { is_expected.not_to be_valid }
  end
end
