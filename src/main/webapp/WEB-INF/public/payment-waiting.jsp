<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chờ xác nhận thanh toán</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative flex items-center justify-center"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<!-- CARD -->
<div class="relative z-10 w-full max-w-lg rounded-2xl shadow-2xl p-10 text-center backdrop-blur-xl border"
     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

    <!-- ICON -->
    <div class="text-6xl mb-4 animate-pulse">
        ⏳
    </div>

    <!-- TITLE -->
    <h2 class="text-2xl font-bold mb-4 text-[#27301B]">
        Đang chờ xác nhận thanh toán
    </h2>

    <!-- MESSAGE -->
    <p class="text-gray-600 mb-6">
        Chúng tôi đã nhận được yêu cầu thanh toán của bạn.<br>
        Vui lòng chờ nhân viên xác nhận giao dịch.
    </p>

    <!-- STATUS -->
    <div class="px-4 py-2 rounded-lg mb-6 text-sm font-medium"
         style="background:rgba(254,243,199,0.6); color:#b45309;">
        Trạng thái: Đang chờ xác nhận
    </div>

    <!-- BUTTON -->
    <a href="${pageContext.request.contextPath}/customer"
       class="inline-block text-white px-6 py-3 rounded-xl shadow-lg hover:scale-105 transition"
       style="background:#27301B;">
        Quay lại trang chủ
    </a>

</div>

</body>
</html>
