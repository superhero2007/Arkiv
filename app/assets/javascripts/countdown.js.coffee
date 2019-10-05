deadline = new Date(Date.parse(new Date) + 30 * 24 * 60 * 60 * 1000)

getTimeRemaining = (endtime) ->
  t = Date.parse(endtime) - Date.parse(new Date)
  seconds = Math.floor(t / 1000 % 60)
  minutes = Math.floor(t / 1000 / 60 % 60)
  hours = Math.floor(t / (1000 * 60 * 60) % 24)
  days = Math.floor(t / (1000 * 60 * 60 * 24))
  {
    'total': t
    'days': days
    'hours': hours
    'minutes': minutes
    'seconds': seconds
  }

initializeClock = (id, endtime) ->
  clock = document.getElementById(id)
  daysSpan = clock.querySelector('.days')
  hoursSpan = clock.querySelector('.hours')
  minutesSpan = clock.querySelector('.minutes')
  secondsSpan = clock.querySelector('.seconds')

  updateClock = ->
    t = getTimeRemaining(endtime)
    daysSpan.innerHTML = t.days
    hoursSpan.innerHTML = ('0' + t.hours).slice(-2)
    minutesSpan.innerHTML = ('0' + t.minutes).slice(-2)
    secondsSpan.innerHTML = ('0' + t.seconds).slice(-2)
    if t.total <= 0
      clearInterval timeinterval
    return

  updateClock()
  timeinterval = setInterval(updateClock, 1000)
  return

initializeClock 'clockdiv', deadline