# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $('.annotation_set h3').click () ->
    $(this).parent().children('.annotation_table').toggle()
    icon= $(this).children('i')
    console.log(icon)
    if icon
      icon_class = icon.attr("class")
      new_icon_class = if (icon_class == 'icon-chevron-up') then 'icon-chevron-down' else 'icon-chevron-up'
      icon.attr("class", new_icon_class)
      







