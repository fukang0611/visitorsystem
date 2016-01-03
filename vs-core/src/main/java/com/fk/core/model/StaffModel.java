package com.fk.core.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * 工作人员实体类
 * 不包括系统管理员及使用人员
 */
@Entity
@Table(name = "T_STAFF")
public class StaffModel {

    @Id
    @GeneratedValue(generator = "generator")
    @GenericGenerator(name = "generator", strategy = "uuid")
    @Column(name = "ID")
    private String id; // id

    @Column(name = "NAME")
    private String name; // 姓名

    @Column(name = "SEX")
    private String sex; // 性别

    @Column(name = "OFFICE_TEL")
    private String officeTel; // 办公室电话

    @Column(name = "MOBILE_TEL")
    private String mobileTel; // 手机号码

    @Column(name = "SORT_ORDER")
    private String sortOrder; // 员工序号

    @Column(name = "CREATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime; // 创建时间

    @ManyToOne(cascade = CascadeType.ALL, targetEntity = DepartModel.class, fetch = FetchType.EAGER)
    private DepartModel depart; // 所属部门

    public StaffModel() {
    }

    public StaffModel(String name, String sex, String officeTel, String mobileTel, String sortOrder, Date createTime, DepartModel depart) {
        this.name = name;
        this.sex = sex;
        this.officeTel = officeTel;
        this.mobileTel = mobileTel;
        this.sortOrder = sortOrder;
        this.createTime = createTime;
        this.depart = depart;
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

    public String getOfficeTel() {
        return officeTel;
    }

    public void setOfficeTel(String officeTel) {
        this.officeTel = officeTel;
    }

    public String getMobileTel() {
        return mobileTel;
    }

    public void setMobileTel(String mobileTel) {
        this.mobileTel = mobileTel;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public DepartModel getDepart() {
        return depart;
    }

    public void setDepart(DepartModel depart) {
        this.depart = depart;
    }
}
