package Admin;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Subscription.MailSender;


@WebServlet("/AdminServlet")
@MultipartConfig(maxFileSize = 10*6024*1024,maxRequestSize = 20*6024*6024,fileSizeThreshold = 5*6024*6024)
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    String organiser;  
	HttpSession session;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		session = request.getSession();
		//Getting request Type
		String requestType = request.getParameter("ftype");
		System.out.println(requestType+" ooooooooooooooooooooo");
		switch(requestType){
			case "login" :	int z =new AdminOperations().login(request.getParameter("username"), request.getParameter("password"));
				if(z == 1) {
					System.out.println("=========sssss=");
					session.setAttribute("organiser", request.getParameter("username"));
					if(request.getParameter("username").equals("admin"))
						response.sendRedirect("admin.jsp");
					else
						response.sendRedirect("head.jsp");
				}
				else {
					response.sendRedirect("index.jsp");
				}
				break;
			//Logout user	
			case "logout" : 
					session.invalidate();
					response.sendRedirect("index.jsp");
				break;
			// Request to delete Event
			case "deleteEvent" :	int i =new AdminOperations().deleteEvent(Integer.parseInt(request.getParameter("id")));
				if(i > 0) {
					//response.getWriter().write("eventdeleted");
					response.getWriter().write("yes");
				}
				else {
					//response.getWriter().write("eventnotdeleted");
					response.getWriter().write("no");
				}
				break;
			//Request to add Event
				
			case "addEvent" :
				System.out.println("Event add attempt");
				organiser = session.getAttribute("organiser").toString();
				int j = new AdminOperations().addEvent(organiser, request.getParameter("eventname"), request.getParameter("catogory"), request.getParameter("date"), Integer.parseInt(request.getParameter("duration")), request.getParameter("description"), request.getPart("image"), Long.parseLong(request.getParameter("phone1")), Long.parseLong(request.getParameter("phone2")));
				if(j > 0) {
					//response.getWriter().write("eventadded");
					session.setAttribute("addevent", "yes");
					response.sendRedirect("head.jsp");
				}
				else
					//response.getWriter().write("eventnotadded");
					response.sendRedirect("head.jsp");
					session.setAttribute("addevent", "no");
					break;
	
			// Request to delete coordinator
			case "deleteCoordinator" : int k = new AdminOperations().deleteCoordinator(Integer.parseInt(request.getParameter("id")));
				if(k > 0) {
					//response.getWriter().write("coordinatordeleted");
					session.setAttribute("deletecoordinator", "yes");
					response.getWriter().print("yes");
				}
				else {
					//response.getWriter().write("coordinatornotdeleted");
					session.setAttribute("deletecoordinator", "no");
					System.out.println("+jn.kj+2");
				}
				break;
			//Request to add coordinator
			case "addCoordinator" : int l = new AdminOperations().addCoordinator(request.getParameter("username"), request.getParameter("password1"), request.getParameter("password2"),request.getPart("image"));
				if(l > 0) {
					session.setAttribute("addcoordinator", "yes");
					response.sendRedirect("admin.jsp");
				}
				else {
					response.sendRedirect("admin.jsp");
				}
				break;
			//subscription	
			case "subscription" : int s = new AdminOperations().subscribe(request.getParameter("email"), Long.parseLong(request.getParameter("phoneno")), request.getParameter("username"), request.getParameter("catogory"));
				response.sendRedirect(request.getRequestURI());
				break;
			//delete Subscriber
			case "deletesubscriber" : new AdminOperations().deleteSubscriber(request.getParameter("email"));
				break;
		}
	}
}
