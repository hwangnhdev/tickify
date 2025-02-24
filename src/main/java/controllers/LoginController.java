package controllers;

import dals.UserAccountDAO;
import models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu người dùng đã đăng nhập, chuyển hướng đến trang chính (ví dụ: viewalltickets hoặc home)
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/viewalltickets");
            return;
        }
        request.getRequestDispatcher("/pages/ticket/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin đăng nhập từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Sử dụng UserAccountDAO để xác thực
        UserAccountDAO userAccountDAO = new UserAccountDAO();
        User user = userAccountDAO.getUserByUsernameAndPassword(username, password);

        if (user != null) {
            // Đăng nhập thành công: lưu thông tin người dùng vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("message", "Đăng nhập thành công!");
            response.sendRedirect(request.getContextPath() + "/viewalltickets");
        } else {
            // Đăng nhập thất bại: hiển thị thông báo lỗi trên trang đăng nhập
            request.setAttribute("message", "Tài khoản không hợp lệ");
            request.getRequestDispatcher("/pages/ticket/login.jsp").forward(request, response);
        }
    }
}
