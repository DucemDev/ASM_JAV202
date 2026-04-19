<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Hóa đơn</title>

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

<div class="max-w-[600px] mx-auto">

<!-- CARD -->
<div class="rounded-2xl shadow-2xl p-6 border backdrop-blur-xl"
     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

<!-- HEADER BILL -->
<div class="text-center border-b pb-4 mb-5">
    <h2 class="text-xl font-bold text-[#27301B] tracking-wide">
         Cafe POS
    </h2>
    <p class="text-xs text-gray-500">Hóa đơn thanh toán</p>
</div>

<!-- INFO -->
<div class="text-sm mb-5 space-y-1 text-[#27301B]">
    <p>Mã hóa đơn: <b>${bill.code}</b></p>
    <p>Bàn: <b>${bill.tableId}</b></p>
    <p>Thời gian:
        <b>
            <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
                .format(new java.util.Date()) %>
        </b>
    </p>
</div>

<!-- TABLE -->
<div class="rounded-xl overflow-hidden border"
     style="border-color:rgba(255,255,255,0.4);">

<table class="w-full text-sm">

<thead style="background:linear-gradient(135deg,#dfe6c3,#cfd5a5);" class="text-[#27301B]">
<tr>
    <th class="p-3 text-left">Món</th>
    <th class="text-center">SL</th>
    <th class="text-right pr-3">Giá</th>
</tr>
</thead>

<tbody>

<c:forEach var="item" items="${billDetails}">
<tr class="border-t border-white/40 hover:bg-white/20 transition">

<td class="p-3 font-medium">
<c:forEach var="d" items="${drinks}">
    <c:if test="${d.id == item.drinkId}">
        ${d.name}
    </c:if>
</c:forEach>
</td>

<td class="text-center">${item.quantity}</td>

<td class="text-right pr-3 text-[#41521E] font-medium">
    ${String.format("%,d", item.price).replace(",", ".")} đ
</td>

</tr>
</c:forEach>

<c:if test="${empty billDetails}">
<tr>
    <td colspan="3" class="text-center p-4 text-gray-500">
        Chưa có món nào
    </td>
</tr>
</c:if>

</tbody>

</table>

</div>

<!-- TOTAL -->
<div class="flex justify-between items-center mt-5 border-t pt-4">
    <span class="text-sm text-gray-600">Tổng thanh toán</span>
    <span class="text-xl font-bold text-[#27301B]">
    ${String.format("%,d", total).replace(",", ".")} đ
</span>
</div>

<!-- FOOTER -->
<div class="text-center text-xs text-gray-500 mt-6 mb-4">
    Cảm ơn quý khách ❤️ Hẹn gặp lại!
</div>

<!-- BUTTON -->
<a href="${pageContext.request.contextPath}/seller/tables"
   class="block text-center text-white py-2 rounded-lg shadow hover:scale-105 transition"
   style="background:#27301B;">
    Quay lại danh sách bàn
</a>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>
