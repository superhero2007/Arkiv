$ -> 
  $('#deposit_panel').hide()
  $('#withdraw_panel').hide()

  $('#deposit_usd').on 'click', =>
    $('#currencies_panel').hide()
    $('#deposit_panel').fadeIn()

  $('#withdraw_usd').on 'click', =>
    $('#currencies_panel').hide()
    $('#withdraw_panel').fadeIn()

  $('#close_withdraw').on 'click', =>
    $('#withdraw_panel').hide()
    $('#currencies_panel').fadeIn()

  $('#close_deposit').on 'click', =>
    $('#deposit_panel').hide()
    $('#currencies_panel').fadeIn()

  $('#deposit_usd_form').submit -> 
    amount = $('#amount').val()
    if amount == ''
      console.log 'Amount not enough'

  $('#fund_sources_form').submit ->
    console.log 'Am submitted'
    