class ImperaviInput
  constructor: (el)->
    @el = $ el
    csrf_token = $('meta[name=csrf-token]').attr('content')
    csrf_param = $('meta[name=csrf-param]').attr('content')
    if csrf_param && csrf_token then params = csrf_param + '=' + encodeURIComponent(csrf_token) else params = undefined

    @el.redactor
      focus: true
      #lang: 'ru' # TODO либо я туплю, либо это не работает [О.С.]
      imageUpload: '/admin/pictures?' + params
      imageManagerJson: '/admin/pictures.json'
      imageDestroy: '/admin/pictures'
      fileUpload: '/admin/attachments?' + params
      fileManagerJson: '/admin/attachments.json'
      fileDestroy: '/admin/attachments'
      buttons: ['html', 'formatting', 'bold', 'italic', 'deleted', 'unorderedlist', 'orderedlist', 'outdent', 'indent', 'image', 'file', 'link', 'alignment', 'horizontalrule']
      plugins: ['table', 'imagemanager', 'filemanager']
      buttonSource: true
      changeCallback: =>
        @el.trigger 'change'

window.addComponent ImperaviInput, className: 'imperavi-input'
