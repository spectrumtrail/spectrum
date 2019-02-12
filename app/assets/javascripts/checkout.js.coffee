stripeTokenHandler = (token) ->
  # Insert the token ID into the form so it gets submitted to the server
  form = document.getElementById("PaymentStepForm")
  tokenHiddenInput = document.createElement('input')
  tokenHiddenInput.setAttribute 'type', 'hidden'
  tokenHiddenInput.setAttribute 'name', 'stripe_token'
  tokenHiddenInput.setAttribute 'value', token.id
  form.appendChild tokenHiddenInput
  # Submit the form. This is the one that will have the token on it.
  form.submit()
  return

$ ->
  if $("#PaymentStepForm").length > 0
    form = document.getElementById("PaymentStepForm")
    submit_button = $("#stripe_button")
    terms_radio_inputs = $(".registration_accepts_refund_terms")
    terms_radio_yes = $("#js-refund-terms-radio-input")

    terms_radio_inputs.change ->
      submit_button.prop("disabled", !terms_radio_yes.is(":checked"))

    # Create a Stripe client
    stripe = Stripe(gon.stripe_publishable_key)
    # Create an instance of Elements
    elements = stripe.elements()
    # Custom styling can be passed to options when creating an Element.
    # (Note that this demo uses a wider set of styles than the guide below.)
    style =
      base:
        color: '#32325d'
        fontFamily: 'Nunito, Helvetica, sans-serif'
        fontSmoothing: 'antialiased'
        fontSize: '14px'
        '::placeholder': color: '#aab7c4'
      invalid:
        color: '#ff0033'
        iconColor: '#ff0033'
    # Create an instance of the card Element
    card = elements.create('card', style: style)
    # Add an instance of the card Element into the `card-element` <div>
    card.mount '#card-element'
    # Handle real-time validation errors from the card Element.
    card.addEventListener 'change', (event) ->
      displayError = document.getElementById('card-errors')
      if event.error
        displayError.textContent = event.error.message
      else
        $('input[type="submit"]').removeAttr('disabled')
        displayError.textContent = ''
      return
    # Handle form submission
    form.addEventListener 'submit', (event) ->
      event.preventDefault()
      # PREVENT DOUBLE CLICKING
      stripe.createToken(card).then (result) ->
        if result.error
          # Inform the user if there was an error
          errorElement = document.getElementById('card-errors')
          errorElement.textContent = result.error.message
        else
          # Send the token to your server
          stripeTokenHandler result.token
        return
      return
