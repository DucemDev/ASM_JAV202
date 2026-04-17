<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đơn online</title>

<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- BG -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

<jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

<div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

<jsp:include page="/WEB-INF/public/layout/header.jsp"/>

<div class="p-8">

<div class="max-w-[1300px] mx-auto">

<!-- TITLE -->
<div class="mb-6">
    <h1 class="text-2xl font-bold text-[#27301B]">
        Đơn hàng online chờ xác nhận
    </h1>
    <p class="text-gray-600 mt-1">
        Nhân viên/Admin theo dõi và xác nhận đơn online tại đây
    </p>
</div>

<!-- CALCULATE -->
<c:set var="pendingCount" value="0"/>
<c:set var="pendingTotal" value="0"/>
<c:forEach var="o" items="${orders}">
    <c:set var="pendingCount" value="${pendingCount + 1}"/>
    <c:set var="pendingTotal" value="${pendingTotal + o.total}"/>
</c:forEach>

<!-- STATS -->
<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">

<div class="rounded-2xl p-5 shadow-xl backdrop-blur-xl"
     style="background:rgba(255,255,255,0.35);">
    <p class="text-sm text-[#909632]">Số đơn chờ xác nhận</p>
    <p class="text-3xl font-bold text-[#27301B] mt-1">
        ${pendingCount}
    </p>
</div>

<div class="rounded-2xl p-5 shadow-xl backdrop-blur-xl"
     style="background:rgba(255,255,255,0.35);">
    <p class="text-sm text-[#909632]">Tổng tiền đơn chờ</p>
    <p class="text-3xl font-bold text-[#27301B] mt-1">
        ${pendingTotal} đ
    </p>
</div>

</div>

<!-- TABLE -->
<div class="rounded-2xl shadow-2xl overflow-hidden backdrop-blur-xl"
     style="background:rgba(255,255,255,0.35);">

<table class="w-full text-sm text-center">

<thead style="background:linear-gradient(135deg,#dfe6c3,#cfd5a5);" class="text-[#27301B]">
<tr>
<th class="p-3">Mã Bill</th>
<th>User ID</th>
<th>Loại đơn</th>
<th>Thời gian tạo</th>
<th>Tổng tiền</th>
<th>Trạng thái</th>
<th class="w-[240px]">Hành động</th>
</tr>
</thead>

<tbody>

<c:forEach var="o" items="${orders}">
<tr class="border-t border-white/40 hover:bg-white/20 transition">

<td class="p-3 font-semibold">${o.code}</td>

<td>${o.userId}</td>

<td class="uppercase">${o.type}</td>

<td>${o.createdAt}</td>

<td class="font-semibold text-[#41521E]">
${o.total} đ
</td>

<td>
<span class="px-3 py-1 rounded-full text-xs font-semibold"
      style="background:rgba(254,243,199,0.6); color:#b45309;">
    Chờ xác nhận
</span>
</td>

<td>
<div class="flex items-center justify-center gap-2 py-2">

<a href="${pageContext.request.contextPath}/seller/online-orders/detail?id=${o.id}"
   class="px-4 py-1 rounded-lg text-white hover:scale-105 transition"
   style="background:#41521E;">
    Xem
</a>

<form method="post"
      action="${pageContext.request.contextPath}/seller/online-orders/confirm">

<input type="hidden" name="billId" value="${o.id}" />

<button class="px-4 py-1 rounded-lg text-white hover:scale-105 transition"
        style="background:#27301B;">
    Xác nhận
</button>

</form>

</div>
</td>

</tr>
</c:forEach>

<c:if test="${empty orders}">
<tr>
<td colspan="7" class="p-6 text-gray-500">
Hiện chưa có đơn online nào đang chờ xác nhận
</td>
</tr>
</c:if>

</tbody>

</table>

</div>

</div>

</div>

</div>

</div>

</body>
</html>
