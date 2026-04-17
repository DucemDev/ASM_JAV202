<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Đăng ký | PolyCafe</title>

<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="h-screen overflow-hidden"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<div class="relative h-full w-full">

<!-- TEXTURE -->
<div class="absolute inset-0 opacity-30"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="relative z-10 h-full flex items-center justify-center px-4 py-4">

<div class="w-full max-w-5xl rounded-3xl border backdrop-blur-xl shadow-2xl overflow-hidden"
     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

<div class="grid grid-cols-1 lg:grid-cols-2">

<!-- FORM -->
<div class="p-6 md:p-8 bg-white/60 backdrop-blur-xl">

<h1 class="text-2xl md:text-3xl font-bold text-[#27301B]">
    Đăng ký tài khoản
</h1>

<p class="mt-1 text-sm text-gray-600">
    Tạo tài khoản để sử dụng PolyCafe
</p>

<form action="<c:url value='/register'/>" method="post" class="mt-5 space-y-3">

<div>
<label class="text-sm font-medium text-[#41521E]">Họ và tên</label>
<input type="text" name="fullname" required
       class="w-full rounded-xl px-4 py-2.5 border outline-none"
       style="background:rgba(255,255,255,0.7); border-color:#909632;">
</div>

<div>
<label class="text-sm font-medium text-[#41521E]">Email</label>
<input type="email" name="email" required
       pattern="[a-z0-9._%+-]+@gmail\.com$"
       class="w-full rounded-xl px-4 py-2.5 border outline-none"
       style="background:rgba(255,255,255,0.7); border-color:#909632;">
</div>

<div>
<label class="text-sm font-medium text-[#41521E]">Số điện thoại</label>
    <input type="tel" name="phone" required
           pattern="^0\d{9}$"
           class="w-full rounded-xl px-4 py-2.5 border outline-none"
           style="background:rgba(255,255,255,0.7); border-color:#909632;">
</div>

<div>
<label class="text-sm font-medium text-[#41521E]">Mật khẩu</label>
<input type="password" name="password" required minlength="3"
       class="w-full rounded-xl px-4 py-2.5 border outline-none"
       style="background:rgba(255,255,255,0.7); border-color:#909632;">
</div>

<div>
<label class="text-sm font-medium text-[#41521E]">Xác nhận mật khẩu</label>
<input type="password" name="confirmPassword" required
       class="w-full rounded-xl px-4 py-2.5 border outline-none"
       style="background:rgba(255,255,255,0.7); border-color:#909632;">
</div>

<c:if test="${not empty message}">
<div class="rounded-xl bg-red-100 px-3 py-2 text-sm text-red-600">
    ${message}
</div>
</c:if>

<button type="submit"
        class="w-full rounded-xl text-white py-2.5 font-semibold hover:scale-105 transition"
        style="background:#27301B;">
    Đăng ký
</button>

</form>

<div class="mt-4 text-sm text-gray-600">
<a href="<c:url value='/login'/>"
   class="font-semibold text-[#27301B] hover:underline">
    Đã có tài khoản? Đăng nhập
</a>
</div>

</div>

<!-- SLIDE -->
<div class="relative min-h-[560px]">
<img id="welcomeSlide"
     src="<c:url value='/assets/image/slide1.jpg'/>"
     class="absolute inset-0 w-full h-full object-cover transition-opacity duration-500">

<div class="absolute inset-0"
     style="background:linear-gradient(to top, rgba(39,48,27,0.9), rgba(39,48,27,0.4));"></div>

<div class="relative z-10 h-full p-6 md:p-8 text-white flex flex-col justify-end">
    <p class="text-xs tracking-widest text-[#DDDAA8]">PolyCafe</p>

    <h2 class="mt-3 text-3xl font-bold">
        Gia nhập PolyCafe
    </h2>

    <p class="mt-3 text-sm text-white/90">
        Trải nghiệm cà phê và mua sắm tiện lợi mỗi ngày ☕
    </p>
</div>
</div>

</div>

</div>

</div>

</div>

</div>

<script>
const ctx = "${pageContext.request.contextPath}";
const welcomeImages = [
    ctx + "/assets/image/slide1.jpg",
    ctx + "/assets/image/slide2.jpg",
    ctx + "/assets/image/slide3.jpg"
];

let welcomeIndex = 0;
const welcomeSlide = document.getElementById("welcomeSlide");

setInterval(() => {
    welcomeIndex = (welcomeIndex + 1) % welcomeImages.length;
    welcomeSlide.style.opacity = "0.7";
    setTimeout(() => {
        welcomeSlide.src = welcomeImages[welcomeIndex];
        welcomeSlide.style.opacity = "1";
    }, 200);
}, 4000);
</script>

</body>
</html>
