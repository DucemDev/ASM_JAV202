<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - PolyCafe</title>

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
        };
    </script>
</head>

<body class="bg-cafe-bg">
<div class="flex">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div class="flex-1 flex flex-col ml-64">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">
            <div class="max-w-[600px] mx-auto">
                <div class="bg-white rounded-2xl shadow-lg p-6 border">

                    <div class="text-center border-b pb-4 mb-4">
                        <h2 class="text-xl font-bold text-green-600">✅ Đặt hàng thành công</h2>
                        <p class="text-xs text-gray-400">Cảm ơn bạn đã đặt hàng</p>
                    </div>

                    <div class="text-sm mb-4 space-y-1">
                        <p>Mã đơn: <b>${bill.code}</b></p>
                        <p>Loại: <b>ĐƠN ONLINE</b></p>
                        <p>Thời gian:
                            <b>
                                <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
                                        .format(new java.util.Date()) %>
                            </b>
                        </p>
                    </div>

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

                    <div class="text-right text-lg font-bold mb-4">
                        Tổng: ${total} đ
                    </div>

                    <div class="text-center text-sm text-gray-500 mb-4">
                        Đơn hàng của bạn đang được xử lý ☕
                    </div>

                    <div class="flex gap-2">
                        <a href="${pageContext.request.contextPath}/customer/order"
                           class="w-1/2 text-center bg-gray-500 text-white py-2 rounded hover:opacity-90">
                            Đặt thêm
                        </a>
                        <a href="${pageContext.request.contextPath}/customer"
                           class="w-1/2 text-center bg-cafe-brown text-white py-2 rounded hover:opacity-90">
                            Về trang chủ
                        </a>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>