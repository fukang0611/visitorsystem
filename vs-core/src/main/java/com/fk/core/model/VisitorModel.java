package com.fk.core.model;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;
import java.util.TreeSet;

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

    @Column(name = "BORN")
    private String born; // 出生日期

    @Column(name = "NATION")
    private String nation; // 民族

    @Column(name = "ORGANIZATION")
    private String organization; // 发证机关

    @Column(name = "VALIDATE_BEGIN")
    private String validateBegin; // 起始有效期

    @Column(name = "VALIDATE_END")
    private String validateEnd; // 截止有效期

    @Column(name = "LOCATION")
    private String location; // 住址

    @Column(name = "PHOTO")
    private String photo; // 头像路径

    @Column(name = "TEL")
    private String tel; // 手机号

    @Column(name = "CREATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime; // 创建时间

    @OneToMany(mappedBy = "visitor", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    Set<RecordModel> records = new TreeSet<>(); // 一对多,一个访客对应多次来访记录

    public VisitorModel() {
    }

    public VisitorModel(String id, String name, String sex, String born, String nation, String organization, String validateBegin, String validateEnd, String location, String photo, String tel, Date createTime, Set<RecordModel> records) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.born = born;
        this.nation = nation;
        this.organization = organization;
        this.validateBegin = validateBegin;
        this.validateEnd = validateEnd;
        this.location = location;
        this.photo = photo;
        this.tel = tel;
        this.createTime = createTime;
        this.records = records;
    }

    //region getter & setter
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

    public String getBorn() {
        return born;
    }

    public void setBorn(String born) {
        this.born = born;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public String getValidateBegin() {
        return validateBegin;
    }

    public void setValidateBegin(String validateBegin) {
        this.validateBegin = validateBegin;
    }

    public String getValidateEnd() {
        return validateEnd;
    }

    public void setValidateEnd(String validateEnd) {
        this.validateEnd = validateEnd;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Set<RecordModel> getRecords() {
        return records;
    }

    public void setRecords(Set<RecordModel> records) {
        this.records = records;
    }

    public String getCreateTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(createTime);
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    //endregion
}
