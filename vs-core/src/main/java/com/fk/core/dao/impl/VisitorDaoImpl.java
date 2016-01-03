package com.fk.core.dao.impl;

import com.fk.core.dao.IVisitorDao;
import com.fk.core.model.VisitorModel;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;

@Repository
public class VisitorDaoImpl implements IVisitorDao {

    @Resource(name = "sessionFactory")
    SessionFactory factory;

    @Override
    public boolean addVisitor(VisitorModel record) {
        Session session = factory.getCurrentSession();
        return session.save(record) != null;
    }

    @Override
    public boolean delVisitor(VisitorModel record) {
        Session session = factory.getCurrentSession();
        session.delete(record);
        return true;
    }

    @Override
    public boolean modVisitor(VisitorModel record) {
        Session session = factory.getCurrentSession();
        session.update(record);
        return true;
    }

    @Override
    public VisitorModel getVisitorByID(String id) {
        Session session = factory.getCurrentSession();
        return session.get(VisitorModel.class, id);
    }

    @Override
    public VisitorModel getVisitorByName(String name) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery("from VisitorModel v where v.name=:name");
        query.setParameter("name", name);
        return (VisitorModel) query.uniqueResult();
    }
}
