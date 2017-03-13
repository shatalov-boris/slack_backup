do ($ = jQuery)->
  $(document).on "turbolinks:load",  ->
    highlightText($("#query-text").text()) if $("#query-text").text().length > 0

  highlightText = (query) ->
    $(".message-text").each (index, textElem) ->
      regExp = new RegExp("(^\|[ \n\r\t)(:.,'\"\+!?-]+)(" + query + ")([ \n\r\t)(:.,'\"\+!?-]+\|$)", "giu")
      $(textElem).html($(textElem).html().replace(regExp, "<span class='highlight-text'>\$1\$2\$3</span>"))
