package com.fk.core.dao;

import com.fk.core.model.DepartModel;
import com.fk.core.utils.Pager;

import java.util.List;

public interface IDepartDao {

    boolean addDepart(DepartModel record);

    boolean delDepart(DepartModel record);

    boolean modDepart(DepartModel record);

    DepartModel getDepartByID(String id);

    DepartModel getDepartByName(String name);

    DepartModel getDepartByCode(String code);

    List getDepartList();

    List getDepartList(Pager pager);
}
