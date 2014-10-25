class Application
  constructor: () ->
    console.log 'Application class is ready!'
    @copyright = new Copyright $('.fishtag-copyright')

$ ->
  window.application = new Application()