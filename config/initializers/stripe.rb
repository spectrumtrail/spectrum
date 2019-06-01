require "stripe"

credentials_hash = Rails.application.credentials.send(Rails.env.to_sym)

Rails.configuration.stripe = {
  publishable_key: credentials_hash.fetch(
    :stripe_publishable_key,
    ENV["STRIPE_PUBLISHABLE_KEY"]
  ),
  secret_key: credentials_hash.fetch(
    :stripe_secret_key,
    ENV["STRIPE_SECRET_KEY"]
  )
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
