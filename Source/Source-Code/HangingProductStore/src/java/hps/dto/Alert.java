package hps.dto;

/**
 *
 * @author Phuc Tran
 */
public class Alert {
    private AlertType type;
    private String title;
    private String body;

    public Alert(AlertType type, String title, String body) {
        this.type = type;
        this.title = title;
        this.body = body;
    }

    public AlertType getType() {
        return type;
    }

    public void setType(AlertType type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
    
    public enum AlertType {
        SUCCESS("success"),
        INFO("info"),
        WARNING("warning"),
        ERROR("error");
        
        private final String name;

        private AlertType(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }
    }
}
