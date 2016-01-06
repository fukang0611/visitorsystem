package com.fk.core.service.impl;

import com.fk.core.dao.IVisitorDao;
import com.fk.core.model.VisitorModel;
import com.fk.core.service.IVisitorService;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VisitorServiceImpl implements IVisitorService {

    @Autowired
    IVisitorDao iVisitorDao;

    @Override
    public boolean addVisitor(VisitorModel record) {
        return iVisitorDao.addVisitor(record);
    }

    @Override
    public boolean delVisitor(VisitorModel record) {
        return iVisitorDao.delVisitor(record);
    }

    @Override
    public boolean delVisitor(String id) {
        return iVisitorDao.delVisitor(getVisitorByID(id));
    }

    @Override
    public boolean modVisitor(VisitorModel record) {
        return iVisitorDao.modVisitor(record);
    }

    @Override
    public VisitorModel getVisitorByID(String id) {
        return iVisitorDao.getVisitorByID(id);
    }

    @Override
    public VisitorModel getVisitorByName(String name) {
        return iVisitorDao.getVisitorByName(name);
    }

    @Override
    public List getVisitors(Pager pager) {
        return iVisitorDao.getVisitors(pager);
    }
}
