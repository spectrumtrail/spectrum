require "stripe"

credentials_hash = Rails.application.credentials.send(Rails.env.to_sym)

Rails.configuration.stripe = {
  publishable_key: credentials_hash.fetch(:stripe_publishable_key, ""),
  secret_key: credentials_hash.fetch(:stripe_secret_key, "")
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
