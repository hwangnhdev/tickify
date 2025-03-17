/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class Admin {

    private int adminId;
    private String name;
    private String email;
    private String password;
    private String profilePicture;

    public Admin() {
    }

    public Admin(int adminId, String name, String email, String password, String profilePicture) {
        this.adminId = adminId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.profilePicture = profilePicture;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    @Override
    public String toString() {
        return "Admin{"
                + "adminId=" + adminId
                + ", name='" + name + '\''
                + ", email='" + email + '\''
                + ", password='" + password + '\''
                + ", profilePicture='" + profilePicture + '\''
                + '}';
    }
}
