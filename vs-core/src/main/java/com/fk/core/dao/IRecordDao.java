package com.fk.core.dao;

import com.fk.core.model.RecordModel;
import com.fk.core.utils.Pager;

import java.util.Date;
import java.util.List;

public interface IRecordDao {

    boolean addRecord(RecordModel record);

    boolean delRecord(RecordModel record);

    boolean modRecord(RecordModel record);

    RecordModel getRecord(String id);

    List getRecords(Pager pager);

    List getRecords(Pager pager, Date date);
}
