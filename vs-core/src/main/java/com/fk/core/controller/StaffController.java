package com.fk.core.controller;

import com.fk.core.model.DepartModel;
import com.fk.core.model.StaffModel;
import com.fk.core.service.IDepartService;
import com.fk.core.service.IStaffService;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@Controller
@RequestMapping("/staff")
public class StaffController {

    @Autowired
    IStaffService iStaffService;
    @Autowired
    IDepartService iDepartService;

    @RequestMapping("/staffList")
    @ResponseBody
    public Object staffList(Pager pager) {

        List staffList = iStaffService.getStaffList(pager);
        Map<String, Object> data = new HashMap<>();
        data.put("total", pager.getTotalRows()); // 数据总数
        data.put("rows", staffList); // 列表数据
        return data;
    }

    @RequestMapping("/addStaff")
    @ResponseBody
    public Object addStaff(StaffModel record, String departCode) {

        DepartModel depart = iDepartService.getDepartByCode(departCode);
        record.setDepart(depart);
        record.setCreateTime(new Date());
        iStaffService.addStaff(record);

        StaffModel staff = iStaffService.getStaffByName(record.getName());
        depart.getStaffs().add(staff);
        iDepartService.modDepart(depart);

        return "success";
    }

    @RequestMapping("/doEditStaff")
    @ResponseBody
    public Object doEditStaff(StaffModel record, String departCode) {

        DepartModel depart = iDepartService.getDepartByCode(departCode);
        record.setDepart(depart);
        boolean result = iStaffService.modStaff(record);
        return result ? "success" : "fail";
    }


    @RequestMapping("/delStaffByIds")
    @ResponseBody
    public Object delStaffByIds(String ids) {

        String[] idsArray = ids.split(",");
        for (String id : idsArray) {
            iStaffService.delStaff(id);
        }
        return "success";
    }

    @RequestMapping("/editStaff")
    @ResponseBody
    public Object editStaff(String id) {

        StaffModel staff = iStaffService.getStaffByID(id);
        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("data", staff);
        return result;
    }
}
