<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - PolyCafe</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
    <style>
        .auth-simple-card{
            width: 420px;
            background: #fff;
            border-radius: var(--radius-xl);
            padding: 40px;
            text-align: center;
            box-shadow: var(--shadow-lg);
        }
        .auth-simple-title{ color: var(--color-primary-600); margin:0 0 8px; font-size:26px; }
        .auth-simple-sub{ color: var(--color-text-muted); margin-bottom:24px; font-size:14px; line-height:1.5; }
        .auth-simple-input{ margin-bottom:14px; }
        .auth-simple-input input{
            width:100%; padding:14px; border:none; border-radius:var(--radius-md);
            background:#f3f3f3; font-size:14px; outline:none;
        }
        .auth-simple-input input:focus{ box-shadow:0 0 0 2px rgba(139, 94, 60, .25); background:#eee; }
        .auth-simple-error{ color:#e74c3c; font-size:14px; margin-top:12px; }
        .auth-simple-back{ display:inline-block; margin-top:16px; font-size:13px; }
    </style>
</head>
<body class="auth-page">

<div class="auth-simple-card">
    <h1 class="auth-simple-title">Đặt lại mật khẩu</h1>
    <p class="auth-simple-sub">Nhập mật khẩu mới cho tài khoản của bạn.</p>

    <form action="${pageContext.request.contextPath}/verify-forgot-password" method="post" data-disable-on-submit="true">
        <div class="auth-simple-input">
            <input type="password" name="password" placeholder="Mật khẩu mới" required>
        </div>
        <button class="btn btn-primary" style="width:100%;" type="submit">Cập nhật mật khẩu</button>
    </form>

    <c:if test="${not empty message}">
        <p class="auth-simple-error">${message}</p>
    </c:if>

    <a class="auth-simple-back" href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>