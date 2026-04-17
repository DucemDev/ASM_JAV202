<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quên mật khẩu</title>

<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative flex items-center justify-center"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- BG -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<!-- CARD -->
<div class="relative z-10 w-full max-w-md rounded-2xl shadow-2xl p-8 backdrop-blur-xl border text-center"
     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

    <!-- TITLE -->
    <h2 class="text-2xl font-bold text-[#27301B] mb-2">
        Quên mật khẩu
    </h2>

    <p class="text-sm text-gray-600 mb-6">
        Nhập email để nhận mã xác nhận (OTP)
    </p>

    <!-- FORM -->
    <form action="${pageContext.request.contextPath}/forgotpassword" method="post">

        <input type="email"
               name="email"
               placeholder="Nhập email của bạn"
               required
               class="w-full px-4 py-3 rounded-xl border outline-none mb-4"
               style="background:rgba(255,255,255,0.5); border-color:#909632;">

        <!-- ERROR -->
        <c:if test="${not empty message}">
            <p class="text-red-500 text-sm mb-3">
                ${message}
            </p>
        </c:if>

        <!-- BUTTON -->
        <button type="submit"
                class="w-full text-white py-3 rounded-xl shadow-lg hover:scale-105 transition"
                style="background:#27301B;">
            Gửi OTP
        </button>

    </form>

    <!-- BACK BUTTON -->
    <a href="${pageContext.request.contextPath}/login"
       class="block mt-4 text-[#27301B] text-sm hover:underline">
        ← Quay lại đăng nhập
    </a>

</div>

</body>
</html>