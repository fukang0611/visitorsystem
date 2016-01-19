package com.fk.core.service.impl;

import com.fk.core.dao.IRecordDao;
import com.fk.core.model.RecordModel;
import com.fk.core.service.IRecordService;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class RecordServiceImpl implements IRecordService {

    @Autowired
    private IRecordDao iRecordDao;

    @Override
    public boolean addRecord(RecordModel record) {
        return iRecordDao.addRecord(record);
    }

    @Override
    public boolean delRecord(String id) {
        return iRecordDao.delRecord(getRecord(id));
    }

    @Override
    public boolean delRecord(RecordModel record) {
        return iRecordDao.delRecord(record);
    }

    @Override
    public boolean modRecord(String id) {
        return iRecordDao.modRecord(getRecord(id));
    }

    @Override
    public boolean modRecord(RecordModel record) {
        return iRecordDao.modRecord(record);
    }

    @Override
    public RecordModel getRecord(String id) {
        return iRecordDao.getRecord(id);
    }

    @Override
    public List getRecords(Pager pager) {
        return iRecordDao.getRecords(pager);
    }

    @Override
    public List getRecords(Pager pager, Date date) {
        return iRecordDao.getRecords(pager, date);
    }
}
