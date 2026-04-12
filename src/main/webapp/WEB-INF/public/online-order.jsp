<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Online Orders</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">

<h2 class="text-2xl font-bold mb-6">Đơn hàng online chờ xác nhận</h2>

<table class="w-full bg-white shadow rounded-xl overflow-hidden">
    <thead class="bg-gray-200">
    <tr>
        <th class="p-3">Mã Bill</th>
        <th>User ID</th>
        <th>Total</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach var="o" items="${orders}">
        <tr class="border-t text-center">
            <td class="p-3">${o.code}</td>
            <td>${o.userId}</td>
            <td>${o.total} đ</td>
            <td>${o.status}</td>
            <td>
                <form method="post"
                      action="${pageContext.request.contextPath}/seller/online-orders/confirm">
                    <input type="hidden" name="billId" value="${o.id}" />
                    <button class="bg-green-500 text-white px-4 py-1 rounded">
                        Confirm
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>

