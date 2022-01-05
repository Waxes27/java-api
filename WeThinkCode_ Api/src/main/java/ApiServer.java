import ApiHandler.DBconnect;
import ApiHandler.Ticket;
// import com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException;

import java.sql.ResultSet;
import java.sql.SQLException;
import io.javalin.Javalin;
import io.javalin.core.JavalinConfig;
import io.javalin.http.Context;

import java.util.HashMap;
import java.util.List;

import com.mysql.cj.xdevapi.Result;

public class ApiServer {

    public static void main(String[] args) {
        int port = 4444;
        Javalin server = Javalin.create(
            config -> {
                config.enforceSsl = true; 
                config.enableCorsForAllOrigins();
            }
            
            ).start(port);

        server.post("/tickets", ApiServer::addTicket);
        server.post("/tickets/reset/{id}", ApiServer::resetCounter);
        server.post("/tickets/drop/{id}", ApiServer::drop);
        server.post("/ticket/update/{id}/{status}", ApiServer::update);
        server.get("/tickets", ApiServer::getTickets);
        server.get("/tickets/{user}", ApiServer::getUserTickets);
        server.post("/ticket", ApiServer::getTicket);
        server.post("/ticket/update/assigned/{staff}", ApiServer::assignStaffToTicket);
    }

    private static void resetCounter(Context context) throws SQLException {
        new Ticket().reset(Integer.parseInt(context.pathParam("id")),context);
    }

    private static void addTicket(Context context) throws Exception {
        Ticket ticket = new Ticket();
        ticket = ticket.setAll(context.body(),context);
        context.json(ticket.toString());
    }
    
    private static void assignStaffToTicket(Context context) throws Exception {
        Ticket ticket = new Ticket();
        ticket = ticket.setStaff(context);
        context.json(ticket.toString());
    }

    private static void getTickets(Context context) throws Exception {
        List<HashMap<String,String>> tickets;
        Ticket ticket = new Ticket();
        tickets = ticket.getAllTickets(context);
        System.out.println("Sending JSON:  "+tickets);
        context.json(tickets);
    }


    private static void getTicket(Context context){
        Ticket ticket = new Ticket();
        
        String ticketRef = ticket.getTicketRefId(context);
        System.out.println(ticketRef);

        context.json(ticketRef);
    }

    private static void getUserTickets(Context context) throws SQLException{
        Ticket ticket = new Ticket();

        context.json(ticket.getUserTickets(context));


    }

    private static void drop(Context context) throws SQLException{
        Ticket ticket = new Ticket();
        try {
            ticket.dropTable(context);
        }catch (Exception e){
            if(e.toString().contains("Unknown table")){
                ticket.dropTable(context);
            };
        }

        context.json("Tables Dropped and created");
    }

    private static void update(Context context) throws SQLException  {
        Ticket ticket = new Ticket();
        ticket.updateTicket(context);

    }







}
