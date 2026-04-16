<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chờ xác nhận thanh toán - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body class="app-bg min-h-screen flex items-center justify-center p-4">

<div class="bg-white p-10 rounded-2xl shadow-lg text-center max-w-lg w-full border border-gray-200">

    <div class="text-6xl mb-4">⏳</div>

    <h2 class="text-2xl font-bold mb-4 text-gray-800">Đang chờ xác nhận thanh toán</h2>

    <p class="text-gray-600 mb-6">
        Chúng tôi đã nhận được yêu cầu thanh toán của bạn.<br>
        Vui lòng chờ nhân viên xác nhận giao dịch.
    </p>

    <div class="badge badge-warning mb-6">
        Trạng thái: Chờ xác nhận
    </div>

    <div>
        <a href="${pageContext.request.contextPath}/customer" class="btn btn-primary">
            Quay lại trang chủ
        </a>
    </div>

</div>

<script src="${pageContext.request.contextPath}/assets/js/scrip.js"></script>
</body>
</html>