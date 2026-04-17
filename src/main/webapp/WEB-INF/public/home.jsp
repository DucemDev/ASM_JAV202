<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>

<head>
<title>Trang chủ</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

<!-- SIDEBAR -->
<jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

<!-- MAIN -->
<div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

<!-- HEADER -->
<jsp:include page="/WEB-INF/public/layout/header.jsp"/>

<!-- CONTENT -->
<div class="p-8">

<div class="max-w-[1400px] mx-auto space-y-6">

<!-- SLIDESHOW -->
<div class="relative rounded-2xl overflow-hidden shadow-2xl border backdrop-blur-xl"
     style="border:1px solid rgba(255,255,255,0.3);">

    <div id="slides" class="flex transition-transform duration-700">

        <img src="${pageContext.request.contextPath}/assets/image/slide1.jpg"
        class="w-full h-[320px] object-cover flex-shrink-0">

        <img src="${pageContext.request.contextPath}/assets/image/slide3.jpg"
        class="w-full h-[320px] object-cover flex-shrink-0">

        <img src="${pageContext.request.contextPath}/assets/image/slide2.jpg"
        class="w-full h-[320px] object-cover flex-shrink-0">

    </div>

    <!-- DOT -->
    <div class="absolute bottom-3 w-full flex justify-center gap-2">
        <div class="dot w-2 h-2 bg-white rounded-full opacity-60"></div>
        <div class="dot w-2 h-2 bg-white rounded-full opacity-60"></div>
        <div class="dot w-2 h-2 bg-white rounded-full opacity-60"></div>
    </div>

</div>
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">

    <!-- WELCOME -->
    <div class="p-6 rounded-2xl shadow-xl backdrop-blur-xl border"
         style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

        <p class="text-sm text-[#909632]">Xin chào 👋</p>

        <h2 class="text-2xl font-bold text-[#27301B] mt-2">
            ${sessionScope.user.fullname}
        </h2>

        <p class="text-gray-600 mt-2">
            Chúc bạn một ngày làm việc hiệu quả ☕
        </p>

        <!-- ROLE -->
        <p class="text-sm mt-3 text-[#41521E]">
            Vai trò:
            <c:choose>
                <c:when test="${sessionScope.user.role == 2}">Admin</c:when>
                <c:when test="${sessionScope.user.role == 1}">Nhân viên</c:when>
                <c:otherwise>Khách</c:otherwise>
            </c:choose>
        </p>

    </div>

    <!-- CLOCK -->
    <div class="p-6 rounded-2xl shadow-xl backdrop-blur-xl border text-center"
         style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

        <p class="text-sm text-[#909632] mb-2">Thời gian hiện tại</p>

        <h2 id="clock"
            class="text-3xl font-bold text-[#27301B]">
        </h2>

        <p class="text-gray-500 text-sm mt-2">
            Hệ thống PolyCafe
        </p>

    </div>

</div>


</div>

</div>

</div>

</div>

</div>

<script>

let index = 0;
let slides;

document.addEventListener("DOMContentLoaded", function(){

    slides = document.getElementById("slides");

    if(!slides){
        console.log("Không tìm thấy slides");
        return;
    }

    function showSlide(i){
        slides.style.transform = "translateX(-" + (i * 100) + "%)";
    }

    function nextSlide(){
        index = (index + 1) % 3;
        showSlide(index);
    }

    showSlide(0);
    setInterval(nextSlide, 3000);

});
</script>
<script>
function updateClock(){
    const now = new Date();
    const time = now.toLocaleTimeString('vi-VN');
    document.getElementById("clock").innerText = time;
}
setInterval(updateClock, 1000);
updateClock();
</script>
</body>

</html>
