class Application
  constructor: () ->
    console.log 'Application class is ready!'
    @copyright = new Copyright $('.fishtag-copyright')
    @callback = new Callback()
    @copyright.onclick = () ->
      console.debug 'click'

$ ->
  window.application = new Application()