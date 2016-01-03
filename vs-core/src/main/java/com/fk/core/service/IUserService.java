package com.fk.core.service;

import com.fk.core.model.UserModel;

public interface IUserService {

    boolean addUser(UserModel record);

    boolean delUser(UserModel record);

    boolean delUser(String id);

    boolean modUser(UserModel record);

    UserModel getUserByID(String id);

    UserModel getUserByUsername(String username);
}
