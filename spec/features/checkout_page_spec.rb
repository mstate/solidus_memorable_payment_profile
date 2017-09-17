require 'spec_helper'

describe "Checkout Page", :type => :feature do
  context "page elements" do
    let!(:user) { create(:user) }

    let(:credit_card_payment) { create(:credit_card_payment_method) }
    let(:cc) do
      credit_card = create(:memorable_credit_card,
             payment_method: credit_card_payment,
             gateway_customer_profile_id: "EFWE",
             user: user)
      user.wallet.add(credit_card)
      credit_card
    end

    let!(:order) do
      order = OrderWalkthrough.up_to(:delivery)
      order.reload
      order.user = user
      if order.respond_to?(:recalculate)
        order.recalculate
      else
        order.update!
      end
      order
    end

    before(:each) do
      allow(order).to receive_messages(available_payment_methods: [ credit_card_payment ])
      allow_any_instance_of(Spree::CheckoutController).to receive_messages(current_order: order)
      allow_any_instance_of(Spree::CheckoutController).to receive_messages(try_spree_current_user: user)
      allow_any_instance_of(Spree::CheckoutController).to receive_messages(skip_state_validation?: true)
      cc # evaluate credit card to have it assigned to user.
      visit spree.checkout_state_path(:payment)
      expect(page.has_field?('use_existing_card_no')).to be_truthy
      expect(page.find(:xpath, "//input[contains(@id, 'use_existing_card_no')]").checked?).to be_falsey
      page.find(:xpath, "//input[contains(@id, 'use_existing_card_no')]").click
      expect(page.find(:xpath, "//input[contains(@id, 'use_existing_card_no')]").checked?).to be_truthy
      expect(user.credit_cards.count).to eq(1)
      choose "Credit Card"
      fill_in "Name on card", with: 'Spree Commerce'
      fill_in "Card Number", with: '4111111111111111'
      fill_in "card_expiry", with: '04 / 29'
      fill_in "Card Code", with: '123'
    end

    it "shows the checkbox to save credit card on the checkout page", js: true do
      expect(page.has_field?('remember')).to be_truthy
    end

    it "adds a remembered credit card to user if checkbox is checked", js: true do
      check "remember"
      click_button "Save and Continue"
      expect(user.credit_cards.count).to eq(2)
      expect(user.credit_cards.last.remember).to be_truthy
    end

    it "adds a forgettable credit card to user if checkbox is not checked", js: true do
      uncheck "remember"
      click_button "Save and Continue"
      expect(user.credit_cards.count).to eq(2)
      expect(user.credit_cards.last.remember).to be_falsey
    end
  end
end
