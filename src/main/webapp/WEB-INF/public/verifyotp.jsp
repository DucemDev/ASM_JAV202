<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận OTP - PolyCafe</title>
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
    </style>
</head>
<body>
<div class="container">
    <h1>Xác nhận OTP</h1>
    <p class="subtitle">Vui lòng nhập mã OTP đã gửi về email của bạn.</p>

    <form action="${pageContext.request.contextPath}/verifyotp" method="post">
        <div class="input-box">
            <input type="text" name="otp" placeholder="Nhập mã OTP" required>
        </div>
        <button class="submit-btn" type="submit">Xác nhận</button>
    </form>

    <c:if test="${not empty message}">
        <p class="error-msg">${message}</p>
    </c:if>
</div>
</body>
</html>