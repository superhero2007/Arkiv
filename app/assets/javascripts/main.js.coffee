$(document).ready ->

  getRemainingTime = (endtime) ->
    milliseconds = Date.parse(endtime) - Date.parse(new Date)
    seconds = Math.floor(milliseconds / 1000 % 60)
    minutes = Math.floor(milliseconds / 1000 / 60 % 60)
    hours = Math.floor(milliseconds / (1000 * 60 * 60) % 24)
    days = Math.floor(milliseconds / (1000 * 60 * 60 * 24))
    {
      'total': milliseconds
      'seconds': seconds
      'minutes': minutes
      'hours': hours
      'days': days
    }

  initClock = (id, endtime) ->
    counter = document.getElementById(id)
    daysItem = counter.querySelector('.js-countdown-days')
    hoursItem = counter.querySelector('.js-countdown-hours')
    minutesItem = counter.querySelector('.js-countdown-minutes')
    secondsItem = counter.querySelector('.js-countdown-seconds')

    updateClock = ->
      time = getRemainingTime(endtime)
      daysItem.innerHTML = time.days
      hoursItem.innerHTML = ('0' + time.hours).slice(-2)
      minutesItem.innerHTML = ('0' + time.minutes).slice(-2)
      secondsItem.innerHTML = ('0' + time.seconds).slice(-2)
      if time.total <= 0
        clearInterval timeinterval
      return

    updateClock()
    timeinterval = setInterval(updateClock, 1000)
    return

  createBindings = (quantityContainer) ->
    quantityAmount = quantityContainer.getElementsByClassName('quantity-amount')[0]
    increase = quantityContainer.getElementsByClassName('increase')[0]
    decrease = quantityContainer.getElementsByClassName('decrease')[0]
    increase.addEventListener 'click', ->
      increaseValue quantityAmount
      return
    decrease.addEventListener 'click', ->
      decreaseValue quantityAmount
      return
    return

  init = ->
    i = 0
    while i < quantity.length
      createBindings quantity[i]
      i++
    return

  increaseValue = (quantityAmount) ->
    value = parseInt(quantityAmount.value, 10)
    console.log quantityAmount, quantityAmount.value
    value = if isNaN(value) then 0 else value
    value++
    quantityAmount.value = value
    return

  decreaseValue = (quantityAmount) ->
    value = parseInt(quantityAmount.value, 10)
    value = if isNaN(value) then 0 else value
    if value > 0
      value--
    quantityAmount.value = value
    return

  'use strict'
  window_width = $(window).width()
  window_height = window.innerHeight
  header_height = $('.default-header').height()
  header_height_static = $('.site-header.static').outerHeight()
  fitscreen = window_height - header_height
  $('.fullscreen').css 'height', window_height
  $('.fitscreen').css 'height', fitscreen
  #------- Active Nice Select --------//
  $('select').niceSelect()
  $('.navbar-nav li.dropdown').hover (->
    $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn 500
    return
  ), ->
    $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut 500
    return
  $('.img-pop-up').magnificPopup
    type: 'image'
    gallery: enabled: true
  # Search Toggle
  $('#search_input_box').hide()
  $('#search').on 'click', ->
    $('#search_input_box').slideToggle()
    $('#search_input').focus()
    return
  $('#close_search').on 'click', ->
    $('#search_input_box').slideUp 500
    return

  ###==========================
  		javaScript for sticky header
  		============================
  ###

  $('.sticky-header').sticky()

  ###=================================
  Javascript for product area carousel
  ==================================
  ###

  $('.active-product-area').owlCarousel
    items: 1
    autoplay: false
    autoplayTimeout: 5000
    loop: true
    nav: true
    navText: [
      '<img src=\'img/product/prev.png\'>'
      '<img src=\'img/product/next.png\'>'
    ]
    dots: false

  ###=================================
  Javascript for single product area carousel
  ==================================
  ###

  $('.s_Product_carousel').owlCarousel
    items: 1
    autoplay: false
    autoplayTimeout: 5000
    loop: true
    nav: false
    dots: true

  ###=================================
  Javascript for exclusive area carousel
  ==================================
  ###

  $('.active-exclusive-product-slider').owlCarousel
    items: 1
    autoplay: false
    autoplayTimeout: 5000
    loop: true
    nav: true
    navText: [
      '<img src=\'img/product/prev.png\'>'
      '<img src=\'img/product/next.png\'>'
    ]
    dots: false
  #--------- Accordion Icon Change ---------//
  $('.collapse').on('shown.bs.collapse', ->
    $(this).parent().find('.lnr-arrow-right').removeClass('lnr-arrow-right').addClass 'lnr-arrow-left'
    return
  ).on 'hidden.bs.collapse', ->
    $(this).parent().find('.lnr-arrow-left').removeClass('lnr-arrow-left').addClass 'lnr-arrow-right'
    return
  # Select all links with hashes
  $('.main-menubar a[href*="#"]').not('[href="#"]').not('[href="#0"]').click (event) ->
# On-page links
    if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
# Figure out element to scroll to
      target = $(@hash)
      target = if target.length then target else $('[name=' + @hash.slice(1) + ']')
      # Does a scroll target exist?
      if target.length
# Only prevent default if animation is actually gonna happen
        event.preventDefault()
        $('html, body').animate { scrollTop: target.offset().top - 70 }, 1000, ->
# Callback after animation
# Must change focus!
          $target = $(target)
          $target.focus()
          if $target.is(':focus')
# Checking if the target was focused
            return false
          else
            $target.attr 'tabindex', '-1'
            # Adding tabindex for elements not focusable
            $target.focus()
          # Set focus again
          return
    return
  # -------   Mail Send ajax
  $(document).ready ->
    form = $('#booking')
    # contact form
    submit = $('.submit-btn')
    # submit button
    alert = $('.alert-msg')
    # alert div for show alert message
    # form submit event
    form.on 'submit', (e) ->
      e.preventDefault()
      # prevent default form submit
      $.ajax
        url: 'booking.php'
        type: 'POST'
        dataType: 'html'
        data: form.serialize()
        beforeSend: ->
          alert.fadeOut()
          submit.html 'Sending....'
          # change submit button text
          return
        success: (data) ->
          alert.html(data).fadeIn()
          # fade in response data
          form.trigger 'reset'
          # reset form
          submit.attr 'style', 'display: none !important'
          # reset submit button text
          return
        error: (e) ->
          console.log e
          return
      return
    return
  $(document).ready ->
    $('#mc_embed_signup').find('form').ajaxChimp()
    return
  if document.getElementById('js-countdown')
    countdown = new Date('October 17, 2018')
    initClock 'js-countdown', countdown
  $('.quick-view-carousel-details').owlCarousel
    loop: true
    dots: true
    items: 1
  #----- Active No ui slider --------//
  $ ->
    if document.getElementById('price-range')
      nonLinearSlider = document.getElementById('price-range')
      noUiSlider.create nonLinearSlider,
        connect: true
        behaviour: 'tap'
        start: [
          500
          4000
        ]
        range:
          'min': [ 0 ]
          '10%': [
            500
            500
          ]
          '50%': [
            4000
            1000
          ]
          'max': [ 10000 ]
      nodes = [
        document.getElementById('lower-value')
        document.getElementById('upper-value')
      ]
      # Display the slider value and how far the handle moved
      # from the left edge of the slider.
      nonLinearSlider.noUiSlider.on 'update', (values, handle, unencoded, isTap, positions) ->
        nodes[handle].innerHTML = values[handle]
        return
    return
  #-------- Have Cupon Button Text Toggle Change -------//
  $('.have-btn').on 'click', (e) ->
    e.preventDefault()
    $('.have-btn span').text (i, text) ->
      if text == 'Have a Coupon?' then 'Close Coupon' else 'Have a Coupon?'
    $('.cupon-code').fadeToggle 'slow'
    return
  $('.load-more-btn').on 'click', (e) ->
    e.preventDefault()
    $('.load-product').fadeIn 'slow'
    $(this).fadeOut()
    return
  #------- Start Quantity Increase & Decrease Value --------//
  value = undefined
  quantity = document.getElementsByClassName('quantity-container')
  init()
  #------- End Quantity Increase & Decrease Value --------//

  ###----------------------------------------------------###

  ###Google map js
    /*----------------------------------------------------
  ###

  if $('#mapBox').length
    $lat = $('#mapBox').data('lat')
    $lon = $('#mapBox').data('lon')
    $zoom = $('#mapBox').data('zoom')
    $marker = $('#mapBox').data('marker')
    $info = $('#mapBox').data('info')
    $markerLat = $('#mapBox').data('mlat')
    $markerLon = $('#mapBox').data('mlon')
    map = new GMaps(
      el: '#mapBox'
      lat: $lat
      lng: $lon
      scrollwheel: false
      scaleControl: true
      streetViewControl: false
      panControl: true
      disableDoubleClickZoom: true
      mapTypeControl: false
      zoom: $zoom
      styles: [
        {
          featureType: 'water'
          elementType: 'geometry.fill'
          stylers: [ { color: '#dcdfe6' } ]
        }
        {
          featureType: 'transit'
          stylers: [
            { color: '#808080' }
            { visibility: 'off' }
          ]
        }
        {
          featureType: 'road.highway'
          elementType: 'geometry.stroke'
          stylers: [
            { visibility: 'on' }
            { color: '#dcdfe6' }
          ]
        }
        {
          featureType: 'road.highway'
          elementType: 'geometry.fill'
          stylers: [ { color: '#ffffff' } ]
        }
        {
          featureType: 'road.local'
          elementType: 'geometry.fill'
          stylers: [
            { visibility: 'on' }
            { color: '#ffffff' }
            { weight: 1.8 }
          ]
        }
        {
          featureType: 'road.local'
          elementType: 'geometry.stroke'
          stylers: [ { color: '#d7d7d7' } ]
        }
        {
          featureType: 'poi'
          elementType: 'geometry.fill'
          stylers: [
            { visibility: 'on' }
            { color: '#ebebeb' }
          ]
        }
        {
          featureType: 'administrative'
          elementType: 'geometry'
          stylers: [ { color: '#a7a7a7' } ]
        }
        {
          featureType: 'road.arterial'
          elementType: 'geometry.fill'
          stylers: [ { color: '#ffffff' } ]
        }
        {
          featureType: 'road.arterial'
          elementType: 'geometry.fill'
          stylers: [ { color: '#ffffff' } ]
        }
        {
          featureType: 'landscape'
          elementType: 'geometry.fill'
          stylers: [
            { visibility: 'on' }
            { color: '#efefef' }
          ]
        }
        {
          featureType: 'road'
          elementType: 'labels.text.fill'
          stylers: [ { color: '#696969' } ]
        }
        {
          featureType: 'administrative'
          elementType: 'labels.text.fill'
          stylers: [
            { visibility: 'on' }
            { color: '#737373' }
          ]
        }
        {
          featureType: 'poi'
          elementType: 'labels.icon'
          stylers: [ { visibility: 'off' } ]
        }
        {
          featureType: 'poi'
          elementType: 'labels'
          stylers: [ { visibility: 'off' } ]
        }
        {
          featureType: 'road.arterial'
          elementType: 'geometry.stroke'
          stylers: [ { color: '#d6d6d6' } ]
        }
        {
          featureType: 'road'
          elementType: 'labels.icon'
          stylers: [ { visibility: 'off' } ]
        }
        {}
        {
          featureType: 'poi'
          elementType: 'geometry.fill'
          stylers: [ { color: '#dadada' } ]
        }
      ])
  return
