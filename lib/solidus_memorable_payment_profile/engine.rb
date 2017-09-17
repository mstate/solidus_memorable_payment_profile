module SolidusMemorablePaymentProfile
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'solidus_memorable_payment_profile'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'solidus.memorable_payment_profile.preferences', before: :load_config_initializers do |app|
      SolidusMemorablePaymentProfile::Config = SolidusMemorablePaymentProfile::Configuration.new
      Spree::PermittedAttributes.source_attributes.push(:remember) unless Spree::PermittedAttributes.source_attributes.include?(:remember)
      Spree::CheckoutController.prepend SolidusMemorablePaymentProfile::Concerns::BeforePayment
      Spree::UsersController.prepend SolidusMemorablePaymentProfile::Concerns::ForgetCreditCard
      Spree::CreditCard.include SolidusMemorablePaymentProfile::Concerns::RememberedScope
    end


    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
