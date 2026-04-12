<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Order</title>

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
<jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

<div id="mainContent" class="flex-1 flex flex-col ml-64">s

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="p-8">

<div class="bg-white rounded-2xl shadow-lg p-6 border max-w-[1400px] mx-auto">

<!-- HEADER -->
<div class="flex justify-between items-center mb-6">
    <a href="${pageContext.request.contextPath}/seller/tables"
       class="text-blue-500 hover:underline text-sm">
        ← Quay lại bàn
    </a>

    <h2 class="text-xl font-semibold">HÓA ĐƠN</h2>
</div>

<!-- ERROR -->
<c:if test="${param.error == 'empty'}">
    <div class="bg-red-100 text-red-600 p-3 rounded mb-4 text-sm">
        ⚠️ Chưa chọn món, không thể thanh toán!
    </div>
</c:if>

<!-- INFO -->
<div class="mb-6 text-sm">
    <p>Mã bill: <b>${bill.code}</b></p>
    <p>Bàn: <b>${tableId}</b></p>
</div>

<div class="grid grid-cols-2 gap-6">

<!-- MENU -->
<div>
    <h3 class="font-semibold mb-3">Menu</h3>

    <form method="get"
          action="${pageContext.request.contextPath}/seller/order"
          class="grid grid-cols-1 md:grid-cols-3 gap-3 mb-4">
        <input type="hidden" name="tableId" value="${tableId}">
        <input type="text"
               name="keyword"
               value="${keyword}"
               placeholder="Tim mon..."
               class="border rounded-lg px-4 py-2">

        <select name="categoryId" class="border rounded-lg px-4 py-2">
            <option value="">Tat ca loai</option>
            <c:forEach items="${categories}" var="c">
                <option value="${c.id}" ${filterCategoryId == c.id ? 'selected' : ''}>${c.name}</option>
            </c:forEach>
        </select>

        <button class="bg-gray-700 text-white px-5 py-2 rounded-lg hover:opacity-90">
            Tim kiem
        </button>
    </form>

    <div class="grid grid-cols-2 gap-4">

        <c:forEach var="d" items="${drinks}">
            <div class="border rounded-xl shadow hover:shadow-lg transition">

                <img src="${pageContext.request.contextPath}/${d.image}"
                     class="w-full h-36 object-cover"/>

                <div class="p-3">
                    <p class="font-medium">${d.name}</p>
                    <p class="text-sm text-gray-500">${d.price} đ</p>

                    <button
                        onclick="addDrink(${d.id}, ${tableId})"
                        class="w-full bg-cafe-brown text-white py-1 mt-2 rounded hover:scale-105 transition">
                        + Thêm
                    </button>
                </div>

            </div>
        </c:forEach>

    </div>

    <c:if test="${totalPages > 1}">
        <div class="flex justify-center gap-2 mt-6">
            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                <a href="${pageContext.request.contextPath}/seller/order?tableId=${tableId}&page=${pageNumber}&keyword=${keyword}&categoryId=${filterCategoryId}"
                   class="px-3 py-2 rounded-lg border ${pageNumber == currentPage ? 'bg-cafe-brown text-white border-cafe-brown' : 'bg-white text-gray-700 border-gray-300 hover:bg-gray-50'}">
                    ${pageNumber}
                </a>
            </c:forEach>
        </div>
    </c:if>
</div>

<!-- BILL -->
<div id="bill-area">

    <h3 class="font-semibold mb-3">Chi tiết hóa đơn</h3>

    <table class="w-full text-sm border rounded-xl overflow-hidden">
        <thead class="bg-[#f1e4d7]">
            <tr>
                <th class="p-2">Món</th>
                <th>Số lượng</th>
                <th>Giá</th>
            </tr>
        </thead>

        <tbody class="text-center">

            <c:forEach var="item" items="${billDetails}">
                <tr class="border-t">
                    <td>
                        <c:forEach var="d" items="${drinks}">
                            <c:if test="${d.id == item.drinkId}">
                                ${d.name}
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <div class="flex items-center justify-center gap-2">

                            <!-- - -->
                            <button onclick="updateQty(${bill.id}, ${item.drinkId}, ${item.quantity - 1})"
                                class="bg-gray-300 px-2 rounded hover:bg-gray-400">
                                -
                            </button>

                            <span>${item.quantity}</span>

                            <!-- + -->
                            <button onclick="updateQty(${bill.id}, ${item.drinkId}, ${item.quantity + 1})"
                                class="bg-gray-300 px-2 rounded hover:bg-gray-400">
                                +
                            </button>

                        </div>
                    </td>
                    <td>${item.price} đ</td>
                </tr>
            </c:forEach>

        </tbody>
    </table>

    <div class="mt-4 text-right font-semibold text-lg">
        Tổng: ${total} đ
    </div>

    <!-- BUTTON -->
    <div class="flex gap-2 mt-4">

        <!-- HỦY -->
        <form method="post"
              action="${pageContext.request.contextPath}/seller/order/cancel"
              class="w-1/2"
              onsubmit="event.preventDefault(); openModal(this, 'Bạn chắc chắn muốn HỦY bàn?')">

            <input type="hidden" name="tableId" value="${tableId}" />

            <button class="w-full bg-red-500 text-white py-2 rounded hover:opacity-90">
                Hủy bàn
            </button>
        </form>

        <!-- THANH TOÁN -->
        <form method="post"
              action="${pageContext.request.contextPath}/seller/order/pay"
              class="w-1/2"
              onsubmit="event.preventDefault(); openModal(this, 'Xác nhận thanh toán?')">

            <input type="hidden" name="billId" value="${bill.id}"/>
            <input type="hidden" name="tableId" value="${tableId}"/>

            <button
                class="w-full bg-blue-500 text-white py-2 rounded hover:opacity-90
                ${empty billDetails ? 'opacity-50 cursor-not-allowed' : ''}"
                ${empty billDetails ? 'disabled' : ''}>
                Thanh toán
            </button>
        </form>

    </div>

</div>

</div>

</div>

</div>

</div>

</div>

<script>
function addDrink(drinkId, tableId) {

    fetch("${pageContext.request.contextPath}/seller/order", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "drinkId=" + drinkId + "&tableId=" + tableId
    })
    .then(() => {
        loadBill(tableId);
    });
}
function updateQty(billId, drinkId, quantity) {

    fetch("${pageContext.request.contextPath}/seller/order", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "action=update"
            + "&billId=" + billId
            + "&drinkId=" + drinkId
            + "&quantity=" + quantity
            + "&tableId=${tableId}"   // 🔥 THÊM DÒNG NÀY
    })
    .then(() => loadBill(${tableId}));
}
function loadBill(tableId) {

    fetch("${pageContext.request.contextPath}/seller/order?tableId=" + tableId)
        .then(res => res.text())
        .then(html => {

            let parser = new DOMParser();
            let doc = parser.parseFromString(html, "text/html");

            let newBill = doc.querySelector("#bill-area");

            document.querySelector("#bill-area").innerHTML = newBill.innerHTML;
        });
}
</script>
<div id="confirmModal" class="fixed inset-0 bg-black/40 hidden items-center justify-center z-50">

    <div class="bg-white rounded-xl p-6 w-[350px] text-center shadow-lg">

        <h3 id="modalTitle" class="text-lg font-semibold mb-4">Xác nhận</h3>

        <p id="modalMessage" class="text-sm text-gray-600 mb-6"></p>

        <div class="flex gap-2">
            <button onclick="closeModal()"
                    class="w-1/2 bg-gray-300 py-2 rounded">
                Hủy
            </button>

            <button id="confirmBtn"
                    class="w-1/2 bg-blue-500 text-white py-2 rounded">
                OK
            </button>
        </div>

    </div>
</div>
<script>
let currentForm = null;

function openModal(form, message) {
    currentForm = form;
    document.getElementById("modalMessage").innerText = message;
    document.getElementById("confirmModal").classList.remove("hidden");
    document.getElementById("confirmModal").classList.add("flex");
}

function closeModal() {
    document.getElementById("confirmModal").classList.add("hidden");
}

document.getElementById("confirmBtn").onclick = function () {
    if (currentForm) currentForm.submit();
};
</script>
</body>
</html>
