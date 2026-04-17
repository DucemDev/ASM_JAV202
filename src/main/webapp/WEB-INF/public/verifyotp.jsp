<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Xác nhận OTP - PolyCafe</title>

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

    <!-- TITLE -->
    <h1 class="text-2xl font-bold text-[#27301B] mb-2">
        Xác minh mã OTP
    </h1>

    <p class="text-sm text-gray-600 mb-6">
        Mã xác nhận đã được gửi vào Gmail của bạn.<br>
        Vui lòng nhập vào bên dưới
    </p>

    <!-- FORM -->
    <form action="${pageContext.request.contextPath}/verify-otp" method="post">

        <!-- INPUT -->
        <input type="text"
               name="otpCode"
               placeholder="000000"
               maxlength="6"
               required
               autocomplete="off"
               class="w-full px-4 py-3 text-center text-2xl font-bold tracking-[10px] rounded-xl border outline-none"
               style="background:rgba(255,255,255,0.5); border-color:#909632; color:#27301B;">

        <!-- ERROR -->
        <c:if test="${not empty message}">
            <p class="text-red-500 text-sm mt-3">
                ${message}
            </p>
        </c:if>

        <!-- BUTTON -->
        <button type="submit"
                class="w-full mt-6 text-white py-3 rounded-xl shadow-lg hover:scale-105 transition"
                style="background:#27301B;">
            XÁC NHẬN
        </button>

    </form>

</div>

</body>
</html>