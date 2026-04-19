<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
<title>Trang chủ</title>

<script src="https://cdn.tailwindcss.com"></script>

<!-- auto refresh -->
<meta http-equiv="refresh" content="10">

</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- BG -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

<!-- SIDEBAR -->
<jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

<!-- MAIN -->
<div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

<jsp:include page="/WEB-INF/public/layout/header.jsp"/>

<div class="p-8">

<div class="max-w-[1400px] mx-auto space-y-6">

<!-- SLIDESHOW -->
<div class="relative rounded-2xl overflow-hidden shadow-2xl backdrop-blur-xl border"
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
        <div class="w-2 h-2 bg-white rounded-full opacity-60"></div>
        <div class="w-2 h-2 bg-white rounded-full opacity-60"></div>
        <div class="w-2 h-2 bg-white rounded-full opacity-60"></div>
    </div>

</div>

<!-- ORDER HISTORY -->
<div class="rounded-2xl shadow-2xl backdrop-blur-xl overflow-hidden"
     style="background:rgba(255,255,255,0.35);">

<div class="flex justify-between items-center p-4 border-b">
    <h2 class="text-lg font-semibold text-[#27301B]">
        Lịch sử đơn hàng của tôi
    </h2>
</div>

<table class="w-full text-sm text-center">

<thead style="background:linear-gradient(135deg,#dfe6c3,#cfd5a5);" class="text-[#27301B]">
<tr>
    <th class="p-3">Mã Bill</th>
    <th>Ngày tạo</th>
    <th>Tổng tiền</th>
    <th>Trạng thái</th>
</tr>
</thead>

<tbody>

<c:choose>

<c:when test="${empty orders}">
<tr>
<td colspan="4" class="p-6 text-gray-500">
Chưa có đơn hàng nào
</td>
</tr>
</c:when>

<c:otherwise>

<c:forEach var="o" items="${orders}">
<tr class="border-t border-white/40 hover:bg-white/20 transition">

<td class="p-3 font-medium">${o.code}</td>

<td>${o.createdAt}</td>

<td class="text-[#41521E] font-medium">
    ${String.format("%,d", o.total).replace(",", ".")} đ
</td>

<td>

<c:choose>

<c:when test="${o.status == 'waiting'}">
<span class="text-gray-500 font-medium">
Chờ thanh toán
</span>
</c:when>

<c:when test="${o.status == 'pending_verify'}">
<span class="text-amber-600 font-semibold">
Chờ xác nhận
</span>
</c:when>

<c:when test="${o.status == 'finish'}">
<span class="text-green-600 font-semibold">
Hoàn tất
</span>
</c:when>

<c:otherwise>
<span class="text-red-500 font-semibold">
Đã hủy
</span>
</c:otherwise>

</c:choose>

</td>

</tr>
</c:forEach>

</c:otherwise>

</c:choose>

</tbody>

</table>

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

</body>
</html>
