$(document).on('click','a',function(){
	
		parentid = $(this).closest('tr').attr('id');
		console.log(parentid);
		$.ajax({
			url:"AdminServlet",
			type:"POST",
			data:{
               ftype:"deletesubscriber",
               email : this.name
                },
			success: function(data){
					$('#'+parentid).hide();                
			},
			 error:function(){
				 //$('#exampleModal').modal('show')
	            }
                
	});
});