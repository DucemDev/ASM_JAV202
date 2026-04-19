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
<jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

<div id="mainContent" class="flex-1 flex flex-col ml-64">

<jsp:include page="/WEB-INF/public/layout/header.jsp"/>

<div class="p-8">

<div class="rounded-2xl shadow-2xl p-6 border backdrop-blur-xl max-w-[1400px] mx-auto"
     style="background:rgba(255,255,255,0.28); border:1px solid rgba(255,255,255,0.3);">

<!-- HEADER -->
<div class="flex justify-between items-center mb-6">
    <a href="${pageContext.request.contextPath}/seller/tables"
       class="text-[#41521E] hover:underline text-sm">
        ← Quay lại bàn
    </a>

    <h2 class="text-xl font-semibold text-[#27301B]">HÓA ĐƠN</h2>
</div>

<!-- ERROR -->
<c:if test="${param.error == 'empty'}">
    <div class="bg-red-100 text-red-600 p-3 rounded mb-4 text-sm">
        ⚠️ Chưa chọn món, không thể thanh toán!
    </div>
</c:if>

<!-- INFO -->
<div class="mb-6 text-sm text-[#27301B]">
    <p>Mã hóa đơn: <b>${bill.code}</b></p>
    <p>Bàn: <b>${tableId}</b></p>
</div>

<div class="grid grid-cols-2 gap-6">

<!-- MENU -->
<div>
    <h3 class="font-semibold mb-3 text-[#27301B]">Menu</h3>

    <form method="get"
          action="${pageContext.request.contextPath}/seller/order"
          class="grid grid-cols-1 md:grid-cols-3 gap-3 mb-4">

        <input type="hidden" name="tableId" value="${tableId}">

        <input type="text"
               name="keyword"
               value="${keyword}"
               placeholder="Tìm món..."
               class="rounded-lg px-4 py-2 border backdrop-blur-xl"
               style="background:rgba(255,255,255,0.35); border-color:#909632;">

        <select name="categoryId"
                class="rounded-lg px-4 py-2 border backdrop-blur-xl"
                style="background:rgba(255,255,255,0.35); border-color:#909632;">
            <option value="">Tất cả loại</option>
            <c:forEach items="${categories}" var="c">
                <option value="${c.id}" ${filterCategoryId == c.id ? 'selected' : ''}>${c.name}</option>
            </c:forEach>
        </select>

        <button class="text-white px-5 py-2 rounded-lg"
                style="background:#41521E;">
            Tìm kiếm
        </button>
    </form>

    <div class="grid grid-cols-2 gap-4">

        <c:forEach var="d" items="${drinks}">
            <div class="rounded-xl shadow border backdrop-blur-xl"
                 style="background:rgba(255,255,255,0.3);">

                <img src="${pageContext.request.contextPath}/${d.image}"
                     class="w-full h-36 object-cover rounded-t-xl"/>

                <div class="p-3">
                    <p class="font-medium text-[#27301B]">${d.name}</p>
                    <p class="text-sm text-[#41521E]">${String.format("%,d", d.price)} đ</p>

                    <button
                        onclick="addDrink(${d.id}, ${tableId})"
                        class="w-full text-white py-1 mt-2 rounded"
                        style="background:#27301B;">
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
                   class="px-3 py-2 rounded-lg border"
                   style="${pageNumber == currentPage ? 'background:#27301B;color:white;border-color:#27301B;' : 'background:white;border-color:#ccc;'}">
                    ${pageNumber}
                </a>
            </c:forEach>
        </div>
    </c:if>
</div>

<!-- BILL -->
<div id="bill-area">

    <h3 class="font-semibold mb-4 text-[#27301B] text-lg">
        Chi tiết hóa đơn
    </h3>

    <div class="rounded-2xl overflow-hidden backdrop-blur-xl border shadow-xl"
         style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

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

                    <td class="p-3 text-left font-medium text-[#27301B]">
                        <c:forEach var="d" items="${drinks}">
                            <c:if test="${d.id == item.drinkId}">
                                ${d.name}
                            </c:if>
                        </c:forEach>
                    </td>

                    <td>
                        <div class="flex items-center justify-center gap-2">
                            <button onclick="updateQty(${bill.id}, ${item.drinkId}, ${item.quantity - 1})"
                                class="px-2 py-1 rounded bg-gray-200 hover:bg-gray-300">-</button>

                            <span class="font-semibold">${item.quantity}</span>

                            <button onclick="updateQty(${bill.id}, ${item.drinkId}, ${item.quantity + 1})"
                                class="px-2 py-1 rounded bg-gray-200 hover:bg-gray-300">+</button>
                        </div>
                    </td>

                    <td class="text-[#41521E] font-medium">
    ${String.format("%,d", item.price).replace(",", ".")} đ
</td>
                </tr>
            </c:forEach>

            <c:if test="${empty billDetails}">
                <tr>
                    <td colspan="3" class="p-4 text-gray-500">Chưa có món nào</td>
                </tr>
            </c:if>

            </tbody>
        </table>
    </div>

    <div class="mt-5 flex justify-between items-center">
        <span class="text-sm text-gray-600">Tổng thanh toán</span>
        <span class="text-xl font-bold text-[#27301B]">
    ${String.format("%,d", total).replace(",", ".")} đ
</span>
    </div>

    <div class="flex gap-2 mt-4">

        <form method="post"
              action="${pageContext.request.contextPath}/seller/order/cancel"
              class="w-1/2"
              onsubmit="event.preventDefault(); openModal(this, 'Bạn chắc chắn muốn hủy bàn?')">

            <input type="hidden" name="tableId" value="${tableId}" />

            <button class="w-full bg-red-500 text-white py-2 rounded">
                Hủy bàn
            </button>
        </form>

        <form method="post"
              action="${pageContext.request.contextPath}/seller/order/pay"
              class="w-1/2"
              onsubmit="event.preventDefault(); openModal(this, 'Xác nhận thanh toán?')">

            <input type="hidden" name="billId" value="${bill.id}"/>
            <input type="hidden" name="tableId" value="${tableId}"/>

            <button
                class="w-full bg-blue-500 text-white py-2 rounded
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

<!-- SCRIPT GIỮ NGUYÊN -->
<script>
function addDrink(drinkId, tableId) {
    fetch("${pageContext.request.contextPath}/seller/order", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "drinkId=" + drinkId + "&tableId=" + tableId
    }).then(() => loadBill(tableId));
}

function updateQty(billId, drinkId, quantity) {
    fetch("${pageContext.request.contextPath}/seller/order", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "action=update"
            + "&billId=" + billId
            + "&drinkId=" + drinkId
            + "&quantity=" + quantity
            + "&tableId=${tableId}"
    }).then(() => loadBill(${tableId}));
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

<!-- MODAL -->
<div id="confirmModal" class="fixed inset-0 bg-black/40 hidden items-center justify-center z-50">
    <div class="rounded-xl p-6 w-[350px] text-center shadow-lg backdrop-blur-xl"
         style="background:rgba(255,255,255,0.4);">
        <h3 class="text-lg font-semibold mb-4">Xác nhận</h3>
        <p id="modalMessage" class="text-sm text-gray-600 mb-6"></p>

        <div class="flex gap-2">
            <button onclick="closeModal()" class="w-1/2 bg-gray-300 py-2 rounded">Hủy</button>
            <button id="confirmBtn" class="w-1/2 text-white py-2 rounded" style="background:#27301B;">Đồng ý</button>
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
