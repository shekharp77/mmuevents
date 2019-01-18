package Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class Conn {

    private  Connection con;
    public Conn(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
           ex.printStackTrace();
        }
            String id="root";
            String pwd="1234";
            String url="jdbc:mysql://localhost:3306/mmuevent";
            
        try {
            con = DriverManager.getConnection(url,id,pwd);
        } catch (SQLException ex) {
           ex.printStackTrace();
        }
    }
    public  Connection getConnection(){
            return con;
        }
}
