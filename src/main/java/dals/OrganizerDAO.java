///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package dals;
//
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import models.Categories;
//import models.EventImages;
//import models.Events;
//import utils.DBContext;
//import models.Organizers;
//
///**
// *
// * @author Nguyen Huy Hoang - CE182102
// */
//public class OrganizerDAO extends DBContext {
//
//    public boolean createEvent(Event newEvent) {
//        String query = "insert into Events values (?, ?, ?, ?, ?, ?, ?, ?, ? ,?)"
//                + "";
//        try ( PreparedStatement ps = connection.prepareStatement(query)) {
////            ps.setInt(1, newEvent.getCategoryId());
////            ps.setString(2, newEvent.get());
////            ps.setString(3, newEvent.getPhone());
////            ps.setDate(4, newEvent.getDob());
////            ps.setString(5, newEvent.getGender());
////            ps.setString(6, newEvent.getProfilePicture());
////            ps.setInt(7, newEvent.getnewEventId());
////            return ps.executeUpdate() > 0;
//        } catch (SQLException e) {
//            System.out.println("Error creating new event: " + e.getMessage());
//        }
//        return false;
//    }
//}