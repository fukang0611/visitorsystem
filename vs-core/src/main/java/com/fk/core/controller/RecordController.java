package com.fk.core.controller;


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

/**
 * 访客记录控制器
 *
 * @author fukang 2016.01.06
 */
@Controller
@RequestMapping("/record")
public class RecordController {

    @Autowired
    private IRecordService iRecordService;
    @Autowired
    private IVisitorService iVisitorService;
    @Autowired
    private IStaffService iStaffService;

    /**
     * 访客记录表格数据
     *
     * @param pager 分页对象
     * @return 表格数据
     */
    @RequestMapping("/list")
    @ResponseBody
    private Object list(Pager pager) {

        List records = iRecordService.getRecords(pager);
        Map<String, Object> data = new HashMap<>();
        data.put("total", pager.getTotalRows()); // 数据总数
        data.put("rows", records); // 列表数据
        return data;
    }

    /**
     * 新增访客记录
     *
     * @param visitor 访客对象
     * @param staffID 办事人员ID
     * @return 操作记录
     */
    @RequestMapping("/add")
    @ResponseBody
    private Object add(VisitorModel visitor, String staffID) {

        // 若该访客数据不存在(首次来访),则增加访客对象
        if (iVisitorService.getVisitorByID(visitor.getId()) == null) {
            visitor.setCreateTime(new Date());
            iVisitorService.addVisitor(visitor);
        } else {
            visitor = iVisitorService.getVisitorByID(visitor.getId());
        }
        StaffModel staff = iStaffService.getStaffByID(staffID); // 获取员工对象
        // 实例化访客记录对象并插入数据
        RecordModel record = new RecordModel();
        record.setVisitDate(new Date());
        record.setVisitor(visitor);
        record.setStaff(staff.getName());
        record.setBusiness(staff.getDepart().getBusiness());
        boolean result = iRecordService.addRecord(record);
        return result ? "success" : "fail";
    }

}
