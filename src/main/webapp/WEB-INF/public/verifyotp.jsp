<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Xác nhận OTP</title>

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
        Xác nhận OTP
    </h2>

    <p class="text-sm text-gray-600 mb-6">
        Nhập mã OTP đã được gửi về email của bạn
    </p>

    <!-- FORM -->
    <form action="${pageContext.request.contextPath}/verifyotp" method="post" class="space-y-4">

        <input type="text"
               name="otp"
               placeholder="000000"
               required
               maxlength="6"
               class="w-full px-4 py-3 text-center text-xl font-bold tracking-[8px] rounded-xl border outline-none"
               style="background:rgba(255,255,255,0.5); border-color:#909632;">

        <!-- ERROR -->
        <p class="text-red-500 text-sm">
            ${message}
        </p>

        <button type="submit"
                class="w-full text-white py-3 rounded-xl shadow hover:scale-105 transition"
                style="background:#27301B;">
            Xác nhận
        </button>

    </form>

</div>

</body>
</html>
