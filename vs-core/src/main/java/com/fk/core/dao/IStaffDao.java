package com.fk.core.dao;

import com.fk.core.model.StaffModel;
import com.fk.core.utils.Pager;

import java.util.List;

/**
 * 职工DAO接口
 */
public interface IStaffDao {

    boolean addStaff(StaffModel record);

    boolean delStaff(StaffModel record);

    boolean modStaff(StaffModel record);

    StaffModel getStaffByID(String id);

    StaffModel getStaffByName(String name);

    List getStaffList(Pager pager);
}
