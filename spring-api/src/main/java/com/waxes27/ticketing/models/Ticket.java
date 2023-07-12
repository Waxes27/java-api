package com.waxes27.ticketing.models;

import com.waxes27.ticketing.enums.Category;
import com.waxes27.ticketing.enums.Status;
import lombok.*;

import javax.persistence.*;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

@Entity
@NoArgsConstructor
//@AllArgsConstructor
@Setter
@Getter
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;
    private String referenceId;
    private String username;
    private String issue;
    private String floor;
    private String date;
    private String campus;
    private Status completed;

    private Category category;
//    private String ticketOwner;
//    private String assignee;


    public Ticket(String referenceId, String username, String issue, String floor, String date, String campus, Status status, Category category) {
        this.referenceId = String.valueOf(id);
        this.username = username;
        this.issue = issue;
        this.floor = floor;
        this.date = date;
        this.campus = campus;
        this.completed = status;
        this.category = category;
    }

    @Override
    public String toString() {
        final StringBuffer sb = new StringBuffer("{");
        sb.append("'id':'").append(id).append('\'');
        sb.append(", 'referenceId':'").append(referenceId).append('\'');
        sb.append(", 'username':'").append(username).append('\'');
        sb.append(", 'issue':'").append(issue).append('\'');
        sb.append(", 'floor':'").append(floor).append('\'');
        sb.append(", 'date':'").append(date).append('\'');
        sb.append(", 'campus':'").append(campus).append('\'');
        sb.append(", 'completed':'").append(completed).append('\'');
        sb.append(", 'category':'").append(category).append('\'');
        sb.append('}');
        return sb.toString();
    }

    public Map<String, Object> toMap() throws IllegalAccessException {
        Map<String, Object> map = new HashMap();
        for (Field i: this.getClass().getDeclaredFields()){
            System.out.println(i);
            i.setAccessible(true);
            map.put(i.getName(),i.get(this));
        }
        return map;
    }
}
