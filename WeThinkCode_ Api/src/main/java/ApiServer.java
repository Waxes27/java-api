import ApiHandler.DBconnect;
import ApiHandler.Ticket;
import java.sql.SQLException;
import io.javalin.Javalin;
import io.javalin.http.Context;

import java.util.HashMap;
import java.util.List;


import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.util.ssl.SslContextFactory;



public class ApiServer {

    private static SslContextFactory getSslContextFactory() {
        SslContextFactory sslContextFactory = new SslContextFactory.Server();
        sslContextFactory.setKeyStorePath(ApiServer.class.getResource("/client.ks").toExternalForm());
        sslContextFactory.setKeyStorePassword("password");
        return sslContextFactory;
    }

    public static void main(String[] args) throws Exception {
        // SslContextFactory ssl = new SslContextFactory();
        SslContextFactory.Server ssl = new SslContextFactory.Server();
        ssl.start(); 
        
        int port = 4444;
    //     Javalin server = Javalin.create(
    //         config -> {
    //             config.enforceSsl = false; 
    //             config.enableCorsForAllOrigins();
    // }
    
    // ).start(port);

    Javalin javalinSserver = Javalin.create(config -> {
        config.server(() -> {
            config.enableCorsForAllOrigins();
            Server server = new Server();
            ServerConnector sslConnector = new ServerConnector(server, getSslContextFactory());
            sslConnector.setPort(4444);
            // ServerConnector connector = new ServerConnector(server);
            // connector.setPort(80);
            server.setConnectors(new Connector[]{sslConnector});
            return server;
        });
    }).start();

    
    
    javalinSserver.post("/tickets", ApiServer::addTicket);
    javalinSserver.post("/tickets/reset/{id}", ApiServer::resetCounter);
    javalinSserver.post("/tickets/drop/{id}", ApiServer::drop);
    javalinSserver.post("/ticket/update/{id}/{status}", ApiServer::update);
    javalinSserver.get("/tickets", ApiServer::getTickets);
    javalinSserver.get("/tickets/{user}", ApiServer::getUserTickets);
    javalinSserver.post("/ticket", ApiServer::getTicket);
    javalinSserver.post("/ticket/update/assigned/{staff}", ApiServer::assignStaffToTicket);
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