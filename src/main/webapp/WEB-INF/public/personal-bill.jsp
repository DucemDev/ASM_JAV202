<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử hóa đơn cá nhân - PolyCafe</title>

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
            <div class="max-w-[1400px] mx-auto">

                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">Lịch sử hóa đơn của tôi</h1>
                </div>

                <form method="get"
                      action="${pageContext.request.contextPath}/personal-bill"
                      class="mb-4 flex gap-3 flex-wrap">

                    <input type="text" name="keyword"
                           value="${keyword}"
                           placeholder="Tìm theo mã hóa đơn..."
                           class="border rounded-lg px-4 py-2 w-64">

                    <select name="status" class="border rounded-lg px-4 py-2">
                        <option value="">Tất cả trạng thái</option>
                        <option value="waiting" ${status == 'waiting' ? 'selected' : ''}>Chờ thanh toán</option>
                        <option value="pending_verify" ${status == 'pending_verify' ? 'selected' : ''}>Chờ xác nhận</option>
                        <option value="finish" ${status == 'finish' ? 'selected' : ''}>Hoàn tất</option>
                        <option value="cancel" ${status == 'cancel' ? 'selected' : ''}>Đã hủy</option>
                    </select>

                    <input type="date" name="fromDate" value="${fromDate}" class="border rounded-lg px-4 py-2">
                    <input type="date" name="toDate" value="${toDate}" class="border rounded-lg px-4 py-2">

                    <button class="bg-gray-700 text-white px-5 py-2 rounded-lg hover:opacity-90">
                        Lọc
                    </button>
                </form>

                <p class="mb-3">Tổng hóa đơn: ${billList.size()}</p>

                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <table class="w-full text-sm text-center">
                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr>
                            <th class="p-3">Mã hóa đơn</th>
                            <th>Bàn</th>
                            <th>Loại</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Chi tiết</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="b" items="${billList}">
                            <tr class="border-t hover:bg-gray-50">
                                <td class="p-3">#${b.id}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.type == 'online' || b.tableId <= 0}">
                                            Online (không bàn)
                                        </c:when>
                                        <c:otherwise>
                                            Bàn ${b.tableId}
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.type == 'online'}">Online</c:when>
                                        <c:when test="${b.type == 'pos'}">POS</c:when>
                                        <c:otherwise>${b.type}</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${b.total} đ</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.status == 'waiting'}">
                                            <span class="text-blue-600 font-semibold">Chờ thanh toán</span>
                                        </c:when>
                                        <c:when test="${b.status == 'pending_verify'}">
                                            <span class="text-amber-600 font-semibold">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${b.status == 'finish'}">
                                            <span class="text-green-600 font-semibold">Hoàn tất</span>
                                        </c:when>
                                        <c:when test="${b.status == 'cancel'}">
                                            <span class="text-red-500 font-semibold">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-600 font-semibold">${b.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${b.createdAt}</td>

                                <td>
                                    <a href="${pageContext.request.contextPath}/personal-bill/detail?id=${b.id}"
                                       class="bg-blue-500 text-white px-3 py-1 rounded hover:opacity-80 inline-block">
                                        Xem
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty billList}">
                            <tr>
                                <td colspan="7" class="p-6 text-gray-500">
                                    Không có hóa đơn phù hợp.
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

</body>
</html>