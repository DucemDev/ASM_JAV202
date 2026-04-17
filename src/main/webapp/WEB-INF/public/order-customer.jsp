<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đặt hàng online</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

<!-- SIDEBAR -->
<jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

<!-- MAIN -->
<div id="mainContent"
     class="flex-1 flex flex-col ml-64 transition-all duration-300">

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="p-8">

<div class="rounded-2xl shadow-2xl p-6 backdrop-blur-xl max-w-[1400px] mx-auto"
     style="background:rgba(255,255,255,0.35);">

<h2 class="text-xl font-semibold text-[#27301B] mb-6">
    ĐẶT HÀNG ONLINE
</h2>

<div class="grid grid-cols-2 gap-6">

<!-- MENU -->
<div>
    <h3 class="font-semibold mb-3 text-[#27301B]">Menu</h3>

    <div class="grid grid-cols-2 gap-4">
        <c:forEach var="d" items="${drinks}">
            <div class="rounded-xl shadow border backdrop-blur-xl hover:shadow-xl transition"
                 style="background:rgba(255,255,255,0.3);">

                <img src="${pageContext.request.contextPath}/${d.image}"
                     class="w-full h-36 object-cover rounded-t-xl"/>

                <div class="p-3">
                    <p class="font-medium text-[#27301B]">${d.name}</p>
                    <p class="text-sm text-[#41521E]">${d.price} đ</p>

                    <button onclick="addDrink(${d.id})"
                            class="w-full text-white py-1 mt-2 rounded"
                            style="background:#27301B;">
                        + Thêm
                    </button>
                </div>

            </div>
        </c:forEach>
    </div>
</div>

<!-- CART -->
<div id="bill-area">

<h3 class="font-semibold mb-3 text-[#27301B] text-lg">
    Giỏ hàng
</h3>

<div class="rounded-2xl backdrop-blur-xl shadow-xl overflow-hidden"
     style="background:rgba(255,255,255,0.35);">

<table class="w-full text-sm text-center">

<thead style="background:linear-gradient(135deg,#dfe6c3,#cfd5a5);" class="text-[#27301B]">
<tr>
    <th class="p-3 text-left">Món</th>
    <th>Số lượng</th>
    <th>Giá</th>
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

<td>
<div class="flex justify-center gap-2">

<button onclick="updateQty(${bill.id}, ${item.drinkId}, ${item.quantity - 1})"
        class="w-7 h-7 bg-gray-200 rounded">-</button>

<span class="font-semibold">${item.quantity}</span>

<button onclick="updateQty(${bill.id}, ${item.drinkId}, ${item.quantity + 1})"
        class="w-7 h-7 bg-gray-200 rounded">+</button>

</div>
</td>

<td class="text-[#41521E] font-medium">
${item.price} đ
</td>

</tr>
</c:forEach>

<c:if test="${empty billDetails}">
<tr>
<td colspan="3" class="p-4 text-gray-500">
Chưa có món
</td>
</tr>
</c:if>

</tbody>

</table>

<div class="flex justify-between items-center p-4 border-t">
<span>Tổng</span>
<span class="font-bold text-lg">${total} đ</span>
</div>

<form method="post"
      action="${pageContext.request.contextPath}/customer/order/pay">

<input type="hidden" name="billId" value="${bill.id}"/>

<button class="w-full text-white py-2"
        style="background:#27301B;">
Đặt hàng ngay
</button>

</form>

</div>

</div>

</div>

</div>

</div>

</div>
</div>

<!-- AJAX (GIỮ NGUYÊN) -->
<script>
function loadBill() {
    fetch("${pageContext.request.contextPath}/customer/order")
        .then(res => res.text())
        .then(html => {
            let doc = new DOMParser().parseFromString(html, "text/html");
            let newBill = doc.querySelector("#bill-area");
            document.querySelector("#bill-area").innerHTML = newBill.innerHTML;
        });
}

function addDrink(drinkId) {
    fetch("${pageContext.request.contextPath}/customer/order", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "drinkId=" + drinkId
    }).then(() => loadBill());
}

function updateQty(billId, drinkId, quantity) {
    fetch("${pageContext.request.contextPath}/customer/order", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body:
            "action=update"
            + "&billId=" + billId
            + "&drinkId=" + drinkId
            + "&quantity=" + quantity
    }).then(() => loadBill());
}
</script>

</body>
</html>