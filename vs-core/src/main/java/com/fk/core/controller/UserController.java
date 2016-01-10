package com.fk.core.controller;

import com.fk.core.model.UserModel;
import com.fk.core.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * 用户管理控制器
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    IUserService iUserService;

    /**
     * 用户登陆验证
     *
     * @param username 用户名
     * @param password 密码
     * @param session  session会话
     * @return 验证结果
     */
    @RequestMapping("/loginValidate")
    @ResponseBody
    public Object loginValidate(String username, String password, HttpSession session) {

        boolean result = false;
        UserModel user = iUserService.getUserByUsername(username);
        if (user != null) {
            result = user.getPassword().equals(password);
        }
        if (result) {
            session.setAttribute("user", user);
            return "success";
        }
        return "fail";
    }

    @RequestMapping("/toLoginPage")
    @ResponseBody
    public String toLoginPage(HttpSession session) {
        session.removeAttribute("user");
        return "success";
    }
}
