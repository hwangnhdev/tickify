package dals;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.CustomerTicketDTO;
import models.Order;
import models.TicketDetailDTO;
import utils.DBContext;

/**
 * OrderDAO xử lý các thao tác truy vấn liên quan đến đơn hàng. Lớp này kế thừa
 * từ DBContext để sử dụng thuộc tính connection.
 */
public class OrderDAO extends DBContext {

    // Constructor kế thừa từ DBContext để khởi tạo kết nối.
    public OrderDAO() {
        super(); // Gọi constructor của DBContext
    }

}
