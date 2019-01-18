$(document).on('click','a',function(){
		parentid = $(this).parent('div').parent('div').parent('div').attr('id');
		parentid = "#"+parentid;
		$.ajax({
			url:"AdminServlet",
			type:"POST",
			data:{
               ftype:"deleteEvent",
               id : this.id
                },
			success: function(data){
				$(parentid).hide();
				if(data == "yes"){
					$(parentid).hide();
				}
				else{
					$('#exampleModal').modal('show')
				}
                
			},
			 error:function(){
				 //$('#exampleModal').modal('show')
	            }
                
	});
});