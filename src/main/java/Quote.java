public class Quote {
    private Integer id;
    private String text;
    private String author;

    public void setId(Integer id){
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }

    public Quote create(String body,String newAuthor){
        Quote quote = new Quote();

        quote.setText(body);
        quote.setAuthor(newAuthor);

        return quote;
    }

    public void delete(Integer id){
        /**
         * Waiting to get result set
         */
    }
}
