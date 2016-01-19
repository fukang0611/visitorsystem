package com.fk.core.controller;

import com.fk.core.model.DepartModel;
import com.fk.core.service.IDepartService;
import com.fk.core.service.IStaffService;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * 部门管理控制器.
 *
 * @author fukang 2016.01.06
 */
@Controller
@RequestMapping("/depart")
public class DepartController {

    @Autowired
    private IDepartService iDepartService; // 部门管理Service
    @Autowired
    private IStaffService iStaffService;   // 员工管理Service

    /**
     * @param pager 分页对象
     * @return 表格数据
     */
    @RequestMapping("/departList")
    @ResponseBody
    public Object departList(Pager pager) {

        List departList = iDepartService.getDepartList(pager); // 获取部门列表数据
        Map<String, Object> data = new HashMap<>();            // 构造数据封装对象
        data.put("total", pager.getTotalRows());               // 数据总数
        data.put("rows", departList);                          // 列表数据
        return data;
    }

    /**
     * 增加部门
     *
     * @param record 部门数据
     * @return 操作结果
     */
    @RequestMapping("/addDepart")
    @ResponseBody
    public Object addDepart(DepartModel record) {

        record.setCreateTime(new Date());
        boolean result = iDepartService.addDepart(record);
        return result ? "success" : "fail";
    }

    /**
     * 删除部门
     *
     * @param ids 部门id列表
     * @return 操作结果
     */
    @RequestMapping("/delDepartByIds")
    @ResponseBody
    public Object delDepartByIds(String ids) {

        String[] idsArray = ids.split(","); // 字符串ids转换为id数组
        for (String id : idsArray) {
            iDepartService.delDepart(id);   // 遍历数组,依次删除数据
        }
        return "success";
    }

    /**
     * 获取要编辑部门数据
     *
     * @param id 部门id
     * @return 部门数据
     */
    @RequestMapping("/editDepart")
    @ResponseBody
    public Object editDepart(String id) {

        DepartModel depart = iDepartService.getDepartByID(id); // 获取要编辑的部门对象
        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("data", depart);
        return result;
    }

    /**
     * 保存部门编辑
     *
     * @param record 部门数据
     * @return 操作结果
     */
    @RequestMapping("/doEditDepart")
    @ResponseBody
    public Object doEditDepart(DepartModel record) {

        boolean result = iDepartService.modDepart(record);
        return result ? "success" : "fail";
    }

    /**
     * 获取部门下拉框列表数据
     *
     * @return 部门列表
     */
    @RequestMapping("/getDepartOpts")
    @ResponseBody
    public Object getDepartOpts() {

        List departs = iDepartService.getDepartList();
        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("data", departs);
        return result;
    }

    /**
     * 根据部门,获取对应员工下拉框列表数据
     *
     * @param code 部门编码
     * @return 员工下拉框数据
     */
    @RequestMapping("/getStaffOpts")
    @ResponseBody
    public Object getStaffOpts(String code) {

        DepartModel depart = iDepartService.getDepartByCode(code); // 获取部门对象
        List<Map<String, String>> staffs = new ArrayList<>();      // 构造员工数据封装对象
        // 遍历该部门的所有员工对象,依次转存为map对象
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
