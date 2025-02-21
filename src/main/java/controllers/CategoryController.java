/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

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

        if ("create".equals(action)) {
            request.getRequestDispatcher("pages/admin/createCategory.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            Category category = categoryDAO.getCategoryByID(categoryID);
            request.setAttribute("category", category);
            request.getRequestDispatcher("pages/admin/editCategory.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            Category category = categoryDAO.getCategoryByID(categoryID);
            request.setAttribute("category", category);
            request.getRequestDispatcher("pages/admin/deleteCategory.jsp").forward(request, response);
        } else {
            List<Category> listCategories = categoryDAO.getAllCategories();
            request.setAttribute("listCategories", listCategories);
            request.getRequestDispatcher("pages/admin/listCategories.jsp").forward(request, response);
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

        if ("create".equals(action)) {
            // Retrieve category name and description from the request
            String categoryName = request.getParameter("categoryName");
            String categoryDescription = request.getParameter("description"); // Fix parameter name
            // Check if the category already exists in the database
            Category existingCategory = categoryDAO.getCategoryByName(categoryName);

            if (existingCategory != null) {
                // If the category already exists, set an error message
                request.setAttribute("errorMessage", "Category already exists. Please use a different name.");
                // Forward the request back to the create category page to display the error
                request.getRequestDispatcher("pages/admin/createCategory.jsp").forward(request, response);
            } else {
                // If the category does not exist, proceed with creating a new category
                categoryDAO.createCategory(new Category(categoryName, categoryDescription));
            }
            response.sendRedirect("category");
        } else if ("update".equals(action)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            int categoryId = Integer.parseInt(request.getParameter("categoryID"));
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");

            Category existingCategory = categoryDAO.getCategoryByName(categoryName);

            if (existingCategory != null && existingCategory.getCategoryId() != categoryId) {
                out.print("{\"error\": \"Category name already exists. Please choose a different name.\"}");
                out.flush();
                return;
            } else {
                categoryDAO.updateCategory(new Category(categoryId, categoryName, description));
                boolean success = true;
                if (success) {
                    out.print("{\"success\": true}");
                } else {
                    out.print("{\"error\": \"Failed to update category. Please try again.\"}");
                }
                out.flush();
            }
        } else if ("delete".equals(action)) {
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            categoryDAO.deleteCategory(categoryID);
            response.sendRedirect("category");
        }
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
