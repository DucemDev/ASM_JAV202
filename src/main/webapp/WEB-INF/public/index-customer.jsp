<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ khách hàng - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
    <meta http-equiv="refresh" content="10">
</head>

<body class="app-bg">
<div class="flex">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="flex-1 flex flex-col">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">
            <div class="max-w-[1400px] mx-auto grid grid-cols-2 gap-6">

                <div class="col-span-2 relative rounded-2xl overflow-hidden shadow-lg">
                    <div id="slides" data-slider-track data-slider-interval="3000" class="flex transition-transform duration-700">
                        <img src="${pageContext.request.contextPath}/assets/image/slide1.jpg"
                             class="w-full h-[320px] object-cover flex-shrink-0" alt="Slide 1">
                        <img src="${pageContext.request.contextPath}/assets/image/slide3.jpg"
                             class="w-full h-[320px] object-cover flex-shrink-0" alt="Slide 2">
                        <img src="${pageContext.request.contextPath}/assets/image/slide2.jpg"
                             class="w-full h-[320px] object-cover flex-shrink-0" alt="Slide 3">
                    </div>

                    <div class="absolute bottom-3 w-full flex justify-center gap-2">
                        <div class="dot w-2 h-2 bg-white rounded-full opacity-60"></div>
                        <div class="dot w-2 h-2 bg-white rounded-full opacity-60"></div>
                        <div class="dot w-2 h-2 bg-white rounded-full opacity-60"></div>
                    </div>
                </div>

                <div class="col-span-2 bg-white border border-gray-200 rounded-xl shadow-sm">
                    <div class="flex justify-between items-center p-4">
                        <h2 class="text-lg font-semibold text-cafe-brown">Lịch sử đơn hàng của tôi</h2>
                    </div>

                    <table class="w-full text-center text-sm">
                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr>
                            <th class="p-3">Mã hóa đơn</th>
                            <th>Ngày tạo</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty orders}">
                                <tr class="border-t">
                                    <td colspan="4" class="p-4 text-gray-500">Chưa có đơn hàng nào</td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="o" items="${orders}">
                                    <tr class="border-t hover:bg-gray-50">
                                        <td class="p-3 font-medium">${o.code}</td>
                                        <td>${o.createdAt}</td>
                                        <td class="js-currency" data-currency="${o.total}"></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${o.status == 'waiting'}">
                                                    <span class="text-gray-500 font-medium">Chờ thanh toán</span>
                                                </c:when>
                                                <c:when test="${o.status == 'pending_verify'}">
                                                    <span class="text-yellow-600 font-semibold">Chờ xác nhận</span>
                                                </c:when>
                                                <c:when test="${o.status == 'finish'}">
                                                    <span class="text-green-600 font-semibold">Hoàn tất</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-red-500 font-semibold">Đã hủy</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
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