<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận OTP - PolyCafe</title>

    <style>
        body{
            margin:0;
            font-family:'Segoe UI', sans-serif;
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            overflow:hidden;
            background: linear-gradient(135deg,#e6e8dc,#cfd5a5);
        }

        /* 🔥 BLOBS ANIMATION */
        @keyframes float {
            0% { transform: translate(0,0); }
            50% { transform: translate(40px,-40px); }
            100% { transform: translate(0,0); }
        }

        .blob{
            position:absolute;
            border-radius:50%;
            filter: blur(80px);
            opacity:0.5;
            animation: float 12s infinite ease-in-out;
        }

        .blob1{ width:300px;height:300px;background:#909632;top:-80px;left:-80px;}
        .blob2{ width:250px;height:250px;background:#41521E;bottom:-60px;right:-60px;animation-delay:2s;}
        .blob3{ width:280px;height:280px;background:#DDDAA8;top:40%;left:30%;animation-delay:4s;}

        .container{
            width:380px;
            background:rgba(255,255,255,0.35);
            backdrop-filter: blur(12px);
            border-radius:20px;
            padding:40px;
            text-align:center;
            box-shadow:0 20px 50px rgba(0,0,0,0.15);
            border:1px solid rgba(255,255,255,0.3);
            z-index:1;
        }

        h1{
            color:#27301B;
            margin-bottom:10px;
            font-size:24px;
        }

        .subtitle{
            color:#555;
            margin-bottom:25px;
            font-size:14px;
        }

        .input-box input{
            width:100%;
            padding:14px;
            border-radius:15px;
            border:1px solid #909632;
            background:rgba(255,255,255,0.7);
            font-size:22px;
            text-align:center;
            letter-spacing:10px;
            font-weight:bold;
            color:#27301B;
            outline:none;
        }

        .verify-btn{
            width:100%;
            padding:14px;
            border:none;
            border-radius:15px;
            background:#27301B;
            color:white;
            font-size:15px;
            font-weight:bold;
            cursor:pointer;
            margin-top:20px;
            transition:0.3s;
        }

        .verify-btn:hover{
            transform:scale(1.05);
        }

        .error-msg{
            color:#e74c3c;
            font-size:13px;
            margin-top:12px;
        }
    </style>

</head>

<body>

<!-- BACKGROUND BLOBS -->
<div class="blob blob1"></div>
<div class="blob blob2"></div>
<div class="blob blob3"></div>

<div class="container">

    <h1>Xác minh mã OTP</h1>

    <p class="subtitle">
        Mã xác nhận đã được gửi vào Gmail của bạn.<br>
        Vui lòng nhập vào bên dưới
    </p>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">

        <div class="input-box">
            <input type="text" name="otpCode" placeholder="000000" maxlength="6" required autocomplete="off">
        </div>

        <c:if test="${not empty message}">
            <p class="error-msg">${message}</p>
        </c:if>

        <button class="verify-btn" type="submit">
            XÁC NHẬN
        </button>

    </form>

</div>

</body>
</html>