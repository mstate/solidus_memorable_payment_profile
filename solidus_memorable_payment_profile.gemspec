# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'solidus_memorable_payment_profile/version'

Gem::Specification.new do |spec|
  spec.name        = 'solidus_memorable_payment_profile'
  spec.version     = SolidusMemorablePaymentProfile::VERSION
  spec.summary     = 'Offer uesrs the choice to remember a credit card.'
  spec.description = 'Solidus users are presented with the choice to remember a credit card during purchase.  Only cards that have been remembered are then avaialble for use on future purchases.  Originally taken from spree_memorable_payment_profile.'
  spec.required_ruby_version = '>= 1.9.3'

  spec.author    = 'Mike State'
  spec.email     = 'mstate@gmail.com'
  spec.license     = 'BSD-3-Clause'

  spec.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  spec.test_files = Dir['spec/**/*']

  # Wallet payment sources were added in Solidus 2.2
  spec.add_dependency 'solidus_core', '>= 2.2'
  spec.add_dependency 'solidus_support'
  spec.add_dependency 'solidus_frontend'
  spec.add_dependency 'solidus_backend'

  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'poltergeist'
  spec.add_development_dependency 'coffee-rails'
  spec.add_development_dependency 'sass-rails'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop'#, '0.37.2'
  spec.add_development_dependency 'rubocop-rspec'#, '1.4.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'
end
