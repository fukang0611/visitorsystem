package com.fk.core.service;

import com.fk.core.model.StaffModel;
import com.fk.core.utils.Pager;

import java.util.List;

public interface IStaffService {

    boolean addStaff(StaffModel record);

    boolean delStaff(StaffModel record);

    boolean delStaff(String id);

    boolean modStaff(StaffModel record);

    StaffModel getStaffByID(String id);

    StaffModel getStaffByName(String name);

    List getStaffList(Pager pager);
}
