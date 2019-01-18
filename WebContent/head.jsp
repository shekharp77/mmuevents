<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    String username =  "Admin";
    	try{
 
    	 username = request.getSession().getAttribute("organiser").toString();
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="jsfiles/deleteevent.js"></script>
<title>HEAD COORDINATOR</title>
<script type="text/javascript">
	$(document).ready(function(){
		$('#addevent').hide();
		
		$('#myeventbtn').click(function(){
			$('#myevent').fadeIn();
			$('#addevent').hide();
		})
		$('#addeventsbtn').click(function(){
			$('#myevent').hide();
			$('#addevent').fadeIn();
		})
	});
</script>
</head>
<body>
	
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<img class="rounded-circle" src="<%="profilePics/"+username.toLowerCase()+".jpg" %>" alt="Generic placeholder image" width="50" height="50">
  <a class="navbar-brand" href="#" id="myeventbtn">&nbsp;MY EVENTS</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link active" href="#" id="addeventsbtn">Add Events</a>
      </li>
    </ul>
    <span class="navbar-text">
      <form action="AdminServlet" enctype="multipart/form-data" method="post" >
    <div class="form-group">
	    <input type="text" class="form-control" id=""  name="ftype" value="logout" hidden>
	  </div>
      <button type="submit" class="btn btn-outline-danger ">LogOut</button>
      </form>
    </span>
  </div>
</nav>


 <%@page import="Connection.Conn"%>
	<%@page import="java.sql.*"%>
	<%@page import="java.io.OutputStream"%>
	<%@page import="java.io.*"%>
	
<!-- ------------------------------------------------------------- add event-->
	<div id="myevent">
	<%
		try{
		Connection con = new Conn().getConnection();
		Statement st = con.createStatement();
		int Id;
		ResultSet rs=st.executeQuery("select * from event where organiser = '"+username+"';");
		rs.last();
		do{
 		Id = rs.getInt(1); 
		String username1 = rs.getString(2);%> 
		<div class="card mb-3" style="margin:10%" id="<%=rs.getInt(1)+"parent"%>">
		<div class="card-header">
			<div align="right">
				<a class="btn btn-outline-danger" id="<%=rs.getInt(1)%>" style="font-color:red">Delete</a>
			</div>	
		  </div>
		  <img class="card-img" src="<%="Posters/"+rs.getInt(1)+".jpg"%>" alt="Card image" >
		  <div class="card-body">
		    <h2 class="card-title"><%=rs.getString(3)%></h2>
		    <p class="card-text"><%=rs.getString(7)%></p>
		    <p class="card-text"><%="Date : "+rs.getString(5)%></p>
		    <p class="card-text"><small class="text-muted"><%=rs.getInt(6)+" day event"%></small></p>
		    <p class="card-text"><%="Phone 1 : "+rs.getLong(8)%></p>
		    <p class="card-text"><%="Phone 2 : "+rs.getLong(9)%></p>
		  </div>
		</div>
	
	<%
		}while(rs.previous());
			}catch(Exception ex){
				ex.printStackTrace();
			}	
	%>
	</div>
	
	
<div id="addevent" style="margin:20%">
	<div class="jumbotron">
		<div align="center">
			<h1>ADD EVENT</h1>
		</div>
	</div>
	<form action="AdminServlet" enctype="multipart/form-data" method="post" >
	  <div class="form-group">
	    <input type="text" class="form-control" id="eventname" aria-describedby="emailHelp" placeholder="Name" name="eventname" required>
	  </div>
	  <div class="form-group">
	    <input type="file" class="form-control" id="image" placeholder="image" name="image" required>
	  </div>
	  <select id="catogory" class="form-control" name="catogory" required>
        <option selected>Technical</option>
        <option>Sports</option>
        <option >Western</option>
        <option>Cultural</option>
        <option >Gaming</option>
        <option>more</option>
      </select>
      <br>
	  <div class="form-group">
	    <input type="text" class="form-control" id="description" placeholder="Description" name="description" required>
	  </div>
	  <div class="form-group">
	    <input type="date" class="form-control" id="date" placeholder="Starting date" name="date" required>
	  </div>
	  <div class="form-group">
	    <input type="text" class="form-control" id="duration" placeholder="No of days" name="duration" required>
	  </div>
	   <div class="form-group">
	    <input type="text" class="form-control" id="phone1" placeholder="1st Phone number" name="phone1" required>
	  </div>
	   <div class="form-group">
	    <input type="text" class="form-control" id="phone2" placeholder="2nd Phone number" name="phone2" required>
	  </div>
	  <div class="form-group">
	    <input type="text" class="form-control" id="addEvent"  name="ftype" value="addEvent" hidden>
	  </div>
	  <button type="" class="btn btn-primary" id="sub">Submit</button>
	</form>
	</div>
	
<script type="text/javascript">
	$(document).ready(function(){
			$('#sub').click(function(){
				location.reload();
			});
	});
</script>


<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">ERROR !!!!</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        An Error Occured while deleting the Event.
      </div>
      <div class="modal-footer" style="background-color: #da0e0e;">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
  </div>
  
  <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">ERROR !!!!</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        An Error Occured while Adding the Event.
      </div>
      <div class="modal-footer" style="background-color: #da0e0e;">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
  </div>
<script type="text/javascript">
	
</script>
</body>
</html>