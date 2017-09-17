require 'spec_helper'

describe "Credit Card Page", :type => :feature do
  context "page elements" do
    let!(:user) { create(:user) }

    let(:cc_m1) do
      credit_card = create(:memorable_credit_card, user: user)
      user.wallet.add(credit_card)
      credit_card
    end
    let(:cc_m2) do
      credit_card = create(:memorable_credit_card, user: user)
      user.wallet.add(credit_card)
      credit_card
    end
    let(:cc_f1) do
      credit_card = create(:forgettable_credit_card, user: user)
      user.wallet.add(credit_card)
      credit_card
    end
    let(:cc_f2) do
      credit_card = create(:forgettable_credit_card, user: user)
      user.wallet.add(credit_card)
      credit_card
    end

    before(:each) do
      visit spree.login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Login'
      [cc_m1, cc_m2, cc_f1, cc_f2] # initialize all credit cards
      visit spree.account_path
    end

    after(:each) do
      user.wallet_payment_sources.destroy_all
      user.credit_cards.destroy_all
    end

    it "should have a credit cards table" do
      expect(page).to have_xpath("//table[@id='user_credit_cards']", :count => 1)
    end

    it "should show only the remembered credit cards" do
      expect(user.credit_cards.count).to eq(4)
      within('//table[@id="user_credit_cards"]') do
        expect(page).to have_xpath(".//tr", :count => 2)
      end
    end

    it "should show additional memorable credit cards" do
      create(:memorable_credit_card, user: user)
      visit spree.account_path
      within('//table[@id="user_credit_cards"]') do
        expect(page).to have_xpath(".//tr", :count => 3)
      end
      user
    end


    it "should forget a credit card when forget link is clicked" do
      page.all(:link, Spree.t(:remove)).last.click
      within('//table[@id="user_credit_cards"]') do
        expect(page).to have_xpath(".//tr", :count => 1)
      end
    end
  end
end
