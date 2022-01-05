package ApiHandler;
import io.javalin.http.Context;
import org.json.JSONObject;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.DriverManager;

public class DBconnect {
    private Connection connect = null;
    private Statement statement = null;



    public Connection connection() throws SQLException {
        return DriverManager
                .getConnection("jdbc:mysql://localhost/tickets?"
                        + "user=kali&password=root");
    }


    public ResultSet readDataBaseForUserTickets(String username) throws SQLException {
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        connect = connection();

        statement = connect.createStatement();
        return statement
                .executeQuery("select * from tickets where username='"+username+"'");
}




    public ResultSet readDataBase() throws SQLException {
        
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            connect = connection();

            statement = connect.createStatement();
            return statement
                    .executeQuery("select * from tickets");
    }

    public void writeDatabase(Ticket ticket) throws SQLException {
        Connection connection = connection();
        statement = connection.createStatement();

        statement.executeUpdate("insert into tickets(username,campus,issue,completed,floor,date,category,reference_id) values ("
                + "\"" + ticket.getTicketOwner()+"\","
                + "\"" + ticket.getCampus()+ "\","
                + "\"" + ticket.getIssue()+ "\","
                + "\"" + ticket.completed(Completed.INCOMPLETE)+"\","
                + "\"" + ticket.getFloor()+ "\","
                + "\"" + ticket.getDate() + "\","
                + "\"" + ticket.getCategory() + "\","
                + "\"" + ticket.getReferenceId() + "\""
                + ")"
        );
        connection.close();
    }


    public void assignStaff(Ticket ticket,String assignee) throws SQLException {
        Connection connection = connection();
        statement = connection.createStatement();

        statement.executeUpdate("insert into tickets(username,campus,issue,completed,floor,date,category,reference_id,assignee) values ("
                + "\"" + ticket.getTicketOwner()+"\","
                + "\"" + ticket.getCampus()+ "\","
                + "\"" + ticket.getIssue()+ "\","
                + "\"" + ticket.completed(Completed.INCOMPLETE)+"\","
                + "\"" + ticket.getFloor()+ "\","
                + "\"" + ticket.getDate() + "\","
                + "\"" + ticket.getCategory() + "\","
                + "\"" + ticket.getReferenceId() + "\","
                + "\"" + assignee + "\""
                + ")"
        );
        connection.close();
    }

    public void getTicketId(Context context) throws SQLException{
        Connection connection = connection();
        statement = connection.createStatement();


        JSONObject data =  new JSONObject(context.body());
        System.out.println("CONTEXT IN TICKET ID: "+data);
        ResultSet setOfdata = statement.executeQuery("select * from tickets where date=\""+data.get("date")+"\";");
        
        while (setOfdata.next()){
            System.out.println(setOfdata.getString(9));
            context.json(setOfdata.getString(9));
            break;
        }
        

    }

    public void updateDatabase(Context context) throws SQLException {
        Connection connection = connection();
        String status = context.pathParam("status");
        String id = context.pathParam("id");

        statement = connection.createStatement();
        statement.executeUpdate("update tickets set completed='"+status.toUpperCase()+"' where id='"+id+"'");

        context.json("Ticket "+id+":\n has been updated to "+status);
        connection.close();
    }

    public void resetCounter(int id, Context context) throws SQLException {
        Connection connection = connection();
        JSONObject query = new JSONObject(context.body());

        statement = connection.createStatement();
        if (query.get("password").equals("beresponsibleWithApis@2015")) {
            statement.executeUpdate("delete from tickets");
            statement.executeUpdate("alter table tickets auto_increment = " + id);
            connection.close();
            context.json("Deleted Data and Reset Table");
        }
        else {
            context.json("Password Incorrect");
        }
    }

    public void createTables(Context context) throws SQLException {

        Connection connection = connection();
        String id = context.pathParam("id");

        statement = connection.createStatement();
        statement.executeUpdate("create table tickets (id INT NOT NULL AUTO_INCREMENT," +
                "username VARCHAR(30) NOT NULL," +
                "campus VARCHAR(30) NOT NULL," +
                "issue VARCHAR("+id+") NOT NULL," +
                "completed VARCHAR(15),"+
                "floor INT,"+
                "date DATETIME," +
                "category VARCHAR(10)," +
                "reference_id VARCHAR(20) UNIQUE," +
                "assignee VARCHAR(30)," +
                "primary key(id))"
        );
        connection.close();
    }

    public void dropTables(Context context) throws SQLException {
        Connection connection = connection();
        statement = connection.createStatement();
        try {
            statement.executeUpdate("drop table tickets");
        }catch (Exception e) {
            createTables(context);
        }
        createTables(context);
        connection.close();
    }
}
