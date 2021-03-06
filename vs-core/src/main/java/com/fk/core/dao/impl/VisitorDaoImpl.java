package com.fk.core.dao.impl;

import com.fk.core.dao.IVisitorDao;
import com.fk.core.model.VisitorModel;
import com.fk.core.utils.Pager;
import com.fk.core.utils.StringHandler;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class VisitorDaoImpl implements IVisitorDao {

    @Resource(name = "sessionFactory")
    SessionFactory factory;

    StringHandler stringHandler = new StringHandler();

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

    @Override
    public List getVisitors(Pager pager) {

        String name = stringHandler.isStrNullOrEmpty(pager.getSearch()) ? "" : pager.getSearch(); // 访客姓名
        String sort = stringHandler.isStrNullOrEmpty(pager.getSort()) ? "createTime" : pager.getSort(); // 排序字段

        Session session = factory.getCurrentSession();
        String hql = "from VisitorModel v where v.name like:name";
        hql += " order by " + sort + " " + pager.getOrder();

        // 得到访客列表
        Query query = session.createQuery(hql);
        query.setParameter("name", "%" + name + "%");
        query.setFirstResult(pager.getOffset());
        query.setMaxResults(pager.getLimit());

        // 得到访客总数
        Query queryRows = session.createQuery("select count(*) " + hql);
        queryRows.setParameter("name", "%" + name + "%");
        pager.setTotalRows((Long) queryRows.uniqueResult());

        return query.list();
    }
}
