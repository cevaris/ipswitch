// $(document).ready(function(){ });

var alphanumeric = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
function genRandomAlhpaNum(){
	var delim = '.',
		segmentCount = 2,
		segmentSize  = 5,
		result = [];
	
	for(var segment=0; segment<segmentCount; segment++){
		for(var segmentIndex=0; segmentIndex<segmentSize; segmentIndex++){
			result.push(alphanumeric.charAt(Math.random()*36));
		}
		
		// Do not add delim at end
		if (segment != segmentCount-1)
			result.push(delim);
	}
	
	return result.join('');
}
