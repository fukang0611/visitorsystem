package com.fk.core.dao.impl;

import com.fk.core.dao.IDepartDao;
import com.fk.core.model.DepartModel;
import com.fk.core.utils.Pager;
import com.fk.core.utils.StringHandler;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class DepartDaoImpl implements IDepartDao {

    @Resource(name = "sessionFactory")
    SessionFactory factory;

    StringHandler stringHandler = new StringHandler(); // 字符串处理工具

    @Override
    public boolean addDepart(DepartModel record) {
        Session session = factory.getCurrentSession();
        return session.save(record) != null;
    }

    @Override
    public boolean delDepart(DepartModel record) {
        Session session = factory.getCurrentSession();
        session.delete(record);
        return true;
    }

    @Override
    public boolean modDepart(DepartModel record) {
        Session session = factory.getCurrentSession();
        session.update(record);
        return true;
    }

    @Override
    public DepartModel getDepartByID(String id) {
        Session session = factory.getCurrentSession();
        return session.get(DepartModel.class, id);
    }

    @Override
    public DepartModel getDepartByName(String name) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery("from DepartModel d where d.name=:name");
        query.setParameter("name", name);
        return (DepartModel) query.uniqueResult();
    }

    @Override
    public DepartModel getDepartByCode(String code) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery("from DepartModel d where d.code=:code");
        query.setParameter("code", code);
        return (DepartModel) query.uniqueResult();
    }

    @Override
    public List getDepartList() {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery("from DepartModel d");
        return query.list();
    }

    @Override
    public List getDepartList(Pager pager) {

        String name = stringHandler.isStrNullOrEmpty(pager.getSearch()) ? "" : pager.getSearch(); // 部门名称
        String sort = stringHandler.isStrNullOrEmpty(pager.getSort()) ? "sortOrder" : pager.getSort(); // 排序字段

        Session session = factory.getCurrentSession();
        String hql = "from DepartModel d where d.name like :name";
        hql += " order by " + sort + " " + pager.getOrder();

        // 得到用户列表
        Query query = session.createQuery(hql);
        query.setParameter("name", "%" + name + "%");
        query.setFirstResult(pager.getOffset());
        query.setMaxResults(pager.getLimit());

        // 得到用户总数
        Query queryRows = session.createQuery("select count(*) " + hql);
        queryRows.setParameter("name", "%" + name + "%");
        pager.setTotalRows((Long) queryRows.uniqueResult());

        return query.list();
    }
}
