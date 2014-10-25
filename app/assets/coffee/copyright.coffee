class window.Copyright
  constructor: (object) ->
    @directions = ['top', 'right', 'bottom', 'left']

    @_object = object
    @_coinWrapper = $('.fishtag-copyright-coin-wrapper', @_object)
    @_coin = $('.fishtag-copyright-coin', @_object)
    @_events()

  _events: () ->
    $(@_coinWrapper).on 'mouseenter', (event) =>
      if @_coinWrapper.hasClass 'animated'
        return
      direction = @_getDirection(@_coinWrapper, event)
      @_coinWrapper.addClass 'hover animated'
      @_coinWrapper.addClass "hover-#{direction}"

      setTimeout () =>
        @_coin.addClass 'hover'
      , 50

      setTimeout () =>
        @_coinWrapper.removeClass 'hover animated'
        @_coinWrapper.removeClass 'hover-top hover-left hover-right hover-bottom'
      , 500

    $(@_coinWrapper).on 'mouseleave', (event) =>
      if @_coinWrapper.hasClass 'animated'
        @_coin.removeClass 'hover'
        return

      @_coinWrapper.addClass 'animated'


  _getDirection: ($el, event) ->
    index = @_getDirectionIndex $el, event
    @directions[index]

  _getDirectionIndex: ($el, event) ->

    # the width and height of the current div
    w = $el.width()
    h = $el.height()

    coordinates = {
      x: event.pageX
      y: event.pageY
    }

    # calculate the x and y to get an angle to the center of the div from that x and y.
    # gets the x value relative to the center of the DIV and "normalize" it
    x = (coordinates.x - $el.offset().left - (w / 2)) * ((if w > h then (h / w) else 1))
    y = (coordinates.y - $el.offset().top - (h / 2)) * ((if h > w then (w / h) else 1))

    # the angle and the direction from where the mouse came in/went out clockwise (TRBL=0123);
    # first calculate the angle of the point,
    # add 180 deg to get rid of the negative values
    # divide by 90 to get the quadrant
    # add 3 and do a modulo by 4  to shift the quadrants to a proper clockwise TRBL (top/right/bottom/left) **/
    direction = Math.round((((Math.atan2(y, x) * (180 / Math.PI)) + 180) / 90) + 3) % 4
    direction