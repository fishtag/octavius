class Application
  constructor: () ->
    console.log 'Application class is ready!'

$ ->
  window.application = new Application()
