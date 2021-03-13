package me.wbf.mis.util;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EmpLoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Object login = session.getAttribute("login");
        if (login != null) {
            return true;
        }
        request.setAttribute("message", "没有权限，请登录后执行操作！");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
        return false;
    }
}
