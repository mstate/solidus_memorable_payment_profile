FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'solidus_memorable_payment_profile/factories'

  factory :forgettable_credit_card, parent: :credit_card do
    remember false
  end
  factory :memorable_credit_card, parent: :credit_card do
    remember true
  end
  factory :forgettable_wallet_payment_source, parent: :wallet_payment_source do
    remember false
  end
  factory :memorable_wallet_payment_source, parent: :wallet_payment_source do
    remember true
  end

end
