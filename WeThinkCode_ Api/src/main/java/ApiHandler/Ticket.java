package ApiHandler;

import io.javalin.http.Context;
import org.json.JSONObject;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


public class Ticket implements TicketInterface{

    private String campus;
    private String issue;
    private Completed complete;
    private String ticketOwner;
    private int id;
    private int floor;
    private String date;

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
            tickets.add(serializeTicket(
                data.getString(1)
                , data.getString(2)
                , data.getString(3)
                , data.getString(4), data.getString(5),data.getString(6)
                ,data.getString(7)));
        }
        context.json(tickets);

        return tickets;
    }

    public HashMap<String,String> serializeTicket(String id,String username,String campus, String issue,String completed,String floor,String date){
        HashMap<String,String> ticket = new HashMap<>();
        ticket.put("id", id);
        ticket.put("username", username);
        ticket.put("campus", campus);
        ticket.put("issue", issue);
        ticket.put("completed", completed);
        ticket.put("floor",floor);
        ticket.put("date",date);
        return ticket;
    }

    @Override
    public int getTicketId() {
        return this.id;
    }

    @Override
    public int getFloor() {
        return this.floor;
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

        newTicket.setCampus(ticket.get("campus").toString());
        newTicket.setTicketOwner(ticket.get("author").toString());
        newTicket.setIssue(ticket.get("issue").toString());
        newTicket.setFloor(ticket.get("floor").toString());
        newTicket.completed(Completed.INCOMPLETE);
        newTicket.setDate();


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

        return "{" +
                "\"ticketOwner\":\"" + this.ticketOwner + "\"," +
                "\"campus\":\"" + this.campus+ "\"," +
                "\"issue\":\"" + this.issue + "\"," +
                "\"ticketId\":\"" + this.id + "\"," +
                "\"completed\":\"" + this.complete + "\"," +
                "\"floor\":\"" + this.floor + "\"," +
                "\"date\":\"" + this.date + "\"" +
                "}"
                ;
    }

    public void reset(int id,Context context) throws SQLException {
        DBconnect dBconnect = new DBconnect();
        dBconnect.resetCounter(id,context);
    }

    @Override
    public void dropTable(Context context) throws SQLException {
        DBconnect dBconnect = new DBconnect();
        dBconnect.dropTables(context);
    }

    @Override
    public void updateTicket(Context context) throws SQLException {
        DBconnect dBconnect = new DBconnect();
        dBconnect.updateDatabase(context);

    }

    @Override
    public void setFloor(String floor) {
        this.floor = Integer.parseInt(floor);
    }

    @Override
    public String getDate() {
        return this.date;
    }

    @Override
    public void setDate() {
        Date dateTemp = new Date(System.currentTimeMillis());
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        
        this.date = formatter.format(dateTemp);
    }
}
