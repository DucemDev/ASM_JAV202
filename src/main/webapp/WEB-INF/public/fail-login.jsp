<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tài khoản bị khóa - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="app-bg min-h-screen flex items-center justify-center p-4">

<div class="bg-white rounded-2xl shadow-lg p-8 w-full max-w-xl text-center border border-gray-200">
    <div class="text-5xl mb-4">🔒</div>
    <h1 class="text-2xl font-bold text-gray-800 mb-3">Tài khoản tạm thời bị khóa</h1>
    <p class="text-gray-600 mb-6">
        Bạn đã đăng nhập sai quá nhiều lần.<br>
        Vui lòng thử lại sau hoặc liên hệ quản trị viên để được hỗ trợ.
    </p>

    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
        Quay lại đăng nhập
    </a>
</div>

<script src="${pageContext.request.contextPath}/assets/js/scrip.js"></script>
</body>
</html>