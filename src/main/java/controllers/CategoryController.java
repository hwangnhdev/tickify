/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dals.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
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
            List<Category> searchResults = categoryDAO.getAllCategories(query);
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        try {
            // Đọc dữ liệu JSON từ request body
            StringBuilder sb = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            String jsonData = sb.toString();
            JsonObject jsonObject = gson.fromJson(jsonData, JsonObject.class);

            String action = jsonObject.get("action").getAsString();

            if ("create".equals(action)) {
                String categoryName = jsonObject.get("categoryName").getAsString();
                String categoryDescription = jsonObject.get("description").getAsString();
                Category existingCategory = categoryDAO.getCategoryByName(categoryName);

                if (existingCategory != null) {
                    out.print(gson.toJson(new ResponseMessage(false, "Category already exists. Please use a different name.")));
                } else {
                    categoryDAO.createCategory(new Category(categoryName, categoryDescription));
                    out.print(gson.toJson(new ResponseMessage(true, "Category created successfully")));
                }
            } else if ("update".equals(action)) {
                int categoryId = jsonObject.get("categoryID").getAsInt();
                String categoryName = jsonObject.get("categoryName").getAsString();
                String description = jsonObject.get("description").getAsString();

                Category existingCategory = categoryDAO.getCategoryByName(categoryName);

                if (existingCategory != null && existingCategory.getCategoryId() != categoryId) {
                    out.print(gson.toJson(new ResponseMessage(false, "Category name already exists. Please choose a different name.")));
                } else {
                    categoryDAO.updateCategory(new Category(categoryId, categoryName, description));
                    out.print(gson.toJson(new ResponseMessage(true, "Category updated successfully")));
                }
            } else if ("delete".equals(action)) {
                int categoryId = jsonObject.get("categoryID").getAsInt();
                categoryDAO.deleteCategory(categoryId);
                out.print(gson.toJson(new ResponseMessage(true, "Category deleted successfully")));
            } else {
                out.print(gson.toJson(new ResponseMessage(false, "Invalid action")));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi để kiểm tra
            out.print(gson.toJson(new ResponseMessage(false, "Server error: " + e.getMessage())));
        } finally {
            out.flush();
        }
    }

// Class phụ để định dạng response JSON
    class ResponseMessage {

        boolean success;
        String message;

        public ResponseMessage(boolean success, String message) {
            this.success = success;
            this.message = message;
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
