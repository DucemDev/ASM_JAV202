<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết hóa đơn cá nhân - PolyCafe</title>
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

    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">
            <div class="max-w-[1200px] mx-auto">

                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">Hóa đơn #${bill.id}</h1>
                    <a href="${pageContext.request.contextPath}/personal-bill"
                       class="bg-gray-600 text-white px-4 py-2 rounded-lg hover:opacity-90">Quay lại</a>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6 mb-6 grid grid-cols-2 gap-6">
                    <div>
                        <p class="text-gray-600">Loại</p>
                        <p class="font-semibold">${bill.type}</p>
                    </div>

                    <div>
                        <p class="text-gray-600">Trạng thái</p>
                        <p class="font-semibold">${bill.status}</p>
                    </div>

                    <div>
                        <p class="text-gray-600">Bàn</p>
                        <p class="font-semibold">
                            <c:choose>
                                <c:when test="${bill.type == 'online' || bill.tableId <= 0}">
                                    Online (không bàn)
                                </c:when>
                                <c:otherwise>Bàn ${bill.tableId}</c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <div>
                        <p class="text-gray-600">Ngày tạo</p>
                        <p class="font-semibold">${bill.createdAt}</p>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <table class="w-full text-sm text-center">
                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr>
                            <th class="p-3">Tên nước</th>
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
                                <td>${item.price} đ</td>
                                <td>${item.quantity}</td>
                                <td class="font-semibold">${lineTotal} đ</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty billItems}">
                            <tr>
                                <td colspan="4" class="p-6 text-gray-500">Không có món trong hóa đơn.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="mt-6 text-right text-lg">
                    Tổng: <span class="font-bold text-green-600 text-xl">${sum} đ</span>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>