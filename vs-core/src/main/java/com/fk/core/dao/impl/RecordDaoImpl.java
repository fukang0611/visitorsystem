package com.fk.core.dao.impl;

import com.fk.core.dao.IRecordDao;
import com.fk.core.model.RecordModel;
import com.fk.core.utils.Pager;
import com.fk.core.utils.StringHandler;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Repository
public class RecordDaoImpl implements IRecordDao {

    @Resource(name = "sessionFactory")
    SessionFactory factory;

    StringHandler stringHandler = new StringHandler();

    @Override
    public boolean addRecord(RecordModel record) {
        Session session = factory.getCurrentSession();
        return session.save(record) != null;
    }

    @Override
    public boolean delRecord(RecordModel record) {
        Session session = factory.getCurrentSession();
        session.delete(record);
        return true;
    }

    @Override
    public boolean modRecord(RecordModel record) {
        Session session = factory.getCurrentSession();
        session.update(record);
        return true;
    }

    @Override
    public RecordModel getRecord(String id) {
        Session session = factory.getCurrentSession();
        return session.get(RecordModel.class, id);
    }

    @Override
    public List getRecords(Pager pager) {

        String name = stringHandler.isStrNullOrEmpty(pager.getSearch()) ? "" : pager.getSearch(); // 访客姓名
        String sort = stringHandler.isStrNullOrEmpty(pager.getSort()) ? "visitDate" : pager.getSort(); // 排序字段

        Session session = factory.getCurrentSession();
        String hql = "from RecordModel r where r.visitor.name like :name";
        hql += " order by " + sort + " " + pager.getOrder();

        // 得到访客记录列表
        Query query = session.createQuery(hql);
        query.setParameter("name", "%" + name + "%");
        query.setFirstResult(pager.getOffset());
        query.setMaxResults(pager.getLimit());

        // 得到访客记录总数
        Query queryRows = session.createQuery("select count(*) " + hql);
        queryRows.setParameter("name", "%" + name + "%");
        pager.setTotalRows((Long) queryRows.uniqueResult());

        return query.list();
    }

    @Override
    public List getRecords(Pager pager, Date date) {

        String name = stringHandler.isStrNullOrEmpty(pager.getSearch()) ? "" : pager.getSearch(); // 访客姓名
        String sort = stringHandler.isStrNullOrEmpty(pager.getSort()) ? "visitDate" : pager.getSort(); // 排序字段

        Session session = factory.getCurrentSession();
        String hql = "from RecordModel r where r.visitor.name like :name and Date(r.visitDate) = :date ";
        hql += " order by " + sort + " " + pager.getOrder();

        // 得到访客记录列表
        Query query = session.createQuery(hql);
        query.setParameter("name", "%" + name + "%");
        query.setDate("date", date);
        query.setFirstResult(pager.getOffset());
        query.setMaxResults(pager.getLimit());

        // 得到访客记录总数
        Query queryRows = session.createQuery("select count(*) " + hql);
        queryRows.setParameter("name", "%" + name + "%");
        queryRows.setDate("date", date);
        pager.setTotalRows((Long) queryRows.uniqueResult());

        return query.list();
    }
}
