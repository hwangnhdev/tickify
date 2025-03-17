/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package viewModels;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class Bank {

    private int id;
    private String name;
    private String code;
    private String shortName;

    public Bank() {
    }

    public Bank(int id, String name, String code, String shortName) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.shortName = shortName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }
    
    
}
