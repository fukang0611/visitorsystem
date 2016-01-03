package com.fk.core.dao;

import com.fk.core.model.VisitorModel;

public interface IVisitorDao {

    boolean addVisitor(VisitorModel record);

    boolean delVisitor(VisitorModel record);

    boolean modVisitor(VisitorModel record);

    VisitorModel getVisitorByID(String id);

    VisitorModel getVisitorByName(String name);
}
