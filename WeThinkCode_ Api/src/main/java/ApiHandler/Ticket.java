package ApiHandler;

import io.javalin.http.Context;
import org.json.JSONObject;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Ticket implements TicketInterface{

    private String campus;
    private String issue;
    private Completed complete;
    private String ticketOwner;
    private int id;

    @Override
    public String getIssue() {
        return this.issue;
    }

    @Override
    public String getTicketOwner() {
        return this.ticketOwner;
    }

    @Override
    public String getCampus() {
        return this.campus;
    }

    @Override
    public String getIssueAsString() {
        return null;
    }

    @Override
    public List<HashMap<String,String>> getAllTickets(Context context) throws Exception {
        DBconnect dBconnect = new DBconnect();
        List<HashMap<String,String>> tickets = new ArrayList<>();
        ResultSet data = dBconnect.readDataBase();

        while (data.next()){
            String id = data.getString(1);
            String username = data.getString(2);
            String campus = data.getString(3);
            String issue = data.getString(4);
            String completed = data.getString(5);
            tickets.add(serializeTicket(id, username, campus, issue, completed));
        }
        context.json(tickets);

        return tickets;
    }

    public HashMap<String,String> serializeTicket(String id,String username,String campus, String issue,String completed){
        HashMap<String,String> ticket = new HashMap();
        ticket.put("id", id);
        ticket.put("username", username);
        ticket.put("campus", campus);
        ticket.put("issue", issue);
        ticket.put("completed", completed);
        return ticket;
    }

    @Override
    public int getTicketId() {
        return this.id;
    }

    @Override
    public void setTicketId(int id) {
        this.id = id;
    }


    @Override
    public void setTicketOwner(String owner) {
        this.ticketOwner = owner;
    }

    @Override
    public void storeTicket(Ticket ticket) throws Exception {
        System.out.println("Storing Ticket"+ticket+" with ID:"+ticket.getTicketId());

        DBconnect connection = new DBconnect();
        connection.writeDatabase(ticket);
    }

    @Override
    public void setCampus(String campus) {
        this.campus = campus;
    }

    @Override
    public void setIssue(String issue) {
        this.issue = issue;
    }

    @Override
    public Ticket setAll(String command, Context context) throws Exception {
        Ticket newTicket = new Ticket();

        JSONObject ticket = new JSONObject(command);

//        System.out.println(ticket);

        newTicket.setCampus(ticket.get("campus").toString());
        newTicket.setTicketOwner(ticket.get("author").toString());
//        newTicket.setTicketId(1);
        newTicket.setIssue(ticket.get("issue").toString());
        newTicket.completed(Completed.INCOMPLETE);



//        toUser(context);
        storeTicket(newTicket);
        return newTicket;
    }

    @Override
    public Completed completed(Completed complete) {
        this.complete = complete;
        return complete;
    }

    @Override
    public String toString(){

        String command =  "{" +
                "\"ticketOwner\":\"" + this.ticketOwner + "\"," +
                "\"campus\":\"" + this.campus+ "\"," +
                "\"issue\":\"" + this.issue + "\"," +
                "\"ticketId\":\"" + this.id + "\"," +
                "\"completed\":\"" + this.complete + "\"" +
                "}"
                ;
        return command;
    }

    public void reset(int id,Context context) throws SQLException {
        DBconnect dBconnect = new DBconnect();
        dBconnect.resetCounter(id,context);
    }

    @Override
    public void dropTable() throws SQLException {
        DBconnect dBconnect = new DBconnect();
        dBconnect.dropTables();
    }

    @Override
    public void updateTicket(Context context) throws SQLException {
        DBconnect dBconnect = new DBconnect();
        dBconnect.updateDatabase(context);

    }
}
