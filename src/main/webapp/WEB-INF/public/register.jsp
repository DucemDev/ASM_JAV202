<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PolyCafe Register</title>
    <style>
        /* GIỮ NGUYÊN PHẦN CSS CỦA THẮNG */
        body{ margin:0; font-family:'Segoe UI', sans-serif; height:100vh; display:flex; justify-content:center; align-items:center; background: linear-gradient(135deg,#e6d3c3,#f6efe7); }
        .container{ width:900px; height:90%; background:rgba(255,255,255,0.95); backdrop-filter: blur(10px); border-radius:20px; display:flex; overflow:hidden; box-shadow:0 20px 50px rgba(0,0,0,0.15); }
        .left{ width:55%; padding:60px; }
        .right{ width:45%; position:relative; }
        .slide-img{ width:100%; height:100%; object-fit:cover; position:absolute; }
        .right::before{ content:''; position:absolute; inset:0; background:linear-gradient(to top, rgba(0,0,0,0.6), transparent); z-index:1; }
        .welcome{ position:absolute; bottom:30px; left:25px; color:white; z-index:2; }
        .welcome h2{ margin:0; font-size:24px; }
        .welcome p{ margin-top:5px; font-size:14px; opacity:0.9; }
        .subtitle{ color:#777; margin-bottom:30px; }
        .input-box{ margin-bottom:20px; }
        .input-box input{ width:100%; padding:14px; border:none; border-radius:12px; background:#f5f5f5; font-size:14px; }
        .input-box input:focus{ outline:none; background:#eee; box-shadow:0 0 0 2px #d7b899; }
        .register-btn{ width:100%; padding:14px; border:none; border-radius:12px; background:linear-gradient(135deg,#8b5e3c,#6f4e37); color:white; font-size:16px; cursor:pointer; }
        .register-btn:hover{ translateY(-2px); }
        a{ color:#6f4e37; text-decoration:none; font-size:13px; }
        .footer{ margin-top:15px; font-size:13px; text-align:center; }
    </style>
</head>

<body>

<div class="container">
    <div class="left">
        <h1>Đăng ký</h1>
        <p class="subtitle">Tạo tài khoản mới cho PolyCafe</p>

        <form action="<c:url value='/register'/>" method="post">
            <div class="input-box">
                <input type="text" name="fullname" placeholder="Họ và tên" required>
            </div>

            <div class="input-box">
                <input type="email" name="email" placeholder="Email (ví dụ: abc@gmail.com)"
                       pattern="[a-z0-9._%+-]+@gmail\.com$"
                       title="Vui lòng sử dụng địa chỉ @gmail.com" required>
            </div>

            <div class="input-box">
                <input type="tel" name="phone" placeholder="Số điện thoại (10 số, bắt đầu bằng 0)"
                       pattern="^0\d{9}$"
                       title="Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0" required>
            </div>

            <div class="input-box">
                <input type="password" name="password" placeholder="Mật khẩu" minlength="3" required>
            </div>

            <div class="input-box">
                <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
            </div>

            <c:if test="${not empty message}">
                <p style="color:red; font-size:13px; margin-bottom: 15px;">${message}</p>
            </c:if>

            <button class="register-btn" type="submit">Đăng ký</button>
        </form>

        <div class="footer">
            <a href="<c:url value='/login'/>">Đã có tài khoản? Đăng nhập ngay</a><br><br>
            <a href="<c:url value='/customer'/>">Mua hàng ngay không cần đăng nhập?</a>
        </div>
    </div>

    <div class="right">
        <img id="slide" src="<c:url value='/assets/image/slide1.jpg'/>" class="slide-img">
        <div class="welcome">
            <h2>Gia nhập PolyCafe</h2>
            <p>Trải nghiệm cà phê tuyệt vời ☕</p>
        </div>
    </div>
</div>

<script>
    const ctx = "${pageContext.request.contextPath}";
    let images = [
        ctx + "/assets/image/slide1.jpg",
        ctx + "/assets/image/slide2.jpg",
        ctx + "/assets/image/slide3.jpg"
    ];

    let index = 0;
    const slideImg = document.getElementById("slide");

    setInterval(() => {
        index++;
        if(index >= images.length) index = 0;
        slideImg.style.opacity = "0.7";
        setTimeout(() => {
            slideImg.src = images[index];
            slideImg.style.opacity = "1";
        }, 200);
    }, 4000);
</script>

</body>
</html>