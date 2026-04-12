<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chờ xác nhận thanh toán</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 flex items-center justify-center min-h-screen">

<div class="bg-white p-10 rounded-2xl shadow-lg text-center max-w-lg w-full">

    <!-- ICON -->
    <div class="text-6xl mb-4">⏳</div>

    <!-- TITLE -->
    <h2 class="text-2xl font-bold mb-4 text-gray-800">
        Đang chờ xác nhận thanh toán
    </h2>

    <!-- MESSAGE -->
    <p class="text-gray-600 mb-6">
        Chúng tôi đã nhận được yêu cầu thanh toán của bạn.<br>
        Vui lòng chờ nhân viên xác nhận giao dịch.
    </p>

    <!-- STATUS -->
    <div class="bg-yellow-100 text-yellow-700 px-4 py-2 rounded mb-6">
        Trạng thái: pending_verify
    </div>

    <!-- BUTTON -->
    <a href="${pageContext.request.contextPath}/customer"
       class="bg-blue-500 text-white px-6 py-3 rounded hover:opacity-90">
        Quay lại trang chủ
    </a>

</div>

</body>
</html>