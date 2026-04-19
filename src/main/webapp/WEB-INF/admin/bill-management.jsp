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
                      class="mb-6 flex gap-3 flex-wrap items-end">

                    <div class="flex-1 min-w-[250px]">
                        <label class="block text-xs font-semibold text-[#41521E] mb-1 ml-1 uppercase">Tìm kiếm</label>
                        <input type="text" name="keyword"
                               value="${keyword}"
                               placeholder="Mã hóa đơn hoặc tên nhân viên..."
                               class="w-full px-4 py-2 rounded-xl backdrop-blur-xl border focus:ring-2 focus:ring-[#909632] outline-none"
                               style="background:rgba(255,255,255,0.25); border-color:rgba(255,255,255,0.4);">
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-[#41521E] mb-1 ml-1 uppercase">Trạng thái</label>
                        <select name="status"
                                class="px-4 py-2 rounded-xl backdrop-blur-xl border focus:ring-2 focus:ring-[#909632] outline-none"
                                style="background:rgba(255,255,255,0.25); border-color:rgba(255,255,255,0.4);">
                            <option value="">Tất cả trạng thái</option>
                            <option value="waiting" ${status == 'waiting' ? 'selected' : ''}>Đang chờ</option>
                            <option value="pending_verify" ${status == 'pending_verify' ? 'selected' : ''}>Chờ xác nhận</option>
                            <option value="finish" ${status == 'finish' ? 'selected' : ''}>Hoàn thành</option>
                            <option value="cancel" ${status == 'cancel' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-[#41521E] mb-1 ml-1 uppercase">Từ ngày</label>
                        <input type="date" name="fromDate" value="${fromDate}"
                               class="px-4 py-2 rounded-xl backdrop-blur-xl border focus:ring-2 focus:ring-[#909632] outline-none"
                               style="background:rgba(255,255,255,0.25); border-color:rgba(255,255,255,0.4);">
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-[#41521E] mb-1 ml-1 uppercase">Đến ngày</label>
                        <input type="date" name="toDate" value="${toDate}"
                               class="px-4 py-2 rounded-xl backdrop-blur-xl border focus:ring-2 focus:ring-[#909632] outline-none"
                               style="background:rgba(255,255,255,0.25); border-color:rgba(255,255,255,0.4);">
                    </div>

                    <div class="flex gap-2">
                        <button type="submit" class="px-6 py-2 rounded-xl text-white shadow-lg hover:scale-105 transition font-semibold"
                                style="background:#27301B;">
                            Lọc
                        </button>
                        
                        <a href="${pageContext.request.contextPath}/manager/bill" 
                           class="px-6 py-2 rounded-xl text-white shadow hover:scale-105 transition font-semibold flex items-center gap-2"
                           style="background:#6b7280;">
                            Làm mới
                        </a>
                    </div>
                </form>

                <!-- TOTAL -->
                <div class="mb-4 flex justify-between items-center">
                    <p class="text-[#27301B] font-medium">
                        Tổng số hóa đơn: <span class="font-bold text-lg">${totalRecords}</span>
                    </p>
                </div>

                <!-- TABLE -->
                <div class="rounded-2xl shadow-xl overflow-hidden backdrop-blur-xl border"
                     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">

                    <table class="w-full text-sm text-center">

                        <thead style="background:rgba(65,82,30,0.25);" class="text-[#27301B] uppercase tracking-wider">
                        <tr>
                            <th class="p-4">STT</th>
                            <th>Mã Bill</th>
                            <th>Bàn</th>
                            <th>Loại</th>
                            <th>Nhân viên</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Thời gian</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="b" items="${billList}" varStatus="status">
                            <tr class="border-t border-white/30 hover:bg-white/15 transition">

                                <td class="p-4 font-semibold text-gray-600">
                                    ${(currentPage - 1) * 10 + status.index + 1}
                                </td>

                                <td class="font-bold text-[#27301B]">
                                    <c:choose>
                                        <c:when test="${not empty b.code}">${b.code}</c:when>
                                        <c:otherwise>#${b.id}</c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="font-medium">
                                    <c:choose>
                                        <c:when test="${b.type == 'online' || b.tableId <= 0}">
                                            <span class="text-blue-600 italic">Online</span>
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

                                <td class="font-medium">
                                    <c:choose>
                                        <c:when test="${not empty b.userFullName}">
                                            ${b.userFullName}
                                        </c:when>
                                        <c:otherwise><span class="text-gray-400 italic">Hệ thống</span></c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="font-bold text-[#41521E]">${String.format("%,d", b.total).replace(",", ".")} đ</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.status == 'waiting'}">
                                            <span class="px-3 py-1 rounded-full bg-blue-100 text-blue-700 text-xs font-bold">Đang chờ</span>
                                        </c:when>
                                        <c:when test="${b.status == 'pending_verify'}">
                                            <span class="px-3 py-1 rounded-full bg-yellow-100 text-yellow-700 text-xs font-bold">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${b.status == 'finish'}">
                                            <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 text-xs font-bold">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${b.status == 'cancel'}">
                                            <span class="px-3 py-1 rounded-full bg-red-100 text-red-700 text-xs font-bold">Đã hủy</span>
                                        </c:when>
                                        <c:when test="${b.status == 'expired'}">
                                            <span class="px-3 py-1 rounded-full bg-orange-100 text-orange-700 text-xs font-bold">Hết hạn</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-3 py-1 rounded-full bg-gray-100 text-gray-700 text-xs font-bold">${b.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-gray-600">${b.createdAt}</td>

                                <td>
                                    <div class="flex justify-center">
                                        <a href="${pageContext.request.contextPath}/manager/bill-detail?id=${b.id}"
                                           class="px-4 py-1.5 rounded-lg text-white text-xs font-bold shadow hover:scale-105 transition"
                                           style="background:#41521E;">
                                            Chi tiết
                                        </a>
                                    </div>
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
                <div class="flex justify-center mt-6 gap-2 flex-wrap">

                    <!-- Prev -->
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}&keyword=${keyword}&status=${status}&fromDate=${fromDate}&toDate=${toDate}"
                           class="px-3 py-1 rounded-lg bg-white border hover:bg-gray-100">
                            «
                        </a>
                    </c:if>

                    <!-- Page numbers -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="?page=${i}&keyword=${keyword}&status=${status}&fromDate=${fromDate}&toDate=${toDate}"
                           class="px-3 py-1 rounded-lg border
           ${i == currentPage ? 'bg-[#27301B] text-white' : 'bg-white'}">
                                ${i}
                        </a>
                    </c:forEach>

                    <!-- Next -->
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&keyword=${keyword}&status=${status}&fromDate=${fromDate}&toDate=${toDate}"
                           class="px-3 py-1 rounded-lg bg-white border hover:bg-gray-100">
                            »
                        </a>
                    </c:if>

                </div>
            </div>
        </div>

    </div>

</div>

</body>
</html>
