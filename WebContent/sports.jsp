<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script type="text/javascript" src="jsfiles/index2.js"></script>
<style>

	@font-face {
			    font-family: myFont2;
			    src: url("INKFERNO.ttf") format("truetype");
			}
	@font-face {
			    font-family: myFont;
			    src: url("POLYA.otf") format("truetype");
			}
			
			#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    padding-right: 42px;
    text-align: left;
    background-color: ;
    color: #4CAF50;
}
</style>
<title>Events</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
  <a class="navbar-brand" href="index.jsp"><h3 style="font-family: myFont2">MMU EVENTS</h3></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item ">
        <a class="nav-link" href="sports.jsp" id="sportsbtn" style="font-family: myFont2"><h4>Sports</h4> </a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="cultural.jsp" id="culturalbtn" style="font-family: myFont2"><h4>Cultural</h4></a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="technical.jsp" id="technicalbtn" style="font-family: myFont2"><h4>Technical</h4></a>
      </li>
       <li class="nav-item">
        <a class="nav-link active" href="gaming.jsp" id="gamingbtn" style="font-family: myFont2"><h4>Gaming</h4></a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="western.jsp" id="westernbtn" style="font-family: myFont2"><h4>Western</h4></a>
      </li>
       <li class="nav-item">
        <a class="nav-link active" href="more.jsp" id="morebtn" style="font-family: myFont2"><h4>More</h4></a>
      </li>
    </ul>
    <span class="navbar-text">
    <button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#exampleModal4">
		  Help?
		</button>
    <button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#exampleModal3">
		  Subscribe
		</button>
     <button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#exampleModal">
		  SignIn
		</button>
    </span>
  </div>
</nav>
    <%@page import="Connection.Conn"%>
	<%@page import="java.sql.*"%>
	<%@page import="java.io.OutputStream"%>
	<%@page import="java.io.*"%>

<!-- ------------------------------------------------------------- SPORTS-->
	<%
		try{
		Connection con = new Conn().getConnection();
		Statement st = con.createStatement();
		int Id;
		ResultSet rs=st.executeQuery("select * from event where catogory = 'sports';");
	%>	
	<div id="sports" class="page" ">
		<div class="jumbotron" style="background-color:#f8f9fa">
			<div align="center">
				<h1 style="font-family: myFont">SPORTS EVENTS</h1>
			</div>
		</div>
	
	<%	rs.last();
		do{
 		Id = rs.getInt(1); 
		String username1 = rs.getString(2);%> 
		<div class="card mb-3" style="margin:10%;font-family:myfont2" id="<%=rs.getInt(1)%>">
		<div class="card-header">
			<table id="customers">
				<tr>
					<td><img class="rounded-circle" src="<%="profilePics/"+rs.getString(2)+".jpg"%>" alt="Generic placeholder image" width="70" height="70"></td>
					<td style="padding-left:10px ;"><h1><%=rs.getString(2)%></h1>
						
						<p class="card-text"><small class="text-muted"><%="Posted on : "+rs.getString(10)%></small></p>
					</td>
				</tr>
				<tr>
					
				</tr>
			</table>  	
		  </div>
		  <img class="card-img" src="<%="Posters/"+rs.getInt(1)+".jpg"%>" alt="Card image" >
		  <div class="card-body">
		    <h1 class="card-title" style="font-family:myfont"><b><%=rs.getString(3).toUpperCase()%></b></h1>
		    <p class="card-text"><%=rs.getString(7)%></p>
		    <p class="card-text"><%="Date : "+rs.getString(5)%></p>
		    <p class="card-text"><small class="text-muted"><%=rs.getInt(6)+" day event"%></small></p>
		    <table id ="customers">
		    <tr>
		    	<th>Coordinator 1</th>
		    	<th>Coordinator 2</th>
		    </tr>
		    <tr>
		    	<td><p class="card-text"><%=rs.getLong(8)%></p></td>
		    	<td><p class="card-text"><%=rs.getLong(9)%></p></td>
		    </tr>
		    </table>
		  </div>
		</div>	
	
	<%
		}while(rs.previous());
			}catch(Exception ex){
				ex.printStackTrace();
			}	
	%>
	</div>
	
	
	
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Login</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<form action="AdminServlet" enctype="multipart/form-data" method="post" >
			  <div class="form-group">
			    <input type="text" class="form-control" id="eventname" aria-describedby="emailHelp" placeholder="username" name="username">
			  </div>
			  <div class="form-group">
			    <input type="password" class="form-control" id="eventname" aria-describedby="emailHelp" placeholder="password" name="password">
			  </div>
			  <div class="form-group">
			    <input type="text" class="form-control" id="eventname" aria-describedby="emailHelp" placeholder="Name" name="ftype" value="login" hidden>
			  </div>
			  <button type="submit" class="btn btn-primary">Submit</button>
			</form>
      </div>
      <div class="modal-footer">
    
      </div>
    </div>
  </div>
</div>







	<div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Subscribe to Sports</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<form action="" enctype="multipart/form-data" method="post" >
			  <div class="form-group">
			    <input type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="name" name="username">
			  </div>
			  <div class="form-group">
			    <input type="text" class="form-control" id="Phoneno" aria-describedby="emailHelp" placeholder="Phone no" name="phoneno">
			  </div>
			  <div class="form-group">
			    <input type="text" class="form-control" id="email" aria-describedby="emailHelp" placeholder="email" name="email">
			  </div>
			  <div class="form-group">
			    <input type="password" class="form-control" id="catogory" aria-describedby="emailHelp" value="cultural"  name="catogory" hidden>
			  </div>
			  <div class="form-group">
			    <input type="text" class="form-control" id="eventname" aria-describedby="emailHelp" placeholder="Name" name="ftype" value="subscription" hidden>
			  </div>
			  <button type="" class="btn btn-primary" id="subs">Submit</button>
			</form>
      </div>
      <div class="modal-footer" id="result">
    
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
	$(document).ready(function(){
		$('#subs').click(function(){
			username1 = $('#name').val();
			phoneno1 = $('#Phoneno').val();
			email1 = $('#email').val();
			
			$.ajax({
				url:"AdminServlet",
				type:"POST",
				data:{
	               ftype:"subscription",
	               username : username1,
	               phoneno : phoneno1,
	               email : email1,
	               catogory : "sports"
	                },
				success: function(data){
					console.log(data);
					if(data == "yes"){
						
					}
					else{
					
					}  
				},  
			});
		});
	});
</script>
<div class="modal fade" id="exampleModal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">ANY HELP?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     
     <iframe
    width="100%"
    height="430"
    src="https://console.dialogflow.com/api-client/demo/embedded/252ae186-4740-47c0-bda3-d5b0e1b0afa6">
</iframe>
      
      
    </div>
  </div>
</div>
</body>
</html>