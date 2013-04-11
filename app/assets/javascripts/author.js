
$(function() {
	$('#add-author').on("click", function() {
	 $('#author-list').append('<div style="display:block;clear:both;"><span class="field" style="float:left"><input id="book_author_" name="book[author][]" type="text" value="" /></span><span class="icon-minus-sign remove-author"></span><br /></div>');
	});

	$("body").on("click", ".remove-author", function(){
  		$(this).parent().remove();
	});
});