/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class Category {
    private int categoryId;
    private String categoryName;
    private String description;
    private Date createdAt;
    private Date updatedAt;

    public Category() {
    }

    public Category(int categoryId, String categoryName, String description, Date createdAt, Date updatedAt) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    
}
