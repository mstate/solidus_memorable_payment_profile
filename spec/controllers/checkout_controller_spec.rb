require 'spec_helper'

describe Spree::CheckoutController, type: :controller do

  # before(:each) do
  #   stub_authentication!
  #   Spree::Config[:track_inventory_levels] = false
  #   country_zone = create(:zone, name: 'CountryZone')
  #   @state = create(:state)
  #   @country = @state.country
  #   country_zone.members.create(zoneable: @country)
  #   create(:stock_location)

  #   @shipping_method = create(:shipping_method, zones: [country_zone])
  #   @default_payment_method = create(:credit_card_payment_method)
  #   @memorable_payment_method = create(:memorable_payment_method)
  #   @forgettable_payment_method = create(:forgettable_payment_method)
  # end

  # after do
  #   Spree::Config[:track_inventory_levels] = true
  # end


  # context "PUT 'update'" do
  #   let(:order) do
  #     order = create(:order_with_line_items)
  #     # Order should be in a pristine state
  #     # Without doing this, the order may transition from 'cart' straight to 'delivery'
  #     order.shipments.delete_all
  #     order
  #   end

  #   before(:each) do
  #     allow_any_instance_of(Order).to receive_messages(payment_required?: true)
  #   end




# let(:credit_cart_payment) { create(:credit_card_payment_method) }

#     let(:token) { 'some_token' }
#     let(:user) { create(:user) }
#     let(:order) { FactoryGirl.create(:order_with_totals) }

#     let(:address_params) do
#       address = FactoryGirl.build(:address)
#       address.attributes.except("created_at", "updated_at")
#     end

#     before do
#       allow(controller).to receive_messages try_spree_current_user: user
#       allow(controller).to receive_messages spree_current_user: user
#       allow(controller).to receive_messages current_order: order
#       # order.update_column(:state, "delivery")
#       # shipment = create(:shipment, order: order)
#       # shipment.refresh_rates
#       # shipping_rate = shipment.shipping_rates.where(selected: false).first
#       order.update_column(:state, "payment")
#       allow_any_instance_of(Spree::PaymentMethod::BogusCreditCard).to receive(:source_required?).and_return(false)    end

#     let(:order) { create(:order_with_line_items) }
#     let(:payment_method) { create(:credit_card_payment_method) }

#     context "payment" do
#       context "with remember_when_unspecified = true" do
#         it "should return payment methods that don't respond to memorable" do
#           binding.pry
#         end
#       end
#     end
#     it "should pass something" do
#       expect(true).to be true
#     end
#   end

  let(:test_order) {
    order = OrderWalkthrough.up_to(:payment)
    order.user = create(:user)
    if order.respond_to?(:recalculate)
      order.recalculate
    else
      order.update!
    end
    order
  }
  let(:test_user) { test_order.user }
  let(:credit_card_payment) { FactoryGirl.create(:credit_card_payment_method) }
  let(:check_payment) { create(:check_payment_method) }


  context "when all wallet payment methods don't support are not memorable" do


    after do
      Capybara.ignore_hidden_elements = true
    end

    before(:all) do
      Spree::CreditCard.destroy_all
      Spree::WalletPaymentSource.destroy_all
      Capybara.ignore_hidden_elements = false
    end

    after(:each) do
      test_order.user.wallet_payment_sources.destroy_all
      test_order.user.credit_cards.destroy_all
    end

    after(:all) do
      # reset preference to default state
      SolidusMemorablePaymentProfile::Configuration.new.remember_when_unspecified = SolidusMemorablePaymentProfile::Configuration.new.preferred_remember_when_unspecified_default
    end

    before(:each) do
      allow(test_order).to receive_messages(available_payment_methods: [ check_payment, credit_card_payment ])
      allow_any_instance_of(Spree::CheckoutController).to receive_messages(current_order: test_order)
      allow_any_instance_of(Spree::CheckoutController).to receive_messages(try_spree_current_user: test_order.user)
    end

    it "should show all payment methods that are not memorable" do
      # visit spree.checkout_state_path(:payment)

      2.times { test_order.user.wallet.add(create(:forgettable_credit_card)) }
      3.times { test_order.user.wallet.add(create(:memorable_credit_card)) }

      get :edit, params: { state: "payment" }

      expect(assigns(:order).state).to eq("payment")

      expect(assigns(:wallet_payment_sources).size).to eq(3)
    end

    # it "should not show all credit cards that are not memorable if remember_when_unspecified is false" do
    #   SolidusMemorablePaymentProfile::Configuration.new.remember_when_unspecified = false

    #   test_order.user = create(:user)
    #   if test_order.respond_to?(:recalculate)
    #     test_order.recalculate
    #   else
    #     test_order.update!
    #   end


    #   allow(test_order).to receive_messages(available_payment_methods: [ credit_card_payment ])
    #   allow_any_instance_of(Spree::CheckoutController).to receive_messages(current_order: test_order)
    #   allow_any_instance_of(Spree::CheckoutController).to receive_messages(try_spree_current_user: test_order.user)

    #   # visit spree.checkout_state_path(:payment)

    #   2.times { test_order.user.wallet.add(create(:credit_card)) }
    #   get :edit, params: { state: "payment" }
    #   expect(assigns(:mike_test)).to eq(1)
    #   expect(assigns(:current_remember_when_unspecified)).to eq(false)

    #   expect(assigns(:order).state).to eq("payment")

    #   expect(assigns(:wallet_payment_sources)).not_to be_empty
    #   expect(assigns(:wallet_payment_sources).size).to eq(0)
    # end


    # it "sets remember to true on new credit cards when checkbox is selected", js: true do
    #   get :edit, params: { state: "payment" }
    #   choose "Credit Card"
    #   fill_in "card_number", with: '4111111111111111'
    #   fill_in "card_expiry", with: '04 / 22'
    #   fill_in "card_code", with: '123'
    #   choose "Credit Card"
    # end

    # it "sets remember to false on new credit cards when checkbox is not selected" do

    # end

  end
end # describe block
