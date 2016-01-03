package com.fk.core.model;

import javax.persistence.*;
import java.util.Date;

/**
 * 访客实体类
 */
@Entity
@Table(name = "T_VISITOR")
public class VisitorModel {

    @Id
    @Column(name = "ID")
    private String id; // 身份证号

    @Column(name = "NAME")
    private String name; // 姓名

    @Column(name = "SEX")
    private String sex; // 性别

    @Column(name = "LOCATION")
    private String location; // 籍贯

    @Column(name = "TEL")
    private String tel; // 手机号

    @Column(name = "CREATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime; // 创建时间

    public VisitorModel() {
    }

    public VisitorModel(String id, String name, String sex, String location, String tel, Date createTime) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.location = location;
        this.tel = tel;
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "VisitorModel{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", sex='" + sex + '\'' +
                ", location='" + location + '\'' +
                ", tel='" + tel + '\'' +
                ", createTime=" + createTime +
                '}';
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

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
