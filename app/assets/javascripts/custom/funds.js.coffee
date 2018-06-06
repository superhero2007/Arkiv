$ -> 
  $('#deposit_panel').hide()
  $('#withdraw_panel').hide()
  $('#withdraw_alert').hide()
  $('#deposit_alert').hide()

  deposits = (data) ->
    $.get '/history/deposits', (data) ->
      tbody = $('#deposit_table')
      tbody.empty()
      for withdraw in data
        row = document.createElement("tr")
        td1 = document.createElement("td")
        amount = document.createTextNode(withdraw.amount)
        td1.append amount
        row.append td1

        td2 = document.createElement("td")
        fee = document.createTextNode(withdraw.fee)
        td2.append fee
        row.append td2

        td3 = document.createElement("td")
        status = document.createTextNode(withdraw.aasm_state)
        td3.append status
        row.append td3

        td4 = document.createElement("td")
        created_at = document.createTextNode(withdraw.created_at)
        td4.append created_at
        row.append td4

        tbody.append row

  withdraws = ->
    $.get '/history/withdraws', (data) ->
      tbody = $('#withdraw_table')
      tbody.empty()
      for withdraw in data
        row = document.createElement("tr")
        td1 = document.createElement("td")
        amount = document.createTextNode(withdraw.amount)
        td1.append amount
        row.append td1

        td2 = document.createElement("td")
        fee = document.createTextNode(withdraw.fee)
        td2.append fee
        row.append td2

        td3 = document.createElement("td")
        status = document.createTextNode(withdraw.aasm_state)
        td3.append status
        row.append td3

        td4 = document.createElement("td")
        created_at = document.createTextNode(withdraw.created_at)
        td4.append created_at
        row.append td4

        tbody.append row

  $('#deposit_usd').on 'click', =>
    deposits 'test'
    $('#currencies_panel').hide()
    $('#deposit_panel').fadeIn()

  $('#withdraw_usd').on 'click', =>
    withdraws 'test'
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
    withdraws 'test'
    $('#withdraw_sum').val('')
    $('#2fa_code').val('')
    $('#withdraw_alert').show()
    $('#withdraw_alert').fadeOut(2000)

  $('#new_deposit').on 'ajax:success', ->
    deposits 'test'
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



     