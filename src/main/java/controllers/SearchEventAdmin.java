//package controllers;
//
//import dals.AdminDAO;
//import models.Event;
//import models.Event;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.List;
//
//public class SearchEventAdmin extends HttpServlet {
//    private static final int PAGE_SIZE = 20;
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int page = 1;
//        String pageParam = request.getParameter("page");
//        if (pageParam != null && !pageParam.trim().isEmpty()) {
//            try {
//                page = Integer.parseInt(pageParam);
//            } catch (NumberFormatException e) {
//                page = 1;
//            }
//        }
//
//        String searchKeyword = request.getParameter("search");
//        String tab = request.getParameter("tab");
//        if (tab == null || tab.trim().isEmpty()) {
//            tab = "all";
//        }
//
//        AdminDAO dao = new AdminDAO();
//        int totalRecords = 1;
//        
//        // Nếu có từ khóa tìm kiếm
//        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
//            if ("approved".equalsIgnoreCase(tab)) {
//                List<Event> events = dao.searchApprovedEventsByName(searchKeyword, page, PAGE_SIZE);
//                totalRecords = dao.getTotalSearchApprovedEventsByName(searchKeyword);
//                request.setAttribute("events", events);
//            } else if ("history".equalsIgnoreCase(tab)) {
//                List<Event> events = dao.searchHistoryEventsByName(searchKeyword, page, PAGE_SIZE);
//                totalRecords = dao.getTotalSearchHistoryApprovedEventsByName(searchKeyword);
//                request.setAttribute("events", events);
//            } else {
//                List<Event> events = dao.searchEventsByName(searchKeyword, page, PAGE_SIZE);
//                totalRecords = dao.getTotalSearchEventsByName(searchKeyword);
//                request.setAttribute("events", events);
//            }
//        } else {
//            // Nếu không có từ khóa, lấy dữ liệu mặc định theo tab
//            if ("approved".equalsIgnoreCase(tab)) {
//                List<Event> events = dao.getApprovedEvents(page, PAGE_SIZE);
//                totalRecords = dao.getTotalApprovedEvents();
//                request.setAttribute("events", events);
//            } else if ("history".equalsIgnoreCase(tab)) {
//                List<Event> events = dao.getHistoryApprovedEvents(page, PAGE_SIZE);
//                totalRecords = dao.getTotalHistoryApprovedEvents();
//                request.setAttribute("events", events);
//            } else {
//                List<Event> events = dao.getAllEvents(page, PAGE_SIZE);
//                totalRecords = dao.getTotalEvents();
//                request.setAttribute("events", events);
//            }
//        }
//
//        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
//        request.setAttribute("page", page);
//        request.setAttribute("totalPages", totalPages);
//        request.setAttribute("searchKeyword", searchKeyword);
//        request.setAttribute("selectedTab", tab);
//
//        // Forward đến view tương ứng dựa trên tab
//        if ("approved".equalsIgnoreCase(tab)) {
//            request.getRequestDispatcher("/pages/adminPage/viewApprovedEventsAdmin.jsp").forward(request, response);
//        } else if ("history".equalsIgnoreCase(tab)) {
//            request.getRequestDispatcher("/pages/adminPage/viewHistoryApprovedEventsAdmin.jsp").forward(request, response);
//        } else {
//            request.getRequestDispatcher("/pages/adminPage/viewAllEventsAdmin.jsp").forward(request, response);
//        }
//    }
//}
