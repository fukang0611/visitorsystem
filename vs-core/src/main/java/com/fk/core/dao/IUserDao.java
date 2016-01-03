package com.fk.core.dao;

import com.fk.core.model.UserModel;

public interface IUserDao {

    boolean addUser(UserModel record);

    boolean delUser(UserModel record);

    boolean modUser(UserModel record);

    UserModel getUserByID(String id);

    UserModel getUserByUsername(String username);
}
