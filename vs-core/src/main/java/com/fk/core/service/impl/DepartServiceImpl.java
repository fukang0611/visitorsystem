package com.fk.core.service.impl;

import com.fk.core.dao.IDepartDao;
import com.fk.core.model.DepartModel;
import com.fk.core.service.IDepartService;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartServiceImpl implements IDepartService {

    @Autowired
    IDepartDao iDepartDao;

    @Override
    public boolean addDepart(DepartModel record) {
        return iDepartDao.addDepart(record);
    }

    @Override
    public boolean delDepart(DepartModel record) {
        return iDepartDao.delDepart(record);
    }

    @Override
    public boolean delDepart(String id) {
        return iDepartDao.delDepart(getDepartByID(id));
    }

    @Override
    public boolean modDepart(DepartModel record) {
        return iDepartDao.modDepart(record);
    }

    @Override
    public DepartModel getDepartByID(String id) {
        return iDepartDao.getDepartByID(id);
    }

    @Override
    public DepartModel getDepartByName(String name) {
        return iDepartDao.getDepartByName(name);
    }

    @Override
    public DepartModel getDepartByCode(String code) {
        return iDepartDao.getDepartByCode(code);
    }

    @Override
    public List getDepartList() {
        return iDepartDao.getDepartList();
    }

    @Override
    public List getDepartList(Pager pager) {
        return iDepartDao.getDepartList(pager);
    }

}
