package com.fk.core.service.impl;

import com.fk.core.dao.IStaffDao;
import com.fk.core.model.StaffModel;
import com.fk.core.service.IStaffService;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StaffServiceImpl implements IStaffService {

    @Autowired
    IStaffDao iStaffDao;

    @Override
    public boolean addStaff(StaffModel record) {
        return iStaffDao.addStaff(record);
    }

    @Override
    public boolean delStaff(StaffModel record) {
        return iStaffDao.delStaff(record);
    }

    @Override
    public boolean delStaff(String id) {
        return iStaffDao.delStaff(getStaffByID(id));
    }

    @Override
    public boolean modStaff(StaffModel record) {
        return iStaffDao.modStaff(record);
    }

    @Override
    public StaffModel getStaffByID(String id) {
        return iStaffDao.getStaffByID(id);
    }

    @Override
    public StaffModel getStaffByName(String name) {
        return iStaffDao.getStaffByName(name);
    }

    @Override
    public List getStaffList(Pager pager) {
        return iStaffDao.getStaffList(pager);
    }
}
