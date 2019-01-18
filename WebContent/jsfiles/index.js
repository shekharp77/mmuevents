$( document ).ready(function() {
	$("#4pic").hide();
	$("#5pic").hide();
	$("#6pic").hide();
// main animation	
  $("#mmu").animate({
    	marginTop: "20%",
      width: "100%"
    }, {
      queue: false,
      duration: 4000
    })
    .animate({ borderRightWidth: "0px" }, 1500 ,
    		function () {
    		$("#mmu").fadeOut(500,function(){
    			$("body").css({"background":"white"});
    			$('#maindiv').removeAttr( "hidden" );
    			$("#1pic").animate({
    				marginTop: "20%"
    			}, 500, function(){
    				$("#2pic").animate({
        				marginTop: "20%"
        			}, 500, function(){
        				$("#3pic").animate({
            				marginTop: "20%"
            			}, 500, function(){
            				$("#4pic").fadeIn(500, function(){
            					$("#5pic").fadeIn(500, function(){
            						$("#6pic").fadeIn(500, function(){
            							$('#details').removeAttr( "hidden" );
            							 $('html, body').animate({
            							        scrollTop: $("#1pic").offset().top
            							    }, 500, function(){
            							    	$('#maindiv').addClass('bg1');
            							    });
                    				});
                				});
            				});
            			});
        			});
    			});
    		});
    	});
});
 
