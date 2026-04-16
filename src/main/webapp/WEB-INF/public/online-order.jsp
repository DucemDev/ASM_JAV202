<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng online - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
</head>
<body class="app-bg">

<div class="flex">
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="flex-1 flex flex-col">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">
            <div class="max-w-[1300px] mx-auto">
                <div class="mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">Đơn hàng online chờ xác nhận</h1>
                    <p class="text-gray-500 mt-1">Nhân viên/Quản trị viên theo dõi và xác nhận đơn tại đây.</p>
                </div>

                <c:set var="pendingCount" value="0"/>
                <c:set var="pendingTotal" value="0"/>
                <c:forEach var="o" items="${orders}">
                    <c:set var="pendingCount" value="${pendingCount + 1}"/>
                    <c:set var="pendingTotal" value="${pendingTotal + o.total}"/>
                </c:forEach>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                    <div class="bg-white rounded-xl shadow p-5">
                        <p class="text-gray-500 text-sm">Số đơn chờ xác nhận</p>
                        <p class="text-2xl font-bold text-orange-600 mt-1">${pendingCount}</p>
                    </div>
                    <div class="bg-white rounded-xl shadow p-5">
                        <p class="text-gray-500 text-sm">Tổng giá trị đơn chờ</p>
                        <p class="text-2xl font-bold text-green-600 mt-1 js-currency" data-currency="${pendingTotal}"></p>
                    </div>
                </div>

                <div class="bg-white shadow rounded-xl overflow-hidden">
                    <table class="w-full text-sm">
                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr class="text-center">
                            <th class="p-3">Mã hóa đơn</th>
                            <th>Mã người dùng</th>
                            <th>Loại đơn</th>
                            <th>Thời gian tạo</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th class="w-[260px]">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr class="border-t text-center hover:bg-gray-50">
                                <td class="p-3 font-semibold">${o.code}</td>
                                <td>${o.userId}</td>
                                <td class="uppercase">${o.type}</td>
                                <td>${o.createdAt}</td>
                                <td class="font-semibold text-green-700 js-currency" data-currency="${o.total}"></td>
                                <td>
                                    <span class="px-3 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-700">
                                        ${o.status}
                                    </span>
                                </td>
                                <td>
                                    <div class="flex items-center justify-center gap-2 py-2">
                                        <a href="${pageContext.request.contextPath}/seller/online-orders/detail?id=${o.id}"
                                           class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-1 rounded-lg">
                                            Xem chi tiết
                                        </a>

                                        <form method="post"
                                              action="${pageContext.request.contextPath}/seller/online-orders/confirm"
                                              data-disable-on-submit="true"
                                              data-confirm="Xác nhận đơn #${o.code}?">
                                            <input type="hidden" name="billId" value="${o.id}" />
                                            <button class="bg-green-600 hover:bg-green-700 text-white px-4 py-1 rounded-lg">
                                                Xác nhận
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="7" class="p-6 text-center text-gray-500">
                                    Hiện chưa có đơn online nào cần xác nhận.
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>