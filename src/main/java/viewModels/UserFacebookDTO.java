/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package viewModels;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class UserFacebookDTO {
    private String id, name, email;
    private PictureData picture;

    public UserFacebookDTO() {
    }

    public UserFacebookDTO(String id, String name, String email, PictureData picture) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.picture = picture;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public PictureData getPicture() {
        return picture;
    }

    public void setPicture(PictureData picture) {
        this.picture = picture;
    }
    
    

    @Override
    public String toString() {
        return "UserFacebookDTO{" + "id=" + id + ", name=" + name + ", email=" + email + ", picture=" + (picture != null ? picture.getData().getUrl() : "null") + '\'' + '}';
    }
}

class PictureData {
    private PictureUrl data;

    public PictureUrl getData() {
        return data;
    }

    public void setData(PictureUrl data) {
        this.data = data;
    }
}

class PictureUrl {
    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
