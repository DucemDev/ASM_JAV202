<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Hóa đơn</title>

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

<!-- MAIN (CHUẨN GIỐNG HOME → KHÔNG LỆCH) -->
<div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

<!-- HEADER -->
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- CONTENT -->
<div class="p-8">

<div class="max-w-[600px] mx-auto">

<div class="bg-white rounded-2xl shadow-lg p-6 border">

<!-- HEADER BILL -->
<div class="text-center border-b pb-4 mb-4">
    <h2 class="text-xl font-bold">☕ Cafe POS</h2>
    <p class="text-xs text-gray-400">Hóa đơn thanh toán</p>
</div>

<!-- INFO -->
<div class="text-sm mb-4 space-y-1">
    <p>Mã bill: <b>${bill.code}</b></p>
    <p>Bàn: <b>${bill.tableId}</b></p>
    <p>Thời gian:
        <b>
            <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
                .format(new java.util.Date()) %>
        </b>
    </p>
</div>

<!-- TABLE -->
<table class="w-full text-sm border-t border-b mb-4">
<thead>
<tr class="text-left">
    <th>Món</th>
    <th>SL</th>
    <th class="text-right">Giá</th>
</tr>
</thead>

<tbody>

<c:forEach var="item" items="${billDetails}">
<tr>

<td>
<c:forEach var="d" items="${drinks}">
    <c:if test="${d.id == item.drinkId}">
        ${d.name}
    </c:if>
</c:forEach>
</td>

<td>${item.quantity}</td>

<td class="text-right">${item.price} đ</td>

</tr>
</c:forEach>

</tbody>
</table>

<!-- TOTAL -->
<div class="text-right text-lg font-bold mb-4">
    Tổng: ${total} đ
</div>

<!-- FOOTER -->
<div class="text-center text-xs text-gray-400 mb-4">
    Cảm ơn quý khách ❤️ Hẹn gặp lại!
</div>

<!-- BUTTON -->
<a href="${pageContext.request.contextPath}/seller/tables"
   class="block text-center bg-blue-500 text-white py-2 rounded hover:opacity-90">
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