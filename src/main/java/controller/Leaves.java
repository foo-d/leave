package controller;

public class Leaves {
    private int id;
    private String start;
    private String end;
    private String fullDay;
    private String reason;
    private int idEmployee;

    public Leaves (int id, String start, String end, String fullDay,
                   String reason, int idEmployee) {
        this.id = id;
        this.start = start;
        this.end = end;
        this.fullDay = fullDay;
        this.reason = reason;
        this.idEmployee = idEmployee;
    }

    public Leaves (String start, String end, String fullDay, String reason,
                   int idEmployee) {
        this.id = 0;
        this.start = start;
        this.end = end;
        this.fullDay = fullDay;
        this.reason = reason;
        this.idEmployee = idEmployee;
    }

    public Leaves () {
        this.id = 0;
        this.start = "";
        this.end = "";
        this.fullDay = "";
        this.reason = "";
        this.idEmployee = 0;
    }

    public int getId () {
        return id;
    }

    public String getStart () {
        return start;
    }

    public String getEnd () {
        return end;
    }

    public String getFullDay () {
        return fullDay;
    }

    public String getReason () {
        return reason;
    }

    public int getIdEmployee () {
        return idEmployee;
    }

    public void setId (int id) {
        this.id = id;
    }

    public void setStart (String start) {
        this.start = start;
    }

    public void setEnd (String end) {
        this.end = end;
    }

    public void setFullDay (String fullDay) {
        this.fullDay = fullDay;
    }

    public void setReason (String reason) {
        this.reason = reason;
    }

    public void setIdEmployee (int idEmployee) {
        this.idEmployee = idEmployee;
    }
}
