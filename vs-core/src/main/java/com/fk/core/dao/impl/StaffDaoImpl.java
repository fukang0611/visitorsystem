package com.fk.core.dao.impl;

import com.fk.core.dao.IStaffDao;
import com.fk.core.model.StaffModel;
import com.fk.core.utils.Pager;
import com.fk.core.utils.StringHandler;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class StaffDaoImpl implements IStaffDao {

    @Resource(name = "sessionFactory")
    SessionFactory factory;

    StringHandler stringHandler = new StringHandler();

    @Override
    public boolean addStaff(StaffModel record) {
        Session session = factory.getCurrentSession();
        return session.save(record) != null;
    }

    @Override
    public boolean delStaff(StaffModel record) {
        Session session = factory.getCurrentSession();
        session.delete(record);
        return true;
    }

    @Override
    public boolean modStaff(StaffModel record) {
        Session session = factory.getCurrentSession();
        session.update(record);
        return true;
    }

    @Override
    public StaffModel getStaffByID(String id) {
        Session session = factory.getCurrentSession();
        return session.get(StaffModel.class, id);
    }

    @Override
    public StaffModel getStaffByName(String name) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery("from StaffModel s where s.name=:name");
        query.setParameter("name", name);
        return (StaffModel) query.uniqueResult();
    }

    @Override
    public List getStaffList(Pager pager) {

        String name = stringHandler.isStrNullOrEmpty(pager.getSearch()) ? "" : pager.getSearch(); // 员工姓名
        String sort = stringHandler.isStrNullOrEmpty(pager.getSort()) ? "sortOrder" : pager.getSort(); // 排序字段

        Session session = factory.getCurrentSession();
        String hql = "from StaffModel s where s.name like :name";
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
