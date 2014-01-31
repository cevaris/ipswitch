
(function() {
	
	
	var taggit = {},
	// Tagging Configuration
	config = {
		inputId : '#taggit-tag-input',
		displayId : '#taggit-tag-display',
		hiddenId : '',
		maxTags: '10', 
	}, 
	//Makes each tag item unique
	counter = 1; 
	
		
	/**
	 * Instantiate the taggit front end app
	 */
	taggit.init = function(custom_config){
		// Add custom config
		$.extend(config, custom_config);
		taggit.updateTagItems(taggit.getTags());
	}
	
	/**
	 * Returns current tag list as an array
	 */
	taggit.getTags = function(){
		return $(config.hiddenId).val() ? $(config.hiddenId).val().split(",") : [];
	};
	
	/**
	 * Gets new tag
	 * Deletes tag input field
	 * returns new tag
	 */
	taggit.getTagInput = function(){
		new_tag = $.trim($(config.inputId).val());
		// Delete input tag value
		$(config.inputId).val('');
		return new_tag;
	};
	
	/**
	 * Runs checks to see if data is valid
	 * Adds new tag to tag list
	 * Udates tag view
	 */
	taggit.main = function(){
		curr_tags = taggit.getTags();
		new_tag = taggit.getTagInput();
		
		// Checks if tag is emtpy
		if(!new_tag){
			return;
		}
		// Checks if tag number has been reached
		if(!taggit.maxTagCheck(curr_tags.length+1)){
			alert('Max number of tags is '+config.maxTags);
			return;
		}
		// Checks if there is a duplicate tag
		if(taggit.duplicateTagCheck(new_tag)){
			return;
		}
		
		curr_tags.push(new_tag);
		$(config.hiddenId).val(curr_tags.join());
		taggit.updateTagItems(curr_tags);
		
	};
	
	/**
	 * Runs checks to see if data is valid
	 * Adds new tag to tag list
	 * Udates tag view
	 */
	taggit.main_autocomplete = function(new_tag){
		curr_tags = taggit.getTags();
		
		// Checks if tag is emtpy
		if(!new_tag){
			return;
		}
		// Checks if tag number has been reached
		if(!taggit.maxTagCheck(curr_tags.length+1)){
			alert('Max number of tags is '+config.maxTags);
			return;
		}
		// Checks if there is a duplicate tag
		if(taggit.duplicateTagCheck(new_tag)){
			return;
		}
		
		curr_tags.push(new_tag);
		$(config.hiddenId).val(curr_tags.join());
		taggit.updateTagItems(curr_tags);
		
	};
	
	
	/*
	 * Checks the current number of tags and compares with default size.
	 * If max number of tags are violated, return false.
	 */
	taggit.maxTagCheck = function(size){
		if(size > config.maxTags)
			return false; 
		else 
			return true;
	}
	
	
	/*
	 * Checks the current tags to see if new tag is a duplicate
	 */
	taggit.duplicateTagCheck = function(tag){
		curr_tags = taggit.getTags();
		if ($.inArray(tag, curr_tags)==-1){
			return false;
		} else
			return true; 
	}
	
	
	/*
	 * Adds live click listener to new tag item
	 */
	taggit.registerRemoveTagItem = function(i){
		$('#tag-display-'+i).live('click',function() {
			tag = $.trim($(this).html());
			// Remove for state list
			taggit.removeTag(tag);
			// Remove element
	    	$(this).remove();
	    	return false;
		});     
	};
	
	/*
	 * Removes given tag fromm tag list
	 * Updates tag display items
	 */
	taggit.removeTag = function(tag){
		curr_tags = taggit.getTags();
		curr_tags.splice( $.inArray(tag, curr_tags), 1 );
		$(config.hiddenId).val(curr_tags.join());
		taggit.updateTagItems(curr_tags);
	}
	
	/*
	 * Updates tag item display from a given array of tags
	 */
	taggit.updateTagItems = function(curr_tags){
		
		//Display to user
		display_text = "";
		for (i=0; i<curr_tags.length; i++) {
			tag = curr_tags[i];
			
			display_text += '&nbsp;<span class="activity-tag-block" id="tag-display-'+counter+'">'+tag+'</span>';
			taggit.registerRemoveTagItem(counter);
			counter++;       
		}
		$(config.displayId).html(display_text)
		
	}
	
	/**
	 * Tracks the spacebar and enter key presses to separte tags. 
	 * Triggers the capture and processing of the tag.
	 */
	$(config.inputId).live('keydown',(function(e){
		if(e.keyCode == 32){
			// Capture the tag 
			taggit.main();
			$(config.inputId).val('');
			return false;
		}
		if(e.keyCode == 13){
			// Capture the tag 
			taggit.main();
			$(config.inputId).val('');
			return false;
		}
	}));
	window['taggit'] = taggit;
	
}());









