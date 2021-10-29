import io.javalin.Javalin;

public class QuoteServer {
    private final Javalin server;

    QuoteServer (){
        server = Javalin.create(config -> {
            config.defaultContentType = "application/json";
        });

        this.server.get("/quotes", context -> QuoteApiHandler.getAll(context));
        this.server.get("/quotes/{id}", context -> QuoteApiHandler.getOne(context));
        this.server.post("/quotes/", context -> QuoteApiHandler.create(context));
        this.server.post("/quotes/kill", context -> QuoteApiHandler.kill(context));


    }

    public static void main(String[] args) {
        QuoteServer server = new QuoteServer();
        server.start();


    }

    public void start(){
        this.server.start(4444);
    }

    public void stop(){
        this.server.stop();
    }

}
