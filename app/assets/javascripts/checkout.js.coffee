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

toggleVerifyButton = () ->
  if $("#registration_discount_code_text").val().length > 3
    $("#CheckDiscountCodeButton").prop("disabled", false)
  else
    $("#CheckDiscountCodeButton").prop("disabled", true)

$ ->
  if $("#PaymentStepForm").length > 0
    $("#registration_discount_code_text").on "keyup change", ->
      toggleVerifyButton()

    $("#CheckDiscountCodeButton").click (e) ->
      $(this).prop("disabled", true) # prevent double click
      code_input = $("#registration_discount_code_text")
      code_input_hint = code_input.parents(".form-group").children("small")
      code = code_input.val()
      discount_code_input = $("#js-DiscountCodeIdInput")
      check_button = $(this)
      registration_id = $("#CheckDiscountCodeButton").data("registration-id")

      if code
        $.get "/discount_codes/" + code + "/validate?registration_id=" + registration_id, (data) ->
          if data["success"]
            new_amount_in_dollars = data["new_total_in_cents"] / 100
            formatted_new_amount_in_dollars = new_amount_in_dollars.toLocaleString 'en-US',
              style: 'currency'
              currency: 'USD'

            code_input.removeClass("is-invalid")
            code_input.addClass("is-valid")
            code_input.prop("readonly", true)
            code_input_hint.removeClass("text-muted")
            code_input_hint.removeClass("text-danger")
            code_input_hint.addClass("text-success")
            code_input_hint.html("Discount code applied!")
            check_button.addClass("btn-success")
            check_button.prop("disabled", true)
            discount_code_input.val(data["discount_code_id"])
            check_button.html("Valid <i class='far fa-check-circle'></i>")

            $("#FinalTotal").text(formatted_new_amount_in_dollars).addClass("text-success")
          else
            check_button.prop("disabled", false)
            code_input_hint.removeClass("text-muted")
            code_input_hint.addClass("text-danger")
            code_input_hint.html("Hmmm... we don't recognize this code.")
            code_input.addClass('is-invalid')

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
