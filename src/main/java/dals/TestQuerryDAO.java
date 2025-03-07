/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.util.List;
import models.Event;
import models.Seat;
import models.Showtime;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class TestQuerryDAO {
    public static void main(String[] args) {
        SeatDAO SeatDAO = new SeatDAO();
//        int showtimeId = Integer.parseInt(request.getParameter("showtimeId"));
        List<Seat> seats = SeatDAO.selectSeatsByShowtimeId(1);
        
        for (Seat seat : seats) {
            System.out.println(seat);
        }
    }
}
