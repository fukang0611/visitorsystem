package com.fk.core.controller;

import com.fk.core.dao.IVisitorDao;
import com.fk.core.model.VisitorModel;
import com.fk.core.service.IVisitorService;
import com.sun.tools.internal.ws.processor.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/visitor")
public class VisitorController {

    @Autowired
    IVisitorService iVisitorService;

    @RequestMapping("/scanInfo")
    @ResponseBody
    public Object scanInfo(VisitorModel visitor) {

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
}
