<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn online - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
</head>
<body class="app-bg">
<div class="flex">
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="flex-1 flex flex-col">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">
            <div class="max-w-[1200px] mx-auto">

                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">Chi tiết đơn online #${bill.code}</h1>
                    <a href="${pageContext.request.contextPath}/seller/online-orders"
                       class="bg-gray-600 text-white px-4 py-2 rounded-lg hover:bg-gray-700 transition">
                        Quay lại
                    </a>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6 mb-6 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                    <div><p class="text-gray-500 text-sm">Mã hóa đơn</p><p class="font-semibold text-gray-800">${bill.id}</p></div>
                    <div><p class="text-gray-500 text-sm">Mã người dùng</p><p class="font-semibold text-gray-800">${bill.userId}</p></div>
                    <div><p class="text-gray-500 text-sm">Loại đơn</p><p class="font-semibold uppercase text-gray-800">${bill.type}</p></div>
                    <div><p class="text-gray-500 text-sm">Trạng thái</p><p class="font-semibold text-yellow-700">${bill.status}</p></div>
                    <div><p class="text-gray-500 text-sm">Ngày tạo</p><p class="font-semibold text-gray-800">${bill.createdAt}</p></div>
                    <div><p class="text-gray-500 text-sm">Tổng tiền hóa đơn</p><p class="font-semibold text-green-700 js-currency" data-currency="${bill.total}"></p></div>
                </div>

                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <table class="w-full text-sm text-center">
                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr>
                            <th class="p-3">Tên món</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="sum" value="0"/>
                        <c:forEach var="item" items="${billItems}">
                            <c:set var="lineTotal" value="${item.price * item.quantity}"/>
                            <c:set var="sum" value="${sum + lineTotal}"/>

                            <tr class="border-t hover:bg-gray-50">
                                <td class="p-3">
                                    <c:set var="drinkName" value="Không xác định"/>
                                    <c:forEach var="d" items="${drinks}">
                                        <c:if test="${d.id == item.drinkId}">
                                            <c:set var="drinkName" value="${d.name}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${drinkName}
                                </td>
                                <td class="js-currency" data-currency="${item.price}"></td>
                                <td>${item.quantity}</td>
                                <td class="font-semibold js-currency" data-currency="${lineTotal}"></td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty billItems}">
                            <tr>
                                <td colspan="4" class="p-6 text-gray-500">Không có món nào trong hóa đơn.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="mt-6 text-right text-lg">
                    Tổng chi tiết: <span class="font-bold text-green-600 text-xl js-currency" data-currency="${sum}"></span>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>