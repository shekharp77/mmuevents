$(document).on('click','a',function(){
	
		parentid = $(this).closest('tr').attr('id');
		parentid = "#"+parentid;
		$.ajax({
			url:"AdminServlet",
			type:"POST",
			data:{
               ftype:"deleteCoordinator",
               id : this.name
                },
			success: function(data){
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