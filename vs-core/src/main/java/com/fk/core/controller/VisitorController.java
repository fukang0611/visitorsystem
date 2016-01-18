package com.fk.core.controller;

import com.fk.core.model.VisitorModel;
import com.fk.core.service.IVisitorService;
import com.fk.core.utils.DecodeImage;
import com.fk.core.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
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
    public Object scanInfo(VisitorModel visitor, String imgCode, HttpServletRequest request) {

        // 构造返回数据map
        Map<String, String> result = new HashMap<>();
        // 若该访客首次来访,则增加访客信息
        if (iVisitorService.getVisitorByID(visitor.getId()) == null) {
            // 创建日期,照片文件名[姓名+身份证号前六位数]
            visitor.setCreateTime(new Date());
            visitor.setPhoto(visitor.getName() + visitor.getId().substring(0, 5));
            // 图片在服务器目录下的相对路径
            String imgUrl = savePhoto(request, visitor.getPhoto(), imgCode);
            // 新增该访客对象到数据库
            boolean res = iVisitorService.addVisitor(visitor);
            // 填入返回数据
            result.put("status", res ? "success" : "failure");
            result.put("img", imgUrl == null ? "#" : imgUrl);
        } else { // 若有该访客记录,则取出
            visitor = iVisitorService.getVisitorByID(visitor.getId());
            result.put("status", "success");
            result.put("img", visitor.getPhoto());
        }
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

    /**
     * 获取身份证头像的base64编码,解码后以jpg格式存储于服务器目录下
     *
     * @param request 请求
     * @param imgName 照片文件名:姓名+身份证号前6位数
     * @param imgCode 照片编码,base64格式
     * @return 存储于服务器目录下的照片相对路径, 用于填充<img>标签的src属性
     */
    private String savePhoto(HttpServletRequest request, String imgName, String imgCode) {

        // 照片存储路径
        String imgPath = request.getSession().getServletContext().getRealPath("/") + "img\\photo\\";
        // 照片文件相对路径,用于返回页面,作为<img>标签的src属性
        String relativePath = imgPath.substring(imgPath.indexOf("myweb") + 6) + imgName;
        // 调用解码工具类将编码转换为jpg图片,存于照片存储路径中
        boolean res = DecodeImage.GenerateImage(imgCode, imgPath, imgName);
        // 解码成功则返回图片存储相对路径,否则返回null
        if (res) {
            return relativePath;
        } else {
            return null;
        }
    }

}
