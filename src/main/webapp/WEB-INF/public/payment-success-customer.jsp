<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đặt hàng thành công</title>

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
<jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

<!-- MAIN -->
<div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

<jsp:include page="/WEB-INF/public/layout/header.jsp"/>

<div class="p-8">

<div class="max-w-[600px] mx-auto">

<div class="rounded-2xl shadow-2xl p-6 backdrop-blur-xl border"
     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

<!-- HEADER -->
<div class="text-center border-b pb-4 mb-4">
    <h2 class="text-xl font-bold text-green-600">
        ✅ Đặt hàng thành công
    </h2>
    <p class="text-xs text-gray-500">
        Cảm ơn bạn đã đặt hàng
    </p>
</div>

<!-- INFO -->
<div class="text-sm mb-4 space-y-1 text-[#27301B]">
    <p>Mã đơn: <b>${bill.code}</b></p>
    <p>Loại: <b>Đơn online</b></p>
    <p>Thời gian:
        <b>
            <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
                    .format(new java.util.Date()) %>
        </b>
    </p>
</div>

<!-- TABLE -->
<div class="rounded-xl overflow-hidden border"
     style="background:rgba(255,255,255,0.4);">

<table class="w-full text-sm text-center">

<thead style="background:linear-gradient(135deg,#dfe6c3,#cfd5a5);" class="text-[#27301B]">
<tr>
<th class="p-3 text-left">Món</th>
<th>Số lượng</th>
<th class="text-right pr-3">Giá</th>
</tr>
</thead>

<tbody>

<c:forEach var="item" items="${billDetails}">
<tr class="border-t border-white/40 hover:bg-white/20 transition">

<td class="p-3 text-left font-medium">
<c:forEach var="d" items="${drinks}">
    <c:if test="${d.id == item.drinkId}">
        ${d.name}
    </c:if>
</c:forEach>
</td>

<td>${item.quantity}</td>

<td class="text-right pr-3 text-[#41521E]">
${item.price} đ
</td>

</tr>
</c:forEach>

</tbody>

</table>

</div>

<!-- TOTAL -->
<div class="text-right text-lg font-bold mt-4 text-[#27301B]">
Tổng: ${total} đ
</div>

<!-- FOOTER -->
<div class="text-center text-sm text-gray-500 mt-4">
Đơn hàng của bạn đang được xử lý ☕
</div>

<!-- BUTTON -->
<div class="mt-6">
<a href="${pageContext.request.contextPath}/customer/order"
   class="block text-center text-white py-2 rounded-xl shadow hover:scale-105 transition"
   style="background:#27301B;">
    Đặt thêm
</a>
</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>
