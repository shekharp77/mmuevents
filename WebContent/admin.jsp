<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<script src="jsfiles/deleteuser.js"></script>
<script src="jsfiles/deletesubscriber.js"></script>
<title>ADMINISTRATOR</title>




<script type="text/javascript">
	$(document).ready(function(){
		$('#adduser').hide();
		$('#subslist').hide();
		
		$('#userlistbtn').click(function(){
			$('#userlist').fadeIn()
			$('#adduser').hide();
			$('#subslist').hide();
		})
		$('#adduserbtn').click(function(){
			$('#userlist').hide();
			$('#adduser').fadeIn();
			$('#subslist').hide();
		})
		$('#subsbtn').click(function(){
			$('#userlist').hide();
			$('#adduser').hide();
			$('#subslist').fadeIn();
		})
		
	});
</script>
<style type="text/css" >
	
	th{
		border:3px solid black;
		color:blue;
	}
	td{
		border: 2px solid black;
	}
	#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #4CAF50;
    color: white;
}
</style>
</head>
	
<body>	
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <a class="navbar-brand" href="#" >ADMIN PAGE</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#" id="adduserbtn">Add User</a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="#" id="userlistbtn">User list</a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="#" id="subsbtn">Subscribers list</a>
      </li>
    </ul>
    <span class="navbar-text">
    <form action="AdminServlet" enctype="multipart/form-data" method="post" >
    	<div class="form-group">
	    <input type="text" class="form-control" id="addEvent"  name="ftype" value="logout" hidden>
	  </div>
      <button type="submit" class="btn btn-outline-danger ">LogOut</button>
      </form>
    </span>
  </div>
</nav>



<div id="adduser" style="margin:20%">
	<div class="jumbotron">
		<div align="center">
			<h1>ADD USER</h1>
		</div>
	</div>
	<form action="AdminServlet" enctype="multipart/form-data" method="post">
	  <div class="form-group" >
	    <input type="text" class="form-control" id="username" aria-describedby="emailHelp" placeholder="Enter Name" name="username" required>
	  </div>
	  <div class="form-group">
	    <input type="password" class="form-control" id="Password1" placeholder="Password" name="password1" required>
	  </div>
	  <div class="form-group">
	    <input type="password" class="form-control" id="Password2" placeholder="Re-enter Password" name="password2" required>
	  </div>
	  <div class="form-group">
	  	<input type="file" class="form-control"name="image" id="image" required>
	  </div>
	  	  <div class="form-group">
	    <input type="text" class="form-control" id="exampleInputPassword1"  name="ftype" value="addCoordinator" hidden>
	  </div>
	  <button type="submit" class="btn btn-primary" id="submitbtn">Submit</button>
	</form>
</div>

 <%@page import="Connection.Conn"%>
	<%@page import="java.sql.*"%>
	<%@page import="java.io.OutputStream"%>
	<%@page import="java.io.*"%>
	<%@page import="MyCrypto.*"%>

	<%
		try{
		Connection con = new Conn().getConnection();;
		Statement st = con.createStatement();
		int Id;
		ResultSet rs=st.executeQuery("select * from coordinator;");
	%>	
<div id="userlist" align="center" style="margin:10%">
	 <table id ="customers" class="responsive">
    <thead>
      <tr>
        <th>USERNAME</th>
        <th>PASSWORD</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody>
    <%
    	while(rs.next()){
    		String password = Crypto.decrypt(rs.getString(3));
    %>
      
      <%if(!rs.getString(2).equals("admin")) {%>
      <tr id="<%=rs.getInt(1)+"r"%>">
        <td><%=rs.getString(2) %></td>
        <td><%= password%></td>
        <td><a class="btn btn-outline-danger" name="<%=rs.getInt(1)%>" id="deleteuserbtn">Delete</a></td>
       </tr>
        <%
        }
        %>
      
      <%
    	}
		}catch(Exception ex){
			ex.printStackTrace();
		}	
      %>
    </tbody>
  </table>
</div>
 	<%@page import="Connection.Conn"%>
	<%@page import="java.sql.*"%>
	<%@page import="java.io.OutputStream"%>
	<%@page import="java.io.*"%>



<%
		try{
		Connection conn = new Conn().getConnection();;
		Statement st = conn.createStatement();
		int Id;
		ResultSet ps=st.executeQuery("select * from subscribers;");
	%>	
<div id="subslist" align="center" style="margin:10%">

	 <table id ="customers" class="responsive">
    <thead>
      <tr>
        <th>Name</th>
        <th>Phone No</th>
        <th>Email</th>
        <th>Category</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody>
    <%
    	while(ps.next()){
    %>    
      <tr id="<%=ps.getString(1)+ps.getString(4)%>">
      	<td><%=ps.getString(3) %></td>
        <td><%=ps.getLong(2) %></td>
        <td><%=ps.getString(1) %></td>
        <td><%=ps.getString(4) %></td>
        <td><a class="btn btn-outline-danger" name="<%=ps.getString(1)%>" id="deleteuserbtn">Delete</a></td>
       </tr>
      <%
    	}
		}catch(Exception ex){
			ex.printStackTrace();
		}	
      %>
    </tbody>
  </table>
</div>












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
        An Error Occured while deleting the user.
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
                An Error Occured while Adding the user.
      </div>
      <div class="modal-footer" style="background-color: #da0e0e;">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
  </div>
 <%--  <%
  	if(request.getSession().getAttribute("addcoordinator").equals("no")){
  	 %> 
  	 	<script>
  			$('#exampleModal2').modal('show')
  	 	</script>
  	 <%
  	 	request.getSession().setAttribute("addcoordinator", "no");
  	}
  %> --%>
  
  </body>
  </html>
