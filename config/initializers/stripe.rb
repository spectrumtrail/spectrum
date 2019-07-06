require "stripe"

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.send(Rails.env.to_sym).fetch(
    :stripe_public_key,
    ENV["STRIPE_PUBLIC_KEY"]
  ),
  secret_key: Rails.application.credentials.send(Rails.env.to_sym).fetch(
    :stripe_secret_key,
    ENV["STRIPE_SECRET_KEY"]
  )
}

Stripe.api_key = Rails.configuration.stripe.fetch(:secret_key)
