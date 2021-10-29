import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Database implements QuoteDB{
    private Map<Integer, Quote> quotes;
    public Database(){
        quotes = new HashMap<>();
        this.add(new Quote().create("Hello World!","Python"));
        this.add(new Quote().create("Hello World!","Java"));
        this.add(new Quote().create("Hello World!","C"));
        this.add(new Quote().create("Hello World!","unknown"));
    }
    @Override
    public Quote get(Integer id) {
        /**
         * This gets one value from the DATABASE
         */
        return quotes.get(id);
    }

    @Override
    public List<Quote> getAll() {
        /**
         * This returns all values from the DATABASE
         */
        return new ArrayList<>(quotes.values());
    }

    @Override
    public Quote add(Quote quote) {
        quote.setId(quotes.size()+1);
        Integer id = quote.getId();
        quotes.put(id, quote);
        return quote;
    }

}
