package com.fk.web;

import com.fk.core.model.UserModel;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 登陆验证过滤器
 * Created by fukang on 2016.01.08
 */
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String url = req.getRequestURL().toString();
        //获得session中的对象
        HttpSession session = req.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (url.endsWith(".jsp")) {
            if (user == null && !url.endsWith("login.jsp")) {
                res.sendRedirect(req.getContextPath() + "/view/login.jsp");
            } else {
                chain.doFilter(request, response);
            }
        } else {
            chain.doFilter(request, response);
        }

        /*//使用endsWith()判断url结尾的字符串
        if (user != null || url.endsWith("login.jsp")) {
            //满足条件就继续执行
            chain.doFilter(request, response);
        } else {
            //不满足条件就跳转到其他页面
            *//*PrintWriter out = res.getWriter();
            out.print("<script language>alert('请登录！…………');top.location.href='error.jsp'</script>");*//*
            res.sendRedirect(req.getContextPath() + "/view/login.jsp");
        }*/
    }

    @Override
    public void destroy() {

    }
}
