module SolidusMemorablePaymentProfile
  module Concerns
    module RememberedScope

      def self.included(base)
        base.class_eval do
          scope :remembered, -> { where(remember: true) }
        end
      end

    end
  end
end
