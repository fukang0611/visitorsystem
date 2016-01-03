package com.fk.core.dao.impl;

import com.fk.core.dao.IUserDao;
import com.fk.core.model.UserModel;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;

@Repository
public class UserDaoImpl implements IUserDao {

    @Resource(name = "sessionFactory")
    SessionFactory factory;

    @Override
    public boolean addUser(UserModel record) {
        Session session = factory.getCurrentSession();
        return session.save(record) != null;
    }

    @Override
    public boolean delUser(UserModel record) {
        Session session = factory.getCurrentSession();
        session.delete(record);
        return true;
    }

    @Override
    public boolean modUser(UserModel record) {
        Session session = factory.getCurrentSession();
        session.update(record);
        return true;
    }

    @Override
    public UserModel getUserByID(String id) {
        Session session = factory.getCurrentSession();
        return session.get(UserModel.class, id);
    }

    @Override
    public UserModel getUserByUsername(String username) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery("from UserModel s where s.username=:username");
        query.setParameter("username", username);
        return (UserModel) query.uniqueResult();
    }
}
