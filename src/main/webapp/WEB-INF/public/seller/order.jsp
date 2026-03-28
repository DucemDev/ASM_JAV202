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

    <!-- SIDEBAR -->
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <!-- MAIN -->
    <div class="flex-1 ml-64">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">

            <div class="bg-white rounded-2xl shadow-lg p-6 border max-w-[1400px] mx-auto">

                <h2 class="text-xl font-semibold mb-6">HÓA ĐƠN</h2>

                <!-- INFO -->
                <div class="mb-6 text-sm">
                    <p>Mã bill: <b>${bill.code}</b></p>
                    <p>Bàn: <b>${bill.tableId}</b></p>
                    <p>Trạng thái:
                        <span class="bg-yellow-200 px-2 py-1 rounded text-xs">
                            ${bill.status}
                        </span>
                    </p>
                </div>

                <div class="grid grid-cols-2 gap-6">

                    <!-- MENU -->
                    <div>
                        <h3 class="font-semibold mb-3">Menu</h3>

                        <div class="grid grid-cols-2 gap-4">
                            <c:forEach var="d" items="${drinks}">
                                <div class="border rounded-xl p-3 hover:shadow">

                                    <p class="font-medium">${d.name}</p>
                                    <p class="text-gray-500 text-sm mb-2">${d.price} đ</p>

                                    <!-- FIX tableId -->
                                    <button
                                        onclick="addDrink(${bill.id}, ${d.id}, ${bill.tableId})"
                                        class="w-full bg-cafe-brown text-white py-1 rounded hover:opacity-90">
                                        Thêm
                                    </button>

                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- BILL DETAIL -->
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
                                    <tr class="border-t hover:bg-gray-50">

                                        <!-- 🔥 FIX HIỆN TÊN -->
                                        <td>
                                            <c:forEach var="d" items="${drinks}">
                                                <c:if test="${d.id == item.drinkId}">
                                                    ${d.name}
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                        <td>${item.quantity}</td>
                                        <td>${item.price} đ</td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>

                        <div class="mt-4 text-right font-semibold text-lg">
                            Tổng: ${total} đ
                        </div>

                        <!-- 🔥 FIX NÚT THANH TOÁN -->
                     <form method="post"
                           action="${pageContext.request.contextPath}/seller/order/pay">

                         <input type="hidden" name="billId" value="${bill.id}" />

                         <button class="mt-3 w-full bg-blue-500 text-white py-2 rounded">
                             Thanh toán
                         </button>
                     </form>

                    </div>

                </div>

                <a href="${pageContext.request.contextPath}/seller/tables"
                   class="inline-block mt-6 text-blue-500 hover:underline">
                    ← Quay lại bàn
                </a>

            </div>

        </div>

    </div>

</div>

<!-- ================= JS ================= -->
<script>

function addDrink(billId, drinkId, tableId) {

    if (!billId || !drinkId || !tableId) {
        alert("Thiếu param!");
        return;
    }

    fetch("${pageContext.request.contextPath}/seller/order", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "billId=" + billId + "&drinkId=" + drinkId + "&tableId=" + tableId
    })
    .then(() => {
        loadBill(tableId);
    });
}

function loadBill(tableId) {

    fetch("${pageContext.request.contextPath}/seller/order?tableId=" + tableId)
        .then(res => res.text())
        .then(html => {

            let parser = new DOMParser();
            let doc = parser.parseFromString(html, "text/html");

            let newBill = doc.querySelector("#bill-area");

            if (newBill) {
                document.querySelector("#bill-area").innerHTML = newBill.innerHTML;
            }
        });
}

</script>

</body>
</html>