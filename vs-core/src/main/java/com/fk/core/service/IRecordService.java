package com.fk.core.service;

import com.fk.core.model.RecordModel;
import com.fk.core.utils.Pager;

import java.util.Date;
import java.util.List;

public interface IRecordService {

    boolean addRecord(RecordModel record);

    boolean delRecord(String id);

    boolean delRecord(RecordModel record);

    boolean modRecord(String id);

    boolean modRecord(RecordModel record);

    RecordModel getRecord(String id);

    List getRecords(Pager pager);

    List getRecords(Pager pager, Date date);

}
