<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - PolyCafe</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
</head>

<body class="min-h-screen bg-[var(--bg)]">

<div class="grid md:grid-cols-[60%_40%] min-h-screen">

    <!-- LEFT IMAGE -->
    <div class="hidden md:block">
        <img src="<c:url value='/assets/image/slide1.jpg'/>"
             class="w-full h-full object-cover">
    </div>

    <!-- RIGHT FORM -->
    <div class="flex items-center justify-center p-6">

        <div class="w-full max-w-md bg-[var(--surface)] p-8 rounded-2xl shadow-lg">

            <h1 class="text-2xl font-semibold mb-2">Đăng nhập</h1>
            <p class="text-gray-500 mb-6">Vui lòng đăng nhập</p>

            <form action="<c:url value='/logining'/>" method="post" class="space-y-4">

                <input type="text"
                       name="emailIp"
                       placeholder="Email"
                       class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:border-[var(--primary)]">

                <input type="password"
                       name="passwordIp"
                       placeholder="Mật khẩu"
                       class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:border-[var(--primary)]">

                <div class="flex justify-between text-sm">
                    <a href="<c:url value='/register'/>">Đăng ký</a>
                    <a href="<c:url value='/forgotpassword'/>">Quên mật khẩu?</a>
                </div>

                <button class="w-full bg-[var(--primary)] text-white py-3 rounded-lg hover:opacity-90 transition">
                    Đăng nhập
                </button>

            </form>

            <div class="text-xs text-gray-500 mt-6">
                truongmk@gmail.com | 123 (Admin)<br>
                ngoctm@gmail.com | 123 (nhân viên)<br>
                thangtv@gmail.com | 123 (khách hàng)
            </div>

        </div>

    </div>

</div>

<script src="<c:url value='/assets/js/script.js'/>"></script>
</body>
</html>