package com.fk.core.controller;


import com.fk.core.dao.IStaffDao;
import com.fk.core.model.RecordModel;
import com.fk.core.model.StaffModel;
import com.fk.core.model.VisitorModel;
import com.fk.core.service.IRecordService;
import com.fk.core.service.IStaffService;
import com.fk.core.service.IVisitorService;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/record")
public class RecordController {

    @Autowired
    private IRecordService iRecordService;
    @Autowired
    private IVisitorService iVisitorService;
    @Autowired
    private IStaffService iStaffService;

    @RequestMapping("/list")
    @ResponseBody
    private Object list(Pager pager) {

        List records = iRecordService.getRecords(pager);
        Map<String, Object> data = new HashMap<>();
        data.put("total", pager.getTotalRows()); // 数据总数
        data.put("rows", records); // 列表数据
        return data;
    }

    @RequestMapping("/add")
    @ResponseBody
    private Object add(VisitorModel visitor, String staffID) {

        if (iVisitorService.getVisitorByID(visitor.getId()) == null) {
            visitor.setCreateTime(new Date());
            iVisitorService.addVisitor(visitor);
        } else {
            visitor = iVisitorService.getVisitorByID(visitor.getId());
        }

        StaffModel staff = iStaffService.getStaffByID(staffID);
        RecordModel record = new RecordModel();
        record.setVisitDate(new Date());
        record.setVisitor(visitor);
        record.setStaff(staff.getName());
        record.setBusiness(staff.getDepart().getBusiness());
        boolean result = iRecordService.addRecord(record);

        return result ? "success" : "fail";
    }

}
