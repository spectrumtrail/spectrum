require "stripe"

if Rails.application.credentials.present?
  credentials_hash = Rails.application.credentials.send(Rails.env.to_sym)
else
  credentials_hash = {}
end

Rails.configuration.stripe = {
  publishable_key: credentials_hash.fetch(:stripe_publishable_key, "test"),
  secret_key: credentials_hash.fetch(:stripe_secret_key, "test")
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
