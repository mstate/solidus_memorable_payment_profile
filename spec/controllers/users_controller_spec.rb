require 'spec_helper'

describe Spree::UsersController, type: :controller do

  let(:test_order) { OrderWalkthrough.up_to(:payment) }
  let(:credit_card_payment) { FactoryGirl.create(:credit_card_payment_method) }
  let(:check_payment) { create(:check_payment_method) }


  context "only see credit cards that are remembered in list" do
  end
end
