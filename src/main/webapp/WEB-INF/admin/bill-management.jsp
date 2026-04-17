<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Quản lý hóa đơn</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

    <!-- SIDEBAR -->
    <jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

    <!-- MAIN -->
    <div id="mainContent"
         class="flex-1 flex flex-col ml-64 transition-all duration-300 h-screen overflow-y-auto">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/public/layout/header.jsp"/>

        <!-- CONTENT -->
        <div class="p-8">
            <div class="max-w-[1400px] mx-auto">

                <!-- TITLE + EXPORT -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-[#27301B]">
                        Quản lý hóa đơn
                    </h1>


                </div>

                <!-- FILTER -->
                <form method="get"
                      action="${pageContext.request.contextPath}/manager/bill"
                      class="mb-6 flex gap-3 flex-wrap">

                    <input type="text" name="keyword"
                           value="${keyword}"
                           placeholder="Tìm theo mã hóa đơn..."
                           class="px-4 py-2 rounded-xl backdrop-blur-xl border"
                           style="background:rgba(255,255,255,0.25); border-color:rgba(255,255,255,0.4);">

                    <select name="status"
                            class="px-4 py-2 rounded-xl backdrop-blur-xl border"
                            style="background:rgba(255,255,255,0.25); border-color:rgba(255,255,255,0.4);">
                        <option value="">Tất cả trạng thái</option>
                        <option value="waiting" ${status == 'waiting' ? 'selected' : ''}>Đang chờ</option>
                        <option value="pending_verify" ${status == 'pending_verify' ? 'selected' : ''}>Chờ xác nhận</option>
                        <option value="finish" ${status == 'finish' ? 'selected' : ''}>Hoàn thành</option>
                        <option value="cancel" ${status == 'cancel' ? 'selected' : ''}>Đã hủy</option>
                    </select>

                    <input type="date" name="fromDate" value="${fromDate}"
                           class="px-4 py-2 rounded-xl backdrop-blur-xl border"
                           style="background:rgba(255,255,255,0.25); border-color:rgba(255,255,255,0.4);">

                    <input type="date" name="toDate" value="${toDate}"
                           class="px-4 py-2 rounded-xl backdrop-blur-xl border"
                           style="background:rgba(255,255,255,0.25); border-color:rgba(255,255,255,0.4);">

                    <button class="px-5 py-2 rounded-xl text-white shadow-lg hover:scale-105 transition"
                            style="background:#27301B;">
                        Lọc
                    </button>
                </form>

                <!-- TOTAL -->
                <p class="mb-4 text-[#27301B] font-medium">
                    Tổng số hóa đơn: ${billList.size()}
                </p>

                <!-- TABLE -->
                <div class="rounded-2xl shadow-xl overflow-hidden backdrop-blur-xl border"
                     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">

                    <table class="w-full text-sm text-center">

                        <thead style="background:rgba(65,82,30,0.2);" class="text-[#27301B]">
                        <tr>
                            <th class="p-3">Mã</th>
                            <th>Bàn</th>
                            <th>Loại</th>
                            <th>Người tạo</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Thời gian</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="b" items="${billList}">
                            <tr class="border-t border-white/20 hover:bg-white/10 transition">

                                <td class="p-3">#${b.id}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.type == 'online' || b.tableId <= 0}">
                                            Online
                                        </c:when>
                                        <c:otherwise>
                                            Bàn ${b.tableId}
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.type == 'online'}">Online</c:when>
                                        <c:when test="${b.type == 'pos'}">Tại quầy</c:when>
                                        <c:otherwise>${b.type}</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty b.userFullName}">
                                            ${b.userFullName}
                                        </c:when>
                                        <c:otherwise>Không rõ</c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="font-semibold">${b.total} đ</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.status == 'waiting'}">
                                            <span class="font-semibold text-blue-500">Đang chờ</span>
                                        </c:when>
                                        <c:when test="${b.status == 'pending_verify'}">
                                            <span class="font-semibold text-yellow-500">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${b.status == 'finish'}">
                                            <span class="font-semibold text-green-500">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${b.status == 'cancel'}">
                                            <span class="font-semibold text-red-500">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>${b.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${b.createdAt}</td>

                                <td>
                                    <a href="${pageContext.request.contextPath}/manager/bill-detail?id=${b.id}"
                                       class="px-3 py-1 rounded-lg text-white shadow hover:scale-105 transition"
                                       style="background:#41521E;">
                                        Xem
                                    </a>
                                </td>

                            </tr>
                        </c:forEach>

                        <c:if test="${empty billList}">
                            <tr>
                                <td colspan="8" class="p-6 text-gray-500">
                                    Không có dữ liệu
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
