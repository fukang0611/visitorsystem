package com.fk.core.model;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@Entity
@Table(name = "T_RECORD")
public class RecordModel {

    @Id
    @GeneratedValue(generator = "generator")
    @GenericGenerator(name = "generator", strategy = "uuid")
    @Column(name = "ID")
    private String id; // id

    @Column(name = "VISIT_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date visitDate; // 来访日期

    @ManyToOne(cascade = CascadeType.ALL, targetEntity = VisitorModel.class, fetch = FetchType.EAGER)
    private VisitorModel visitor; // 来访人员,多对一,多个来访记录对应一个来访人员

    @Column(name = "BUSINESS")
    private String business; // 办事业务

    @Column(name = "STAFF")
    private String staff; // 办事人员

    @Column(name = "SATISFACTION")
    private String satisfaction; // 满意度

    public RecordModel() {
    }

    public RecordModel(Date visitDate, VisitorModel visitor, String business, String staff, String satisfaction) {
        this.visitDate = visitDate;
        this.visitor = visitor;
        this.business = business;
        this.staff = staff;
        this.satisfaction = satisfaction;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVisitDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return sdf.format(this.visitDate);
    }

    public void setVisitDate(Date visitDate) {
        this.visitDate = visitDate;
    }

    public VisitorModel getVisitor() {
        return visitor;
    }

    public void setVisitor(VisitorModel visitor) {
        this.visitor = visitor;
    }

    public String getBusiness() {
        return business;
    }

    public void setBusiness(String business) {
        this.business = business;
    }

    public String getStaff() {
        return staff;
    }

    public void setStaff(String staff) {
        this.staff = staff;
    }

    public String getSatisfaction() {
        return satisfaction;
    }

    public void setSatisfaction(String satisfaction) {
        this.satisfaction = satisfaction;
    }
}
