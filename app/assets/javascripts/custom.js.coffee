$('a[href*="#"]').not('[href="#"]').not('[href="#0"]').click (event) ->
  if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
    target = $(@hash)
    target = if target.length then target else $('[name=' + @hash.slice(1) + ']')
    if target.length
      event.preventDefault()
      $('html, body').animate { scrollTop: target.offset().top }, 1000, ->
        $target = $(target)
        $target.focus()
        if $target.is(':focus')
          return false
        else
          $target.attr 'tabindex', '-1'
          $target.focus()
        return
  return

$(document).ready ->
  s = $('header')
  pos = s.position()
  $(window).scroll ->
    windowpos = $(window).scrollTop()
    if windowpos >= pos.top & windowpos <= 10
      s.removeClass 'stick'
    else
      s.addClass 'stick'
    return
  return

$(document).ready ->
  $('#category-show').click ->
    $('#mylist').toggle 'slow'
    return
  return

$('.active-banner-slider').owlCarousel
  items: 1
  autoplay: false
  autoplayTimeout: 5000
  loop: true
  nav: true
  navText: [
    '<img src=\'img/banner/prev.png\'>'
    '<img src=\'img/banner/next.png\'>'
  ]
  dots: false

wow = new WOW(
  animateClass: 'animated'
  offset: 100)
wow.init()
