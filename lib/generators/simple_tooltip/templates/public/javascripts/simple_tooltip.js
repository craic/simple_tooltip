// jQuery code for the simple_tooltip gem
jQuery(document).ready(function() {

	var close_icon_file = "/images/simple_tooltip_close_icon.png";
	
	jQuery('.simple-tooltip-help-icon').mouseenter(function(e) {
		// remove any existing tooltip - should not be necessary, just a safety clause

// this has the side efect of removing any other visible tooltip on entering any other icon
		jQuery("#simple-tooltip").remove();
		
		// setup tooltip on hover
		if(!jQuery(this).hasClass('simple-tooltip-clickable')) {
			// Remove the 'title' attribute to prevent it appearing on hover
			this.title = null;
			
			// get the content for this tooltip by ajax and create the popup 
			jQuery.get("/simple_tooltips/tooltip_content?js=true&title=" + this.name, function(data) {

				jQuery("body").append("<div id='simple-tooltip'>" + data + "</div>");

				// position the tooltip at the bottom right of mouse pointer
				jQuery("#simple-tooltip").css("top",(e.pageY + 5) + "px").css("left",(e.pageX + 5) + "px").show();

				// with fast mouse movements the tooltip can remain visible
				// setup an action that if it is clicked then it is removed
				// shouldn't be necessary but it seems to be...
				jQuery('#simple-tooltip').click(function() {
					 jQuery(this).remove(); 
				});			
			});
		}

	}).click(function(e) {
		// prevent this event bubbling up to the link
		e.preventDefault();
		
		// setup tooltip on click
		if(jQuery(this).hasClass('simple-tooltip-clickable')) {

			// get the content for this tooltip by ajax and create the popup 
			jQuery.get("/simple_tooltips/tooltip_content?js=true&title=" + this.name, function(data) {

				// setup a close button within the tooltip at top right
				var close_div = "<div id=\"simple-tooltip-close\" class=\"simple-tooltip-close\">" +
								"<img src=\"" + close_icon_file + "\" alt=\"Close tooltip\"/></div>";

				jQuery("body").append("<div id='simple-tooltip'>" + close_div + data + "</div>");
				
				// position the tooltip at the bottom right of mouse pointer
				jQuery("#simple-tooltip").css("top",(e.pageY + 5) + "px").css("left",(e.pageX + 5) + "px").show();

				// remove the tooltip when close button is clicked
				jQuery('#simple-tooltip-close').click(function() {
	 				jQuery("#simple-tooltip").remove(); 
				});
				// ?? remove tooltip if the tooltip_icon is clicked a second time ??
				
			});
		}

	}).mouseleave(function(e) {
		// in :hover mode, remove the tooltip when the mouse leaves the tooltip icon
		if(!jQuery(this).hasClass('simple-tooltip-clickable')) {
			jQuery("#simple-tooltip").remove();
		}
	});
});
