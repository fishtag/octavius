class window.Callback
  constructor: () ->
    @object = null
    @splash = $('div').addClass 'fishtag-callback-splash'
    @target = $('body')
    @render()

  render: (target) ->
    @target = $(target) if target
    unless @object
      @object = @_render()
    @target.append @splash
    @target.append @object

  _render: () ->
    template = '''
<div class="fishtag-callback-wrapper">
  <div class="fishtag-callback">
    <div class="fishtag-callback-title">Оставьте заявку</div>
    <form class="fishtag-callback-form" action="#">
      <div class="input-wrapper">
        <label for="name">Ваше имя</label>
        <input type="text" name="name" id="name" placeholder="Представьтесь, пожалуйста"/>
      </div>
      <div class="input-wrapper">
        <label for="contact">E-mail или телефон</label>
        <input type="text" name="contact" id="contact" placeholder="..или любой другой удобный способ связи"/>
      </div>
      <button class="fishtag-callback-submit" type="submit">Отправить</button>
    </form>
  </div>
</div>
'''
    _.template template