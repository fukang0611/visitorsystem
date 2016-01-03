package com.fk.core.service.impl;

import com.fk.core.dao.IUserDao;
import com.fk.core.model.UserModel;
import com.fk.core.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    IUserDao iUserDao;

    @Override
    public boolean addUser(UserModel record) {
        return iUserDao.addUser(record);
    }

    @Override
    public boolean delUser(UserModel record) {
        return iUserDao.delUser(record);
    }

    @Override
    public boolean delUser(String id) {
        return iUserDao.delUser(getUserByID(id));
    }

    @Override
    public boolean modUser(UserModel record) {
        return iUserDao.modUser(record);
    }

    @Override
    public UserModel getUserByID(String id) {
        return iUserDao.getUserByID(id);
    }

    @Override
    public UserModel getUserByUsername(String username) {
        return iUserDao.getUserByUsername(username);
    }
}
