$ -> 
  $('#deposit_panel').hide()
  $('#withdraw_panel').hide()
  $('#withdraw_alert').hide()
  $('#deposit_alert').hide()

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

  $('#new_withdraw').on 'ajax:success', ->
    $('#withdraw_sum').val('')
    $('#2fa_code').val('')
    $('#withdraw_alert').show()
    $('#withdraw_alert').fadeOut(2000)

  $('#new_deposit').on 'ajax:success', ->
    $('#deposit_amount').val('')
    $('#deposit_alert').show()
    $('#deposit_alert').fadeOut(2000)

  $('#new_fund_source').on 'ajax:success', ->
    $('#fund_source')
      .find('option')
      .remove()
    $.get '/fund_sources', (data) ->
      for fund_source in data
        newOption = document.createElement("option")
        newOption.value = fund_source.id
        newOption.text=fund_source.uid
        $('#fund_source').append newOption
    $('#fund_sources_modal').modal('hide')



     