import com.fasterxml.jackson.databind.JsonNode;
import io.javalin.http.Context;
import io.javalin.http.HttpCode;
import io.javalin.http.NotFoundResponse;

public class QuoteApiHandler {

    private final static QuoteDB testDatabase = new Database();


    public static void getAll(Context context){
        context.json(testDatabase.getAll());
    }

    public static void getOne(Context context){
        Integer id = context.pathParamAsClass("id",Integer.class).get();

        context.json(testDatabase.get(id));
    }

    public static void create(Context context){
        Quote quote = context.bodyAsClass(Quote.class);
        Quote newQuote = testDatabase.add(quote);
        context.header("Location", "/quote/" + newQuote.getId());
        context.status(HttpCode.CREATED);
        context.json(newQuote);
    }

    public static void kill(Context context){
        QuoteServer server = new QuoteServer();

        JsonNode data = context.bodyAsClass(JsonNode.class);
        String password = data.get("password").asText();
        String author = data.get("author").asText();

        System.out.println(password);
        if (password.equals("off") && author.equals("Waxes27")){
            System.out.println("Killing...");
            server.stop();
        }

    }
}
