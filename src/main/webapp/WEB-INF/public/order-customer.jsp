<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng online</title>

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

    <div class="flex-1 flex flex-col ml-64">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">

            <div class="bg-white rounded-2xl shadow-lg p-6 border max-w-[1400px] mx-auto">

                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-semibold">ĐẶT HÀNG ONLINE</h2>
                </div>

                <div class="mb-6 text-sm">
                    <p>Mã bill: <b>${bill.code}</b></p>
                    <p>Loại: <b>ONLINE ORDER</b></p>
                </div>

                <div class="grid grid-cols-2 gap-6">

                    <!-- MENU -->
                    <div>
                        <h3 class="font-semibold mb-3">Menu</h3>

                        <div class="grid grid-cols-2 gap-4">
                            <c:forEach var="d" items="${drinks}">
                                <div class="border rounded-xl shadow hover:shadow-lg transition">

                                    <img src="${pageContext.request.contextPath}/${d.image}"
                                         class="w-full h-36 object-cover"/>

                                    <div class="p-3">
                                        <p class="font-medium">${d.name}</p>
                                        <p class="text-sm text-gray-500">${d.price} đ</p>

                                        <button
                                                onclick="addDrink(${d.id})"
                                                class="w-full bg-cafe-brown text-white py-1 mt-2 rounded hover:scale-105 transition">
                                            + Thêm
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- BILL -->
                    <div id="bill-area">

                        <h3 class="font-semibold mb-3">Giỏ hàng</h3>

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
                                            <button onclick="updateQty(${bill.id}, ${item.drinkId}, ${item.quantity - 1})"
                                                    class="bg-gray-300 px-2 rounded">-</button>

                                            <span>${item.quantity}</span>

                                            <button onclick="updateQty(${bill.id}, ${item.drinkId}, ${item.quantity + 1})"
                                                    class="bg-gray-300 px-2 rounded">+</button>
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

                        <form method="post"
                              action="${pageContext.request.contextPath}/customer/order/pay">
                            <input type="hidden" name="billId" value="${bill.id}"/>

                            <button class="w-full bg-blue-500 text-white py-2 rounded mt-4">
                                Đặt hàng ngay
                            </button>
                        </form>

                    </div>

                </div>

            </div>

        </div>
    </div>
</div>

<script>
    function addDrink(drinkId) {
        fetch("${pageContext.request.contextPath}/customer/order", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "drinkId=" + drinkId
        }).then(() => location.reload());
    }

    function updateQty(billId, drinkId, quantity) {
        fetch("${pageContext.request.contextPath}/customer/order", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body:
                "action=update"
                + "&billId=" + billId
                + "&drinkId=" + drinkId
                + "&quantity=" + quantity
        }).then(() => location.reload());
    }
</script>

</body>
</html>