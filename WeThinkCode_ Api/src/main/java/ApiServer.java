import ApiHandler.Ticket;
//import com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException;

import java.sql.SQLException;
import io.javalin.Javalin;
import io.javalin.core.JavalinConfig;
import io.javalin.http.Context;

import java.util.HashMap;
import java.util.List;

public class ApiServer {

    public static void main(String[] args) {
        int port = 4444;
        Javalin server = Javalin.create(JavalinConfig::enableCorsForAllOrigins).start(port);

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
        System.out.println("Sending JSON:  "+tickets);
        context.json(tickets);
    }

    private static void drop(Context context) throws Exception {
        Ticket ticket = new Ticket();
        try {
            ticket.dropTable();
        }catch (Exception e){
            if(e.toString().contains("Unknown table")){
                ticket.dropTable();
            };
        }

        context.json("Tables Dropped and created");
    }







}
