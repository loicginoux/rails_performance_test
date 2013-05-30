jQuery ->
	$("a[rel=popover]").popover()
	$(".tooltip").tooltip()
	$("a[rel=tooltip]").tooltip()
	$('.date').datepicker()
	# on selec box change, update the comment
	$(".opinion_select").change((e) ->
		sel = $(this)
		val = e.target.value
		com_id = sel.data("comment-id")
		$.ajax({
			type: "PUT",
			url: '/admin/comments/'+com_id+'.json',
			success: () ->
				# we build the new label and icon elements
				label = $("<span>").addClass("label").html("Neutral")
				if val == ""
					icon = $("<i>").addClass("icon-warning-sign")
					label = ""
				else
					icon = $("<i>").addClass("icon-ok")
					if val == "positive"
						label.addClass("label-success").html("Positive")
					else if val == "negative"
						label.addClass("label-important").html("Negative")

				sel.parent()
				.prev()
				# we update the opinion label
				.empty()
				.html(label)
				.prev()
				# we update the moderated icon
				.empty()
				.html(icon)
			data:
				comment : {
					id: com_id,
					opinion: val
				},
				dataType: 'json'
		})
	)

