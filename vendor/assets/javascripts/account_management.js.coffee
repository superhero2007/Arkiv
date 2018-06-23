$ ->
  $('#paypal').on 'click', ->
    $('#fund_source_extra').val('PayPal')
    $('#fund_source_routing_number').val('PayPal')
    $('#fund_source_uid').attr('placeholder','PayPal Email address')