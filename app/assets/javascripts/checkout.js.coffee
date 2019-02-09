$ ->
  stripeTokenHandler = (token) ->
    # Insert the token ID into the form so it gets submitted to the server
    form = $("#PaymentStepForm")
    tokenHiddenInput = document.createElement('input')
    tokenHiddenInput.setAttribute 'type', 'hidden'
    tokenHiddenInput.setAttribute 'name', 'stripe_token'
    tokenHiddenInput.setAttribute 'value', token.id
    form.appendChild tokenHiddenInput
    # Submit the form. This is the one that will have the token on it.
    form.submit()
    return
  # Create a Stripe client
  stripe = Stripe(gon.stripe_publishable_key)
  # Create an instance of Elements
  elements = stripe.elements()
  # Custom styling can be passed to options when creating an Element.
  # (Note that this demo uses a wider set of styles than the guide below.)
  style =
    base:
      color: '#32325d'
      fontFamily: 'Muli, Helvetica, sans-serif'
      fontSmoothing: 'antialiased'
      fontSize: '16px'
      '::placeholder': color: '#aab7c4'
    invalid:
      color: '#fa755a'
      iconColor: '#fa755a'
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
      displayError.textContent = ''
    return
  # Handle form submission
  form = $("#PaymentStepForm")
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
