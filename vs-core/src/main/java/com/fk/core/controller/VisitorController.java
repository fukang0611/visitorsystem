package com.fk.core.controller;

import com.fk.core.model.VisitorModel;
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
 * 访客管理控制器
 *
 * @author fukang 2016.01.07
 */
@Controller
@RequestMapping("/visitor")
public class VisitorController {

    @Autowired
    IVisitorService iVisitorService;

    /**
     * 身份证扫描
     *
     * @param visitor 访客信息
     * @return 操作结果
     */
    @RequestMapping("/scanInfo")
    @ResponseBody
    public Object scanInfo(VisitorModel visitor) {

        // 若该访客首次来访,则增加访客信息
        if (iVisitorService.getVisitorByID(visitor.getId()) == null) {
            visitor.setCreateTime(new Date());
            iVisitorService.addVisitor(visitor);
        }
        Map<String, String> result = new HashMap<>();
        result.put("status", "success");
        result.put("id", visitor.getId());
        result.put("name", visitor.getName());
        result.put("sex", visitor.getSex());
        result.put("location", visitor.getLocation());
        return result;
    }

    /**
     * 访客管理表格数据
     *
     * @param pager 分页对象
     * @return 访客数据
     */
    @RequestMapping("/list")
    @ResponseBody
    public Object list(Pager pager) {

        List visitors = iVisitorService.getVisitors(pager);
        Map<String, Object> data = new HashMap<>();
        data.put("total", pager.getTotalRows()); // 数据总数
        data.put("rows", visitors); // 列表数据
        return data;
    }

    /**
     * 删除访客
     *
     * @param ids 访客id
     * @return 操作结果
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(String ids) {

        String[] idsArray = ids.split(",");
        for (String id : idsArray) {
            iVisitorService.delVisitor(id);
        }
        return "success";
    }

}
