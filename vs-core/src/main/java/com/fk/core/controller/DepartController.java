package com.fk.core.controller;

import com.fk.core.model.DepartModel;
import com.fk.core.model.StaffModel;
import com.fk.core.service.IDepartService;
import com.fk.core.service.IStaffService;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("/depart")
public class DepartController {

    @Autowired
    IDepartService iDepartService;
    @Autowired
    IStaffService iStaffService;

    @RequestMapping("/departList")
    @ResponseBody
    public Object departList(Pager pager) {

        List departList = iDepartService.getDepartList(pager);
        Map<String, Object> data = new HashMap<>();
        data.put("total", pager.getTotalRows()); // 数据总数
        data.put("rows", departList); // 列表数据
        return data;
    }

    @RequestMapping("/addDepart")
    @ResponseBody
    public Object addDepart(DepartModel record) {

        record.setCreateTime(new Date());
        boolean result = iDepartService.addDepart(record);
        return result ? "success" : "fail";
    }

    @RequestMapping("/delDepartByIds")
    @ResponseBody
    public Object delDepartByIds(String ids) {

        String[] idsArray = ids.split(",");
        for (String id : idsArray) {
            iDepartService.delDepart(id);
        }
        return "success";
    }

    @RequestMapping("/editDepart")
    @ResponseBody
    public Object editDepart(String id) {

        DepartModel depart = iDepartService.getDepartByID(id);
        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("data", depart);
        return result;
    }

    @RequestMapping("/doEditDepart")
    @ResponseBody
    public Object doEditDepart(DepartModel record) {

        boolean result = iDepartService.modDepart(record);
        return result ? "success" : "fail";
    }

    @RequestMapping("/getDepartOpts")
    @ResponseBody
    public Object getDepartOpts() {

        List departs = iDepartService.getDepartList();
        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("data", departs);
        return result;
    }

    @RequestMapping("/getStaffOpts")
    @ResponseBody
    public Object getStaffOpts(String code) {

        DepartModel depart = iDepartService.getDepartByCode(code);
//        List staffs = new ArrayList<>(depart.getStaffs());

        List<Map<String, String>> staffs = new ArrayList<>();

        depart.getStaffs().forEach(staff -> {
            Map<String, String> map = new HashMap<>();
            map.put("id", staff.getId());
            map.put("name", staff.getName());
            map.put("officeTel", staff.getOfficeTel());
            staffs.add(map);
        });

        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("data", staffs);
        return result;
    }

}
