module SolidusMemorablePaymentProfile
  module Concerns
    module ForgetCreditCard

      def self.included(base)
        base.class_eval do
          prepend_before_action :load_object, :only => [:show, :edit, :update, :forget_credit_card]
        end
      end

      def forget_credit_card
        credit_card = try_spree_current_user.credit_cards.remembered.find(params[:credit_card_id])
        if credit_card && credit_card.toggle!(:remember)
          flash[:notice] = I18n.t('memorable_payment_profile.credit_card_forgotten')
        else
          flash[:error] = I18n.t('memorable_payment_profile.failed_to_forget_credit_card')
        end
        redirect_back(fallback_location: spree.account_path)
      end

    end
  end
end
