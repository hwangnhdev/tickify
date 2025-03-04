package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.TicketDetailDTO;
import utils.DBContext;

public class TicketDAO extends DBContext {

    // Constructor kế thừa từ DBContext
    public TicketDAO() {
        super(); // Gọi constructor của DBContext để thiết lập kết nối
    }

}
