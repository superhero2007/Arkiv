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
    