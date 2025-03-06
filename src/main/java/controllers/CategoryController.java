/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import dals.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.Category;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class CategoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CategoryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CategoryController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        String action = request.getParameter("action");

        if ("search".equals(action)) {
            String query = request.getParameter("query");
            List<Category> searchResults = categoryDAO.getAllCategories(query); // Sử dụng phương thức GET_ALL_CATEGORY_SEARCH
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            Gson gson = new Gson();
            out.print(gson.toJson(searchResults));
            out.flush();
        } else {
            List<Category> listCategories = categoryDAO.getAllCategories();
            request.setAttribute("listCategories", listCategories);
            request.getRequestDispatcher("pages/adminPage/listCategories.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            if ("create".equals(action)) {
                String categoryName = request.getParameter("categoryName");
                String categoryDescription = request.getParameter("description");
                Category existingCategory = categoryDAO.getCategoryByName(categoryName);

                if (existingCategory != null) {
                    out.print("{\"success\": false, \"error\": \"Category already exists. Please use a different name.\"}");
                } else {
                    categoryDAO.createCategory(new Category(categoryName, categoryDescription));
                    response.sendRedirect("category?success=create");
                }
            } else if ("update".equals(action)) {
                int categoryId = Integer.parseInt(request.getParameter("categoryID"));
                String categoryName = request.getParameter("categoryName");
                String description = request.getParameter("description");

                Category existingCategory = categoryDAO.getCategoryByName(categoryName);

                if (existingCategory != null && existingCategory.getCategoryId() != categoryId) {
                    out.print("{\"success\": false, \"error\": \"Category name already exists. Please choose a different name.\"}");
                } else {
                    categoryDAO.updateCategory(new Category(categoryId, categoryName, description));
                    response.sendRedirect("category?success=update");
                }
            } else if ("delete".equals(action)) {
                int categoryId = Integer.parseInt(request.getParameter("categoryID"));

                categoryDAO.deleteCategory(categoryId);
                response.sendRedirect("category?success=delete");
            } else {
                out.print("{\"success\": false, \"error\": \"Invalid action\"}");
            }
        } catch (Exception e) {
            out.print("{\"success\": false, \"error\": \"Server error: " + e.getMessage() + "\"}");
        }
        out.flush();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
