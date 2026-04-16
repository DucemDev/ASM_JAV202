<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - PolyCafe</title>
    <style>
        body{
            margin:0; font-family:'Segoe UI', sans-serif;
            background: linear-gradient(135deg,#d7b899,#f3e5d4);
            height:100vh; display:flex; justify-content:center; align-items:center;
        }
        .container{
            width:420px; background:white; border-radius:20px;
            padding:40px; text-align:center;
            box-shadow:0 15px 40px rgba(0,0,0,0.15);
        }
        h1{ color:#6f4e37; margin:0 0 8px; font-size:26px; }
        .subtitle{ color:#777; margin-bottom:24px; font-size:14px; line-height:1.5; }
        .input-box input{
            width:100%; padding:14px; border:none; border-radius:12px;
            background:#f3f3f3; font-size:14px; box-sizing:border-box; outline:none;
        }
        .input-box input:focus{ box-shadow:0 0 0 2px #d7b899; background:#eee; }
        .submit-btn{
            width:100%; padding:14px; border:none; border-radius:12px;
            background:#6f4e37; color:white; font-size:16px; font-weight:600;
            cursor:pointer; margin-top:16px; transition:.2s;
        }
        .submit-btn:hover{ background:#563b28; }
        .error-msg{ color:#e74c3c; font-size:14px; margin-top:12px; }
        .back-link{ display:inline-block; margin-top:16px; color:#6f4e37; font-size:13px; text-decoration:none; }
        .back-link:hover{ text-decoration:underline; }
    </style>
</head>
<body>
<div class="container">
    <h1>Quên mật khẩu</h1>
    <p class="subtitle">Nhập email tài khoản để nhận mã OTP đặt lại mật khẩu.</p>

    <form action="${pageContext.request.contextPath}/forgotpassword" method="post">
        <div class="input-box">
            <input type="email" name="email" placeholder="Nhập email của bạn" required>
        </div>
        <button class="submit-btn" type="submit">Gửi mã OTP</button>
    </form>

    <c:if test="${not empty message}">
        <p class="error-msg">${message}</p>
    </c:if>

    <a class="back-link" href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
</div>
</body>
</html>