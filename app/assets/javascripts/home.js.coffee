# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  popup = null
  $('.help-box').popover({})
  $('.help-box').click ->
    if (Modernizr.mq("(max-width: 979px)"))
      $(this).parent().parent().parent().find('.touch-help').slideToggle()
    else
      if(popup == null)
        $(this).popover 'show'
        popup = this
      else if (this == popup) 
        $(this).popover 'hide'
        popup = null;
      else
        $(popup).popover 'hide'
        $(this).popover 'show'
        popup = this;
      
    return false
