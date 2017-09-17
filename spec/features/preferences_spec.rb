require 'spec_helper'
require 'solidus_core'
require 'solidus_support'

describe SolidusMemorablePaymentProfile, :type => :feature do
  context "preferences" do

    context "with configuration" do

      let(:memorable_config) { SolidusMemorablePaymentProfile::Configuration.new }


      context 'with default value' do

        before do
          require 'solidus_memorable_payment_profile/configuration'
          reset_spree_preferences
        end

        it "is true by default" do
          expect(memorable_config.preferred_remember_when_unspecified_default).to be true
        end

      end

    end

  end

end
