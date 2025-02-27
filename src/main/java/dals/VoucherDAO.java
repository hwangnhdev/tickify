/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class VoucherDAO {

    private static final String SELECT_ALL_VOUCHERS = "SELECT * FROM Vouchers";
    private static final String SELECT_VOUCHER_BY_ID = "SELECT * FROM Vouchers WHERE voucher_id = ?";
    private static final String INSERT_VOUCHER = "INSERT INTO Vouchers (code, description, discount_type, discount_value, expiration_date, usage_limit) VALUES (?, ?, ?, ?, ?, ?)";

}
