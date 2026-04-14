<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Bill Management</title>

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
        }
    </script>
</head>

<body class="bg-cafe-bg">

<div class="flex">

    <!-- SIDEBAR -->
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <!-- MAIN -->
    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <!-- CONTENT -->
        <div class="p-8">
            <div class="max-w-[1400px] mx-auto">

                <!-- TITLE + EXPORT -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">Bill Management</h1>

                    <a href="${pageContext.request.contextPath}/manager/bill/export"
                       class="bg-green-600 text-white px-5 py-2 rounded-lg">
                        Export Excel
                    </a>
                </div>

                <!-- FILTER -->
                <form method="get"
                      action="${pageContext.request.contextPath}/manager/bill"
                      class="mb-4 flex gap-3 flex-wrap">

                    <input type="text" name="keyword"
                           value="${keyword}"
                           placeholder="Search bill ID..."
                           class="border rounded-lg px-4 py-2 w-64">

                    <select name="status" class="border rounded-lg px-4 py-2">
                        <option value="">All Status</option>
                        <option value="waiting" ${status == 'waiting' ? 'selected' : ''}>Waiting</option>
                        <option value="pending_verify" ${status == 'pending_verify' ? 'selected' : ''}>Pending Verify</option>
                        <option value="finish" ${status == 'finish' ? 'selected' : ''}>Finish</option>
                        <option value="cancel" ${status == 'cancel' ? 'selected' : ''}>Cancel</option>
                    </select>

                    <input type="date" name="fromDate" value="${fromDate}" class="border rounded-lg px-4 py-2">
                    <input type="date" name="toDate" value="${toDate}" class="border rounded-lg px-4 py-2">

                    <button class="bg-gray-700 text-white px-5 py-2 rounded-lg">
                        Filter
                    </button>
                </form>

                <!-- TABLE -->
                <p class="mb-3">Total bills: ${billList.size()}</p>

                <div class="bg-white rounded-xl shadow-md overflow-hidden">

                    <table class="w-full text-sm text-center">

                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr>
                            <th class="p-3">Bill ID</th>
                            <th>Table</th>
                            <th>Type</th>
                            <th>Created By</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Created At</th>
                            <th>Action</th>
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
                                            Table ${b.tableId}
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

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty b.userFullName}">
                                            ${b.userFullName}
                                        </c:when>
                                        <c:otherwise>Unknown</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${b.total} đ</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.status == 'waiting'}">
                                            <span class="text-blue-600 font-semibold">Waiting</span>
                                        </c:when>
                                        <c:when test="${b.status == 'pending_verify'}">
                                            <span class="text-amber-600 font-semibold">Pending Verify</span>
                                        </c:when>
                                        <c:when test="${b.status == 'finish'}">
                                            <span class="text-green-600 font-semibold">Completed</span>
                                        </c:when>
                                        <c:when test="${b.status == 'cancel'}">
                                            <span class="text-red-500 font-semibold">Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-600 font-semibold">${b.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${b.createdAt}</td>

                                <td>
                                    <a href="${pageContext.request.contextPath}/manager/bill-detail?id=${b.id}"
                                       class="bg-blue-500 text-white px-3 py-1 rounded hover:opacity-80 inline-block">
                                        View
                                    </a>
                                </td>

                            </tr>
                        </c:forEach>

                        <c:if test="${empty billList}">
                            <tr>
                                <td colspan="8" class="p-6 text-gray-500">
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