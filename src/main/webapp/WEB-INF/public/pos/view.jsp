<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>POS</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#f6efe7] min-h-screen">
<div class="max-w-6xl mx-auto p-6">
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-semibold text-gray-800">POS</h1>
        <a href="${pageContext.request.contextPath}/staff" class="text-sm text-gray-600">Quay lại</a>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div class="bg-white rounded-xl shadow p-5">
            <h2 class="text-lg font-medium mb-4">Menu</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                <c:forEach var="drink" items="${drinks}">
                    <form method="post" action="${pageContext.request.contextPath}/employee/pos/add-item" class="border rounded-lg p-3">
                        <input type="hidden" name="billId" value="${bill != null ? bill.id : 0}">
                        <input type="hidden" name="drinkId" value="${drink.id}">
                        <div class="font-medium text-gray-800">${drink.name}</div>
                        <div class="text-sm text-gray-500 mb-3">${drink.price} đ</div>
                        <button class="w-full bg-[#8b5e3c] text-white rounded py-2">Thêm món</button>
                    </form>
                </c:forEach>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow p-5">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-lg font-medium">Hóa đơn hiện tại</h2>
                <c:if test="${bill != null}">
                    <span class="text-sm text-gray-500">${bill.code}</span>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${bill == null}">
                    <div class="text-gray-500">Chưa có hóa đơn. Hãy thêm món để tạo hóa đơn mới.</div>
                </c:when>
                <c:otherwise>
                    <table class="w-full text-sm">
                        <thead>
                        <tr class="border-b text-left">
                            <th class="py-2">Món</th>
                            <th class="py-2">SL</th>
                            <th class="py-2">Đơn giá</th>
                            <th class="py-2">Tác vụ</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${billDetails}">
                            <tr class="border-b">
                                <td class="py-2">
                                    <c:forEach var="drink" items="${drinks}">
                                        <c:if test="${drink.id == item.drinkId}">
                                            ${drink.name}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td class="py-2">${item.quantity}</td>
                                <td class="py-2">${item.price} đ</td>
                                <td class="py-2">
                                    <div class="flex gap-2">
                                        <form method="post" action="${pageContext.request.contextPath}/employee/pos/update-quantity">
                                            <input type="hidden" name="billId" value="${bill.id}">
                                            <input type="hidden" name="billDetailId" value="${item.id}">
                                            <input type="hidden" name="action" value="increase">
                                            <button class="px-2 py-1 bg-gray-200 rounded">+</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/employee/pos/update-quantity">
                                            <input type="hidden" name="billId" value="${bill.id}">
                                            <input type="hidden" name="billDetailId" value="${item.id}">
                                            <input type="hidden" name="action" value="decrease">
                                            <button class="px-2 py-1 bg-gray-200 rounded">-</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/employee/pos/update-quantity">
                                            <input type="hidden" name="billId" value="${bill.id}">
                                            <input type="hidden" name="billDetailId" value="${item.id}">
                                            <input type="hidden" name="action" value="remove">
                                            <button class="px-2 py-1 bg-red-100 text-red-600 rounded">Xóa</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="mt-4 text-right font-semibold text-lg">Tổng: ${total} đ</div>

                    <div class="mt-4 flex gap-3">
                        <form method="post" action="${pageContext.request.contextPath}/employee/pos/checkout">
                            <input type="hidden" name="billId" value="${bill.id}">
                            <button class="bg-green-600 text-white px-4 py-2 rounded">Thanh toán</button>
                        </form>
                        <form method="post" action="${pageContext.request.contextPath}/employee/pos/cancel">
                            <input type="hidden" name="billId" value="${bill.id}">
                            <button class="bg-red-600 text-white px-4 py-2 rounded">Hủy bill</button>
                        </form>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
