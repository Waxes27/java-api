package ApiHandler;

import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface TicketInterface {
//     String campus = null;

     String getIssue();
 
     String getTicketOwner();

     String getCampus();

     Ticket setStaff(Context context) throws SQLException;

     String getIssueAsString();

     List<HashMap<String,String>> getAllTickets(Context context) throws Exception;

     int getTicketId();


     int getFloor();

     void setTicketId(int id);

     void setTicketOwner(String owner);

     void storeTicket(Ticket ticket) throws Exception;

     void setCampus(String campus);

     void setIssue(String issue);

     Ticket setAll(String ticket, Context context) throws Exception;

     Completed completed(Completed complete);

     void reset(int id,Context context) throws SQLException;

     void dropTable(Context context) throws SQLException;

     void updateTicket(Context context) throws SQLException;

     void setFloor(String floor);

     String getDate();

     void setDate(Context context);

     long getReferenceId();

     void setReferenceId();

     void setCategory(Category value);

     Category getCategory();

     String getTicketRefId(Context context);
}
