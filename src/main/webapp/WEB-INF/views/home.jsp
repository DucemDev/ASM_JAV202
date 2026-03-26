<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>

<head>

<title>Home</title>

<script src="https://cdn.tailwindcss.com"></script>

<script>
tailwind.config = {
    theme: {
        extend: {
            colors: {
                cafe: {
                    bg: '#f6efe7',
                    brown: '#8b5e3c'
                }
            }
        }
    }
}
</script>

</head>

<body class="bg-cafe-bg">

<div class="flex">

<!-- SIDEBAR -->
<jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

<!-- RIGHT SIDE -->
<div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

<!-- HEADER -->
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- CONTENT -->
<div class="p-8">

<div class="max-w-[1400px] mx-auto grid grid-cols-2 gap-6">

<!-- SLIDESHOW -->
<div class="col-span-2 relative rounded-2xl overflow-hidden shadow-lg">

    <div id="slides" class="flex transition-transform duration-700 ">

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

<!-- BOX 1 -->
<div class="bg-gradient-to-br from-white to-[#f1e4d7] rounded-xl shadow-md p-6 flex flex-col justify-center">

<div class="text-gray-500 text-sm mb-2">
Số bàn đang có khách
</div>

<div class="text-3xl font-bold text-gray-800">
0
</div>

</div>


<!-- BOX 2 -->
<div class="bg-white border border-gray-200 rounded-xl shadow-sm">

<div class="flex justify-end gap-3 p-4">

<button class="bg-cafe-brown text-white px-5 py-1 rounded-full text-sm hover:opacity-90 transition">
Tìm kiếm
</button>

<button class="bg-gray-700 text-white px-5 py-1 rounded-full text-sm hover:opacity-90 transition">
Bộ lọc
</button>

</div>

<table class="w-full text-center text-sm">

<thead class="bg-[#f1e4d7] text-gray-700">
<tr>
<th class="p-3">Tên</th>
<th>Ngày tháng</th>
<th>Chi tiết</th>
</tr>
</thead>

<tbody>

<tr class="border-t hover:bg-gray-50">
<td class="p-3">--</td>
<td>--</td>
<td>--</td>
</tr>

<tr class="border-t hover:bg-gray-50">
<td class="p-3">--</td>
<td>--</td>
<td>--</td>
</tr>

</tbody>

</table>

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

    // chạy lần đầu
    showSlide(0);

    // auto chạy
    setInterval(nextSlide, 3000);

});
</script>

</body>

</html>