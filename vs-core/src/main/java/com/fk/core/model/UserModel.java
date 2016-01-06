package com.fk.core.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 系统用户实体类
 */
@Entity
@Table(name = "T_USER")
public class UserModel {

    @Id
    @GeneratedValue(generator = "generator")
    @GenericGenerator(name = "generator", strategy = "uuid")
    @Column(name = "ID")
    private String id; // id

    @Column(name = "DISPLAY_NAME")
    private String displayName; // 姓名

    @Column(name = "USERNAME")
    private String username; // 用户名

    @Column(name = "PASSWORD")
    private String password; // 密码

    @Column(name = "CREATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime; // 创建时间

    public UserModel() {
    }

    public UserModel(String displayName, String username, String password, Date createTime) {
        this.displayName = displayName;
        this.username = username;
        this.password = password;
        this.createTime = createTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCreateTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(createTime);
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
