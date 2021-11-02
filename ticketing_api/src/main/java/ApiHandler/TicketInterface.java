package ApiHandler;

import io.javalin.http.Context;
import org.json.JSONObject;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface TicketInterface {
     String campus = null;

     String getIssue();

     String getTicketOwner();

     String getCampus();

     String getIssueAsString();

     List<HashMap<String,String>> getAllTickets(Context context) throws Exception;

     int getTicketId();

     void setTicketId(int id);

     void setTicketOwner(String owner);

     void storeTicket(Ticket ticket) throws Exception;

     void setCampus(String campus);

     void setIssue(String issue);

     Ticket setAll(String ticket, Context context) throws Exception;

     boolean completed(boolean complete);

     void reset(int id,Context context) throws SQLException;

     void dropTable() throws SQLException;
}
