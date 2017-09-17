FactoryGirl.define do
  factory :forgettable_credit_card, parent: :credit_card do
    remember false
  end
  factory :memorable_credit_card, parent: :credit_card do
    remember true
  end
end
