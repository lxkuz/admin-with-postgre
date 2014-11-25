class LocalizedForm
  constructor: (el) ->
    @el = $ el
    @localeSelectors = $ ".locale-selector", @el
    @localizedFields = $ "[data-locale]", @el
    @localeSelectors.change @update
    if @readCookie()
      console.log("HAS STATE COOKIE")
      @setState @readCookie()
    
    @update()

    @inputs = $ "input, textarea", ".localized-row", @el
    @inputs.change @fillBlankLocales

  update: =>
    state = @getState()
    for field in @localizedFields
      column = state[$(field).data("locale")] || null
      $(field).attr "localize-view", column
    state

  setState: (state) =>
    for key, value of state
      selector = $ "select[data-locale-type='#{key}']", @el
      selector.val value

  swapObj: (obj) =>
    res = {}
    for key, val of obj
      res[val] = key
    res

  getState: =>
    state = {}
    for selector in @localeSelectors
      $selector = $ selector
      state[$selector.val()] = $selector.data "locale-type"
    @writeCookie @swapObj(state)
    state

  readCookie: =>
    cookie = $.cookie "localized-state"
    JSON.parse cookie if cookie 

  writeCookie: (state) =>
    $.cookie "localized-state", JSON.stringify(state) , {path: '/'}


  fillBlankLocales: (ev) =>
    target = $ ev.currentTarget
    val = target.val()
    parent = target.parents(".localized-row")
    for input in parent.find("input, textarea")
      localizedVal = $(input).val()
      $(input).val val if val && !localizedVal

window.addComponent LocalizedForm, className: "localized-form"