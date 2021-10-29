import java.util.List;

public interface QuoteDB {

    Quote get(Integer id);
    /**
     *
     * @return a single quote with an id
     */


    List<Quote> getAll();
    /**
     *
     * @return a list of quotes
     */

    Quote add(Quote quote);
    /**
     * Adds a quote to the database
     */
}
