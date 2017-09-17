module SolidusMemorablePaymentProfile
  class Configuration < Spree::Preferences::Configuration
    preference :remember_when_unspecified, :boolean, default: true
  end
end
