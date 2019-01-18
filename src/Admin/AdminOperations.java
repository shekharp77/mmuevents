package Admin;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.mail.MessagingException;
import javax.servlet.http.Part;

import Connection.Conn;
import MyCrypto.Crypto;
import Subscription.MailSender;

public class AdminOperations{
	
	Connection con = new Conn().getConnection();
	static String catogory;
	static int id;
	
	// Add a coordinator
	public int addCoordinator(String username, String password, String password2, Part image) {
		int i = 0;
		InputStream stream;
		try {
			stream = image.getInputStream();
			PreparedStatement preparedStatement = con.prepareStatement("insert into Coordinator(username,password) values(?,?);");
			preparedStatement.setString(1, username.toLowerCase());
			preparedStatement.setString(2, Crypto.encrypt(password));
			i = preparedStatement.executeUpdate();
			if(i > 0) {
				ResultSet rs = con.createStatement().executeQuery("select id from Coordinator where username ='"+username+"';");
				rs.last();
				int id = rs.getInt(1);
				if(id > 0) {
					new AdminOperations().profilePics(stream, username);
				}
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
		return i;
	}
	
	
	
	// Delete a coordinator
	public int deleteCoordinator(int id) {
		int i = 0;
		try {
			ResultSet rs = con.createStatement().executeQuery("Select * from coordinator where id = '"+id+"';");
			rs.next();
			i = con.createStatement().executeUpdate("delete from coordinator where id = '"+id+"';");
				con.createStatement().executeUpdate("delete from event where organiser = '"+rs.getString(2)+"';");
				Files.deleteIfExists(Paths.get("C:\\Users\\user\\eclipse-workspace\\MMUEvents\\WebContent\\profilePics\\"+rs.getString(2)+".jpg"));
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;
	}
	
	
	
	// Add a new event
	public int addEvent(String organiser, String eventName, String catogory, String date, int duration, String description, Part image, long phone1, long phone2) {
		int i = 0;
		AdminOperations.catogory = catogory;
		InputStream stream;
		try {
			stream = image.getInputStream();
			 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
			 LocalDateTime now = LocalDateTime.now(); 
			 String cdate = dtf.format(now);
			PreparedStatement preparedStatement = con.prepareStatement("insert into Event(organiser,name,catogory,date,duration,description,phone1,phone2,cdate) values(?,?,?,?,?,?,?,?,?);");
			preparedStatement.setString(1, organiser);
			preparedStatement.setString(2, eventName);
			preparedStatement.setString(3, catogory);
			preparedStatement.setString(4, date);
			preparedStatement.setString(6, description);
			preparedStatement.setInt(5, duration);
			preparedStatement.setLong(7, phone1);
			preparedStatement.setLong(8, phone2);
			preparedStatement.setString(9, cdate);
			i = preparedStatement.executeUpdate();
			if(i > 0) {
				ResultSet rs = con.createStatement().executeQuery("select id from Event where name ='"+eventName+"';");
				rs.last();
				id = rs.getInt(1);
				if(id > 0) {
					new AdminOperations().posters(stream, id);	
					new AdminOperations().mailSender(catogory, id);	
				}
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
		return id;
	}
	
	
	
	// Delete Event
	public int deleteEvent(int id) {
		int i = 0;
		try {
			i =con.createStatement().executeUpdate("delete from Event where id = '"+id+"';");
			Files.deleteIfExists(Paths.get("C:\\Users\\user\\eclipse-workspace\\MMUEvents\\WebContent\\Posters\\"+id+".jpg"));
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;
	}
	
	
	
	//Method to add poster
	public void posters(InputStream input, int id){
        FileOutputStream fos = null;
        
        try {
            fos = new FileOutputStream("C:\\Users\\user\\eclipse-workspace\\MMUEvents\\WebContent\\Posters\\"+id+".jpg");
            {
                int i=0;
                i++;
                int c = 0;
                while ((c = input.read()) > -1) {
                    fos.write(c);
                }
            }
            input.close();
            fos.close();
        } catch (Exception ex) {
           ex.printStackTrace();
        }
  }
	
	//Method to add profilepics
		public void profilePics(InputStream input, String username){
			username = username.toLowerCase();
	        FileOutputStream fos = null;
	        System.out.println("=============================5");
	        try {
	            fos = new FileOutputStream("C:\\Users\\user\\eclipse-workspace\\MMUEvents\\WebContent\\profilePics\\"+username+".jpg");
	            {
	                int i=0;
	                i++;
	                int c = 0;
	                while ((c = input.read()) > -1) {
	                    fos.write(c);
	                }
	            }
	            input.close();
	            fos.close(); 
	            System.out.println("=============================4");
	        } catch (Exception ex) {
	           ex.printStackTrace();
	        }
	  }
		
		//Method to login
		public int login(String username, String password) {
			System.out.println("==-=-=-=-=-=-=-=-=-=-=-"+password);
			
			try {
				ResultSet rs = con.createStatement().executeQuery("Select * from coordinator where username = '"+username.toLowerCase()+"' and password = '"+Crypto.encrypt(password)+"';");
				if(rs.next())
					return 1;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return 0;
		}
		
		//Subscribe
		public int subscribe(String email, Long phone, String name,String catogory) {
			int i = 0;
			try {
			PreparedStatement preparedStatement = con.prepareStatement("insert into subscribers values(?,?,?,?);");
			preparedStatement.setString(1, email);
			preparedStatement.setLong(2, phone);
			preparedStatement.setString(3, name);
			preparedStatement.setString(4, catogory);
			i = preparedStatement.executeUpdate();
			return i;
			}catch(Exception ex) {
				ex.printStackTrace();
			}
			return i;
		}
		
		public void mailSender(String catogory, int id) {
			System.out.println("===========Sending11111");
			try {
				String url = "C:\\Users\\user\\eclipse-workspace\\MMUEvents\\WebContent\\Posters\\"+id+".jpg";
				
				ResultSet rs = con.createStatement().executeQuery("select * from subscribers where target ='"+catogory+"';");
				while(rs.next()) {
					System.out.println("===========Sending");
					MailSender.send(rs.getString(1), "New Event at MMDU", "We have a new event under "+catogory, url);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		public void deleteSubscriber(String email) {
			try {
				System.out.println(email+" ===================");
				 con.createStatement().executeUpdate("delete from subscribers where email = '"+email+"';");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
}
