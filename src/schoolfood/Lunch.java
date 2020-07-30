package schoolfood;

public class Lunch {
    private int id;
    private String date;
    private String day;
    private String[] food = new String[6];

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String[] getFood() {
        return food;
    }

    public void setFood(String[] food) {
        this.food = food;
    }
}
