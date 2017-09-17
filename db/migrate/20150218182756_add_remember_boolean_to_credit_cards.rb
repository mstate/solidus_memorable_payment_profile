class AddRememberBooleanToCreditCards < SolidusSupport::Migration[4.2]
  def change
  	add_column :spree_credit_cards, :remember, :boolean, default: false
  end
end
