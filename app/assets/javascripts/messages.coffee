do ($ = jQuery)->
  $(document).on "turbolinks:load",  ->
    highlightText($("#query-text").data("query").trim()) if $("#query-text").data("query") && $("#query-text").data("query").length > 0

  highlightText = (query) ->
    regExp = new RegExp(query, "giu")
    $(".message-text").each (index, textElem) ->
      $(textElem).html($(textElem).html().replace(regExp, "<span class='highlight-text'>\$&</span>"))
