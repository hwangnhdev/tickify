//package controllers;
//
//import dals.OrganizerDAO;  // We'll reuse this DAO assuming it has methods to fetch all orders
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.List;
//import viewModels.OrderDetailDTO;
//
//public class AdminOrdersController extends HttpServlet {
//    
//    private static final int PAGE_SIZE = 10;
//
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        // Get page number from parameter, default to 1
//        String pageParam = request.getParameter("page");
//        int currentPage = (pageParam != null && !pageParam.trim().isEmpty()) ? Integer.parseInt(pageParam) : 1;
//        int offset = (currentPage - 1) * PAGE_SIZE;
//
//        // Get payment status filter parameter, default to "all"
//        String paymentStatus = request.getParameter("paymentStatus");
//        if (paymentStatus == null || paymentStatus.trim().isEmpty()) {
//            paymentStatus = "all";
//        }
//
//        // Get search parameter for customer name
//        String searchOrder = request.getParameter("searchOrder");
//        if (searchOrder != null && searchOrder.trim().isEmpty()) {
//            searchOrder = null;
//        }
//
//        OrganizerDAO organizerDAO = new OrganizerDAO();
//        // Get all orders with pagination, payment status filter, and search
//        List<OrderDetailDTO> orders = organizerDAO.getAllOrderDetails(
//                paymentStatus, searchOrder, offset, PAGE_SIZE);
//        int totalRecords = organizerDAO.countAllOrders(paymentStatus, searchOrder);
//        int totalPages = (int) Math.ceil(totalRecords / (double) PAGE_SIZE);
//
//        // Set attributes for the JSP view
//        request.setAttribute("orders", orders);
//        request.setAttribute("currentPage", currentPage);
//        request.setAttribute("totalPages", totalPages);
//        request.setAttribute("paymentStatus", paymentStatus);
//        request.setAttribute("searchOrder", searchOrder);
//
//        // Forward to the admin orders JSP page
//        RequestDispatcher rd = request.getRequestDispatcher("/pages/adminPage/adminOrders.jsp");
//        rd.forward(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "AdminOrdersController retrieves all orders and forwards to adminOrders.jsp";
//    }
//}