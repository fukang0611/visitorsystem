package com.fk.core.controller;


import com.fk.core.model.RecordModel;
import com.fk.core.model.StaffModel;
import com.fk.core.model.VisitorModel;
import com.fk.core.service.IRecordService;
import com.fk.core.service.IStaffService;
import com.fk.core.service.IVisitorService;
import com.fk.core.utils.Pager;
import com.fk.core.utils.StringHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

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
     * 查看访客记录(所有记录)
     *
     * @param pager 分页对象
     * @return 表格数据
     */
    @RequestMapping("/list")
    @ResponseBody
    public Object list(Pager pager) {

        List records = iRecordService.getRecords(pager);
        Map<String, Object> data = new HashMap<>();
        data.put("total", pager.getTotalRows()); // 数据总数
        data.put("rows", records); // 列表数据

        return data;
    }

    /**
     * 查看访客记录(当天记录)
     *
     * @param pager 分页对象
     * @return 当天数据
     */
    @RequestMapping("/today")
    @ResponseBody
    public Object today(Pager pager) {

        Date date = Calendar.getInstance().getTime();
        List records = iRecordService.getRecords(pager, date);
        Map<String, Object> data = new HashMap<>();
        data.put("total", pager.getTotalRows()); // 数据总数
        data.put("rows", records); // 列表数据

        return data;
    }

    /**
     * 新增访客记录
     *
     * @param id      访客身份证号
     * @param staffID 办事人员ID
     * @return 操作结果
     */
    @RequestMapping("/add")
    @ResponseBody
    public Object add(String id, String staffID) {

        // 得到访客
        VisitorModel visitor = iVisitorService.getVisitorByID(id);
        // 得到员工
        StaffModel staff = iStaffService.getStaffByID(staffID);

        //region // 实例化访客记录对象并插入数据
        RecordModel record = new RecordModel();
        record.setVisitDate(new Date());
        record.setVisitor(visitor);
        record.setStaff(staff.getName());
        record.setBusiness(staff.getDepart().getBusiness());
        //endregion

        // 保存访客记录
        boolean result = iRecordService.addRecord(record);
        return result ? "success" : "failure";
    }

}
