<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - PolyCafe</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
</head>
<body class="auth-page auth-register" data-context-path="${pageContext.request.contextPath}">

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
                <p style="color:red; font-size:13px; margin-bottom:15px;">${message}</p>
            </c:if>

            <button class="register-btn" type="submit">Đăng ký</button>
        </form>

        <div class="footer">
            <a href="<c:url value='/login'/>">Đã có tài khoản? Đăng nhập ngay</a><br><br>
            <a href="<c:url value='/customer'/>">Mua hàng ngay không cần đăng nhập?</a>
        </div>
    </div>

    <div class="right">
        <img id="slide" src="<c:url value='/assets/image/slide1.jpg'/>" class="slide-img js-auth-slide" alt="Ảnh giới thiệu PolyCafe">
        <div class="welcome">
            <h2>Gia nhập PolyCafe</h2>
            <p>Trải nghiệm cà phê tuyệt vời ☕</p>
        </div>
    </div>
</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>