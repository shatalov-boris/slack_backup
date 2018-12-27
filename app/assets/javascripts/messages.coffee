do ($ = jQuery)->
  $(document).on "turbolinks:load",  ->
    highlightText($("#query-text").data("query").trim()) if $("#query-text").data("query") && $("#query-text").data("query").length > 0
    if findGetParameter("highlight_id")
      highlightRow = $("tr#message_" + findGetParameter("highlight_id"))
      if highlightRow.length > 0
        highlightRow.addClass("highlight-row")
        $([document.documentElement, document.body]).animate({
          scrollTop: highlightRow.offset().top - $(".navbar").height()
        }, 500);

  highlightText = (query) ->
    regExp = new RegExp(query, "giu")
    $(".message-text").each (index, textElem) ->
      $(textElem).html($(textElem).html().replace(regExp, "<span class='highlight-text'>\$&</span>"))
