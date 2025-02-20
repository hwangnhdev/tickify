<%-- 
    Document   : profileCustomer
    Created on : Feb 11, 2025, 3:54:38 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Management</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/vietblogdao/js/districts.min.js"></script>
        <style>
            .profile-picture {
                display: flex;
                flex-direction: column;
                align-items: center;
                border: 1px solid #e3e3e3;
                border-radius: 8px;
                padding: 20px;
            }
            .profile-picture img {
                border-radius: 50%;
                width: 200px;
                height: 200px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h4>My Profile</h4>
            <div class="row">
                <!-- Profile Picture Section -->
                <div class="col-md-4">
                    <div class="profile-picture text-center">
                        <img
                            src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCiOMHxUfCcUg2KR3YZelkq157yA9q6lry92omWqdUtA6U4Oa9Kwx8kMQ&s"
                            alt="Profile Picture"
                            />
                        <p class="mt-3">JPG or PNG no larger than 5 MB</p>
                        <button class="btn btn-primary">Upload new image</button>
                    </div>
                </div>

                <!-- Account Details Section -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Account Details</h5>
                            <form>
                                <div class="row mb-3">
                                    <div class="col">
                                        <label for="username" class="form-label">Username</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            id="username"
                                            placeholder="username"
                                            />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <label for="firstName" class="form-label">First name</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            id="firstName"
                                            placeholder="First name"
                                            />
                                    </div>
                                    <div class="col">
                                        <label for="lastName" class="form-label">Last name</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            id="lastName"
                                            placeholder="Last name"
                                            />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <label for="phone" class="form-label">Phone number</label>
                                        <input
                                            type="tel"
                                            class="form-control"
                                            id="phone"
                                            placeholder="000-000-0000"
                                            />
                                    </div>
                                    <div class="col">
                                        <label for="birthday" class="form-label">Birthday</label>
                                        <input
                                            type="date"
                                            class="form-control"
                                            id="birthday"
                                            value="1988-06-10"
                                            />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <label for="email" class="form-label">Email</label>
                                        <input
                                            type="email"
                                            class="form-control"
                                            id="email"
                                            placeholder="name@example.com"
                                            />
                                    </div>
                                </div>
                                <!-- Address Section -->
                                <div class="row mb-3">
                                    <div class="col">
                                        <label for="province" class="form-label"
                                               >Province/City</label
                                        >
                                        <select
                                            name="calc_shipping_provinces"
                                            class="form-select"
                                            required
                                            >
                                            <option value="">Tỉnh / Thành phố</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <label for="district" class="form-label">District</label>
                                        <select
                                            name="calc_shipping_district"
                                            class="form-select"
                                            required
                                            >
                                            <option value="">Quận / Huyện</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <label for="address" class="form-label">Full Address</label>
                                        <input
                                            class="form-control billing_address_1"
                                            name=""
                                            type="text"
                                            placeholder="Street name, Building number"
                                            />
                                        <input
                                            class="billing_address_2"
                                            name=""
                                            type="hidden"
                                            value=""
                                            />
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary">
                                    Save changes
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // Tích hợp script lọc địa chỉ từ districts.min.js
            if ((address_2 = localStorage.getItem("address_2_saved"))) {
                $('select[name="calc_shipping_district"] option').each(function () {
                    if ($(this).text() == address_2) {
                        $(this).attr("selected", "");
                    }
                });
                $("input.billing_address_2").attr("value", address_2);
            }
            if ((district = localStorage.getItem("district"))) {
                $('select[name="calc_shipping_district"]').html(district);
                $('select[name="calc_shipping_district"]').on("change", function () {
                    var target = $(this).children("option:selected");
                    target.attr("selected", "");
                    $('select[name="calc_shipping_district"] option')
                            .not(target)
                            .removeAttr("selected");
                    address_2 = target.text();
                    $("input.billing_address_2").attr("value", address_2);
                    district = $('select[name="calc_shipping_district"]').html();
                    localStorage.setItem("district", district);
                    localStorage.setItem("address_2_saved", address_2);
                });
            }

            $('select[name="calc_shipping_provinces"]').each(function () {
                var $this = $(this),
                        stc = "";
                c.forEach(function (i, e) {
                    e += +1;
                    stc += "<option value=" + e + ">" + i + "</option>";
                    $this.html('<option value="">Tỉnh / Thành phố</option>' + stc);

                    if ((address_1 = localStorage.getItem("address_1_saved"))) {
                        $('select[name="calc_shipping_provinces"] option').each(
                                function () {
                                    if ($(this).text() == address_1) {
                                        $(this).attr("selected", "");
                                    }
                                }
                        );
                        $("input.billing_address_1").attr("value", address_1);
                    }
                    $this.on("change", function (i) {
                        i = $this.children("option:selected").index() - 1;
                        var str = "",
                                r = $this.val();
                        if (r != "") {
                            arr[i].forEach(function (el) {
                                str += '<option value="' + el + '">' + el + "</option>";
                                $('select[name="calc_shipping_district"]').html(
                                        '<option value="">Quận / Huyện</option>' + str
                                        );
                            });
                            var address_1 = $this.children("option:selected").text();
                            var district = $('select[name="calc_shipping_district"]').html();
                            localStorage.setItem("address_1_saved", address_1);
                            localStorage.setItem("district", district);
                        } else {
                            $('select[name="calc_shipping_district"]').html(
                                    '<option value="">Quận / Huyện</option>'
                                    );
                            district = $('select[name="calc_shipping_district"]').html();
                            localStorage.setItem("district", district);
                            localStorage.removeItem("address_1_saved", address_1);
                        }
                    });
                });
            });

            // Bổ sung tính năng tự động điền địa chỉ đầy đủ
            function updateFullAddress() {
                const province = $(
                        'select[name="calc_shipping_provinces"] option:selected'
                        ).text();
                const district = $(
                        'select[name="calc_shipping_district"] option:selected'
                        ).text();
                if (province && district) {
                    const fullAddress = `${district}, ${province}`;
                                $(".billing_address_1").val(fullAddress);
                            }
                        }

                        // Lắng nghe sự thay đổi của dropdown
                        $(
                                'select[name="calc_shipping_provinces"], select[name="calc_shipping_district"]'
                                ).on("change", updateFullAddress);
        </script>
    </body>
</html>
