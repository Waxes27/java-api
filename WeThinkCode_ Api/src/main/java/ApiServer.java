import ApiHandler.DBconnect;
import ApiHandler.Ticket;
import ApiHandler.TicketInterface;
import com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException;
import io.javalin.Javalin;
import io.javalin.http.Context;
import org.json.JSONObject;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ApiServer {

    public static void main(String[] args) {
        int port = 4444;
        Javalin server = Javalin.create().start(port);

        server.post("/tickets", ApiServer::addTicket);
        server.post("/tickets/reset/{id}", ApiServer::resetCounter);
        server.post("/tickets/drop", ApiServer::drop);
        server.get("/tickets", ApiServer::getTickets);
    }

    private static void resetCounter(Context context) throws SQLException {
        Ticket ticket = new Ticket();
        ticket.reset(Integer.parseInt(context.pathParam("id")),context);
    }

    private static void addTicket(Context context) throws Exception {
        Ticket ticket = new Ticket();
        ticket = ticket.setAll(context.body(),context);
        context.json(ticket.toString());
    }

    private static void getTickets(Context context) throws Exception {
        List<HashMap<String,String>> tickets;
        Ticket ticket = new Ticket();
        tickets = ticket.getAllTickets(context);
        
        context.json(tickets);
    }

    private static void drop(Context context) throws Exception {
        Ticket ticket = new Ticket();
        try {
            ticket.dropTable();
        }catch (MySQLSyntaxErrorException e){
            if(e.toString().contains("Unknown table")){
                ticket.dropTable();
            };
        }

        context.json("Tables Dropped and created");
    }







}
