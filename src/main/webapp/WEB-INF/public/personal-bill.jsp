<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<title>Lịch sử hóa đơn</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- BG -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

<!-- SIDEBAR -->
<jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

<!-- MAIN -->
<div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="p-8">

<div class="max-w-[1400px] mx-auto">

<!-- TITLE -->
<div class="flex justify-between items-center mb-6">
    <h1 class="text-2xl font-bold text-[#27301B]">
        Lịch sử hóa đơn của tôi
    </h1>
</div>

<!-- FILTER -->
<form method="get"
      action="${pageContext.request.contextPath}/personal-bill"
      class="mb-6 flex gap-3 flex-wrap">

<input type="text" name="keyword"
       value="${keyword}"
       placeholder="Tìm theo mã hóa đơn..."
       class="rounded-lg px-4 py-2 border backdrop-blur-xl w-64"
       style="background:rgba(255,255,255,0.4); border-color:#909632;">

<select name="status"
        class="rounded-lg px-4 py-2 border backdrop-blur-xl"
        style="background:rgba(255,255,255,0.4); border-color:#909632;">
    <option value="">Tất cả trạng thái</option>
    <option value="waiting" ${status == 'waiting' ? 'selected' : ''}>Đang chờ</option>
    <option value="pending_verify" ${status == 'pending_verify' ? 'selected' : ''}>Chờ xác nhận</option>
    <option value="finish" ${status == 'finish' ? 'selected' : ''}>Hoàn thành</option>
    <option value="cancel" ${status == 'cancel' ? 'selected' : ''}>Đã hủy</option>
</select>

<input type="date" name="fromDate" value="${fromDate}"
       class="rounded-lg px-4 py-2 border backdrop-blur-xl"
       style="background:rgba(255,255,255,0.4); border-color:#909632;">

<input type="date" name="toDate" value="${toDate}"
       class="rounded-lg px-4 py-2 border backdrop-blur-xl"
       style="background:rgba(255,255,255,0.4); border-color:#909632;">

<button class="text-white px-5 py-2 rounded-lg shadow hover:scale-105 transition"
        style="background:#41521E;">
    Lọc
</button>

</form>

<!-- COUNT -->
<p class="mb-4 text-[#27301B]">
    Tổng hóa đơn: <b>${billList.size()}</b>
</p>

<!-- TABLE -->
<div class="rounded-2xl shadow-xl overflow-hidden backdrop-blur-xl"
     style="background:rgba(255,255,255,0.35);">

<table class="w-full text-sm text-center">

<thead style="background:linear-gradient(135deg,#dfe6c3,#cfd5a5);" class="text-[#27301B]">
<tr>
<th class="p-3">Mã</th>
<th>Bàn</th>
<th>Loại</th>
<th>Tổng tiền</th>
<th>Trạng thái</th>
<th>Ngày tạo</th>
<th>Chi tiết</th>
</tr>
</thead>

<tbody>

<c:forEach var="b" items="${billList}">
<tr class="border-t border-white/40 hover:bg-white/20 transition">

<td class="p-3 font-medium">#${b.id}</td>

<td>
<c:choose>
<c:when test="${b.type == 'online' || b.tableId <= 0}">
Online
</c:when>
<c:otherwise>Bàn ${b.tableId}</c:otherwise>
</c:choose>
</td>

<td>
<c:choose>
<c:when test="${b.type == 'online'}">Online</c:when>
<c:when test="${b.type == 'pos'}">Tại quầy</c:when>
<c:otherwise>${b.type}</c:otherwise>
</c:choose>
</td>

<td class="text-[#41521E] font-medium">
${b.total} đ
</td>

<td>
<c:choose>
<c:when test="${b.status == 'waiting'}">
<span class="text-blue-600 font-semibold">Đang chờ</span>
</c:when>
<c:when test="${b.status == 'pending_verify'}">
<span class="text-amber-600 font-semibold">Chờ xác nhận</span>
</c:when>
<c:when test="${b.status == 'finish'}">
<span class="text-green-600 font-semibold">Hoàn thành</span>
</c:when>
<c:when test="${b.status == 'cancel'}">
<span class="text-red-500 font-semibold">Đã hủy</span>
</c:when>
<c:otherwise>
<span class="text-gray-600 font-semibold">${b.status}</span>
</c:otherwise>
</c:choose>
</td>

<td>${b.createdAt}</td>

<td>
<a href="${pageContext.request.contextPath}/personal-bill/detail?id=${b.id}"
   class="text-white px-3 py-1 rounded-lg shadow hover:scale-105 transition"
   style="background:#27301B;">
Xem
</a>
</td>

</tr>
</c:forEach>

<c:if test="${empty billList}">
<tr>
<td colspan="7" class="p-6 text-gray-500">
Không có hóa đơn phù hợp
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