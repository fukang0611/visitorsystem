package com.fk.core.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;
import java.util.TreeSet;

@Entity
@Table(name = "T_DEPARTMENT")
public class DepartModel {

    @Id
    @GeneratedValue(generator = "generator")
    @GenericGenerator(name = "generator", strategy = "uuid")
    @Column(name = "ID")
    private String id; // id

    @Column(name = "NAME")
    private String name; // 部门名称

    @Column(name = "CODE")
    private String code; // 部门代码

    @Column(name = "BUSINESS")
    private String business; // 部门业务

    @Column(name = "SORT_ORDER")
    private int sortOrder; // 部门排序

    @Column(name = "CREATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime; // 创建时间

    @OneToMany(mappedBy = "depart", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    Set<StaffModel> staffs = new TreeSet<>(); // 一对多映射 员工

    public DepartModel() {
    }

    public DepartModel(String name, String code, String business, int sortOrder, Date createTime, Set<StaffModel> staffs) {
        this.name = name;
        this.code = code;
        this.business = business;
        this.sortOrder = sortOrder;
        this.createTime = createTime;
        this.staffs = staffs;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBusiness() {
        return business;
    }

    public void setBusiness(String business) {
        this.business = business;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public String getCreateTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(createTime);
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Set<StaffModel> getStaffs() {
        return staffs;
    }

    public void setStaffs(Set<StaffModel> staffs) {
        this.staffs = staffs;
    }
}
