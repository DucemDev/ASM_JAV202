<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quá nhiều yêu cầu</title>

<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative flex items-center justify-center"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- BG -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<!-- CARD -->
<div class="relative z-10 w-full max-w-md rounded-2xl shadow-2xl p-8 text-center backdrop-blur-xl border"
     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

    <!-- ICON -->
    <div class="text-6xl mb-4 animate-pulse">
        🚫
    </div>

    <!-- TITLE -->
    <h1 class="text-2xl font-bold text-[#27301B] mb-2">
        Quá nhiều yêu cầu
    </h1>

    <!-- MESSAGE -->
    <p class="text-gray-600 mb-6">
        Bạn đã gửi quá nhiều yêu cầu trong thời gian ngắn.<br>
        Vui lòng đợi một chút rồi thử lại.
    </p>

    <!-- NOTE -->
    <p class="text-xs text-gray-500 mb-6">
        Hệ thống đang bảo vệ khỏi spam và tấn công 🚀
    </p>

    <!-- BUTTON -->
    <a href="${pageContext.request.contextPath}/"
       class="inline-block text-white px-6 py-3 rounded-xl shadow hover:scale-105 transition"
       style="background:#27301B;">
        Về trang chủ
    </a>

</div>

</body>
</html>
