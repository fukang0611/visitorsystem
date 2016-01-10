package com.fk.web;

import com.fk.core.model.UserModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 自定义SpringMVC拦截器,判断用户登陆状态
 * Created by fukang on 2016.01.08
 */
public class CommonInterceptor extends HandlerInterceptorAdapter {

    private final Logger log = LoggerFactory.getLogger(CommonInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        log.info("进入interceptor拦截器");
        /*UserModel user = (UserModel) request.getSession().getAttribute("user");
        if (user == null) {
            log.info("interceptor:尚未登陆,跳转至登陆页面!");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            return false;
        } else {
            return true;
        }*/
        return true;
    }
}
