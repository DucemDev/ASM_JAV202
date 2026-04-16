<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận OTP - PolyCafe</title>
    <style>
        body{
            margin:0; font-family:'Segoe UI', sans-serif;
            background: linear-gradient(135deg,#d7b899,#f3e5d4);
            height:100vh; display:flex; justify-content:center; align-items:center;
        }
        .container{
            width:400px; background:white; border-radius:20px;
            padding:50px; text-align:center;
            box-shadow:0 15px 40px rgba(0,0,0,0.15);
        }
        h1 { color: #6f4e37; margin-bottom: 10px; font-size: 26px; }
        .subtitle { color: #777; margin-bottom: 30px; font-size: 14px; }

        .input-box input{
            width:100%; padding:15px; border:none; border-radius:25px;
            background:#f3f3f3; font-size:24px; text-align:center;
            letter-spacing: 10px; font-weight: bold; color: #563b28;
            box-sizing: border-box; outline: none;
        }

        .verify-btn{
            width:100%; padding:15px; border:none; border-radius:25px;
            background:#6f4e37; color:white; font-size:16px; font-weight: bold;
            cursor:pointer; margin-top: 25px; transition: 0.3s;
        }
        .verify-btn:hover{ background:#563b28; }
        .error-msg { color: #e74c3c; font-size: 14px; margin-top: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Xác minh mã OTP</h1>
    <p class="subtitle">Mã xác nhận đã được gửi vào Gmail của bạn. <br> Vui lòng kiểm tra và nhập vào đây!</p>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <div class="input-box">
            <input type="text" name="otpCode" placeholder="000000" maxlength="6" required autocomplete="off">
        </div>

        <c:if test="${not empty message}">
            <p class="error-msg">${message}</p>
        </c:if>

        <button class="verify-btn" type="submit">XÁC NHẬN</button>
    </form>
</div>
</body>
</html>