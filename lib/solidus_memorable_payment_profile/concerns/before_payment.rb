module SolidusMemorablePaymentProfile
  module Concerns
    module BeforePayment

      def before_payment
        @mike_test = 1
        super
        @current_remember_when_unspecified = SolidusMemorablePaymentProfile::Config.remember_when_unspecified

        if @wallet_payment_sources.present?
          logger = Logger.new(STDOUT)
          logger.error "length wallet_payment_sources before #{@wallet_payment_sources.length}"
          @wallet_payment_sources.select! do |wallet_payment_source|
            if wallet_payment_source.payment_source.respond_to?(:remember)
              wallet_payment_source.payment_source.remember?
            else
              SolidusMemorablePaymentProfile::Config.remember_when_unspecified
            end
          end
          logger.error "length wallet_payment_sources after #{@wallet_payment_sources.length}"

        end
      end
    end
  end
end
