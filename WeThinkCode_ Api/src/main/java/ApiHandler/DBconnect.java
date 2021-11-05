package ApiHandler;
//import com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException;

import io.javalin.http.Context;
import org.json.JSONObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.DriverManager;

public class DBconnect {
    private Connection connect = null;
    private Statement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;


    public Connection connection() throws SQLException {
        return DriverManager
                .getConnection("jdbc:mysql://localhost/tickets?"
                        + "user=kali&password=root");
    }


    public ResultSet readDataBase(
    ) throws Exception {
        try {
            // This will load the MySQL driver, each DB has its own driver
            Class.forName("com.mysql.jdbc.Driver");
            // Setup the connection with the DB
            connect = connection();

            // Statements allow to issue SQL queries to the database
            statement = connect.createStatement();
            // Result set get the result of the SQL query
            return statement
                    .executeQuery("select * from tickets");
//

        } catch (Exception e) {
            throw e;
        } finally {
//            close();
        }

    }

    private void close() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }

            if (statement != null) {
                statement.close();
            }

            if (connect != null) {
                connect.close();
            }
        } catch (Exception e) {

        }
    }
    public void writeDatabase(Ticket ticket) throws SQLException {
        Connection connection = connection();
        // INSERT INTO comments values (default, 'lars', 'myemail@gmail.com','https://www.vogella.com/', '2009-09-14 10:33:11', 'Summary','My first comment' );

        statement = connection.createStatement();
        System.out.println("insert into tickets values (default,"+ticket.getTicketOwner()+","
                +ticket.getCampus()+ ","+
                ticket.getIssue()+ ","+
                ticket.getFloor()+ ","+
//                ticket.getIssue()+ ","+
                ticket.completed(Completed.INCOMPLETE)+")");
        statement.executeUpdate("insert into tickets(username,campus,issue,completed,floor) values ("
                + "\"" + ticket.getTicketOwner()+"\","
                + "\"" + ticket.getCampus()+ "\","
                + "\"" + ticket.getIssue()+ "\","
                + "\"" + ticket.completed(Completed.INCOMPLETE)+"\","
                + "\"" + ticket.getFloor()+ "\")"
        );
        connection.close();
    }

    public void updateDatabase(Context context) throws SQLException {
        Connection connection = connection();
        String status = context.pathParam("status");
        String id = context.pathParam("id");
        // INSERT INTO comments values (default, 'lars', 'myemail@gmail.com','https://www.vogella.com/', '2009-09-14 10:33:11', 'Summary','My first comment' );

        statement = connection.createStatement();
        System.out.println("update tickets set completed="+status+" where id="+id);
        statement.executeUpdate("update tickets set completed='"+status.toUpperCase()+"' where id='"+id+"'");

        context.json("Ticket "+id+":\n has been updated to "+status);
        connection.close();
    }

    public void resetCounter(int id, Context context) throws SQLException {
        Connection connection = connection();
        // INSERT INTO comments values (default, 'lars', 'myemail@gmail.com','https://www.vogella.com/', '2009-09-14 10:33:11', 'Summary','My first comment' );
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
                "primary key(id))"
        );
        System.out.println("create table tickets (id INT NOT NULL AUTO_INCREMENT," +
                "username VARCHAR(30) NOT NULL," +
                "campus VARCHAR(30) NOT NULL," +
                "issue VARCHAR("+id+") NOT NULL," +
                "completed VARCHAR(15),"+
                "floor INT,"+
                "primary key(id))");


        connection.close();
    }

    public void dropTables(Context context) throws SQLException {
        Connection connection = connection();
        // INSERT INTO comments values (default, 'lars', 'myemail@gmail.com','https://www.vogella.com/', '2009-09-14 10:33:11', 'Summary','My first comment' );

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
