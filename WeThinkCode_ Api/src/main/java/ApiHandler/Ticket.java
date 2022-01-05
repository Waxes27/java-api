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

import com.mysql.cj.xdevapi.DbDoc;


public class Ticket implements TicketInterface{

    private String campus;
    private String issue;
    private Category category;
    private Completed complete;
    private String ticketOwner;
    private long referenceId;
    private int id;
    private int floor;
    private Date date;
    private String assignee;

    @Override
    public void setCategory(Category value){
        category = value;
    };

    @Override
    public Category getCategory(){
        return category;
    };

    @Override
    public String getTicketRefId(Context context) {
        // System.out.println(context.body());
        DBconnect dBconnect = new DBconnect();
        try {
            System.out.println(context.body());
            dBconnect.getTicketId(context);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "";
        }

    @Override
    public long getReferenceId(){
        return referenceId;
    };


    @Override
    public void setReferenceId(){
        this.referenceId = System.currentTimeMillis();
        System.out.println("\n\n\n\n\n\n"+Long.toString(this.referenceId));
    };

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
                , data.getString(4)
                , data.getString(5)
                ,data.getString(6)
                ,data.getString(7)
                ,data.getString(8)
                ,data.getString(9)));
        }
        // context.json(tickets);

        return tickets;
    }

    public HashMap<String,String> serializeTicket(String id,String username,String campus, String issue,String completed,String floor,String date,String category,String referenceId){
        HashMap<String,String> ticket = new HashMap<>();
        ticket.put("id", id);
        ticket.put("username", username);
        ticket.put("campus", campus);
        ticket.put("issue", issue);
        ticket.put("completed", completed);
        ticket.put("floor",floor);
        ticket.put("date", date);
        ticket.put("category",category);
        ticket.put("referenceId",referenceId);
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

    public List<HashMap<String,String>> getUserTickets(Context context) throws SQLException{
        String username = context.pathParam("user");
        List<HashMap<String,String>> tickets = new ArrayList<>();
        DBconnect connection = new DBconnect();
        ResultSet data = connection.readDataBaseForUserTickets(username);
        while (data.next()){
            tickets.add(serializeTicket(
                data.getString(1)
                , data.getString(2)
                , data.getString(3)
                , data.getString(4)
                , data.getString(5)
                ,data.getString(6)
                ,data.getString(7)
                ,data.getString(8)
                ,data.getString(9)));
        }
        
        return tickets;
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
        newTicket.setDate(context);
        newTicket.setReferenceId();

        switch (ticket.get("category").toString()){
            case "hardware":
                newTicket.setCategory(Category.HARDWARE);
                break;
            case "software":
                newTicket.setCategory(Category.SOFTWARE);
                break;
            case "lms":
                newTicket.setCategory(Category.LMS);
                break;
            default:
                newTicket.setCategory(Category.OTHER);

        }

        System.out.println(newTicket);
        


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
                "\"date\":\"" + this.date + "\"," +
                "\"category\":\"" + this.category + "\"," +
                "\"referenceId\":\"" + this.referenceId + "\"" +
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
    public Date getDate() {
        return this.date;
    }

    @Override
    public void setDate(Context context) {
        // System.out.println("DATE CONTEXT: "+context);
        JSONObject data = new JSONObject(context.body());
        this.date = data.get("date");
        // Date dateTemp = new Date(System.currentTimeMillis());
        // SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        
        // this.date = formatter.format(dateTemp);
    }

    @Override
    public Ticket setStaff(Context context) throws SQLException {
        DBconnect dBconnect = new DBconnect();
        String staff = context.pathParam("staff");
        dBconnect.assignStaff(this,staff);
        return null;
    }

    
}
