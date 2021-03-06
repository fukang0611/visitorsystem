package com.fk.core.service;

import com.fk.core.model.VisitorModel;
import com.fk.core.utils.Pager;

import java.util.List;

public interface IVisitorService {

    boolean addVisitor(VisitorModel record);

    boolean delVisitor(VisitorModel record);

    boolean delVisitor(String id);

    boolean modVisitor(VisitorModel record);

    VisitorModel getVisitorByID(String id);

    VisitorModel getVisitorByName(String name);

    List getVisitors(Pager pager);
}
