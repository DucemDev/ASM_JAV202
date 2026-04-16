<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bàn - PolyCafe</title>
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
<div class="flex h-screen">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="flex-1 flex flex-col bg-cafe-bg ml-64 transition-all duration-300">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">
            <div class="bg-white rounded-2xl shadow-lg p-8 border border-gray-200">

                <div class="flex justify-between items-center mb-6">
                    <div>
                        <h1 class="text-2xl font-semibold text-gray-800">Quản lý bàn</h1>
                    </div>

                    <a href="${pageContext.request.contextPath}/manager/tables"
                       class="px-4 py-2 rounded-lg bg-gray-100 hover:bg-gray-200 text-gray-700 text-sm">
                        Tải lại
                    </a>
                </div>

                <c:if test="${not empty sessionScope.message}">
                    <div class="mb-4 p-3 rounded-lg bg-green-50 text-green-700 border border-green-200">
                        ${sessionScope.message}
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="mb-4 p-3 rounded-lg bg-red-50 text-red-700 border border-red-200">
                        ${sessionScope.error}
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

                    <div class="lg:col-span-1">
                        <div class="border border-gray-200 rounded-xl p-5 bg-[#fcfaf7]">
                            <h2 class="text-lg font-semibold text-gray-800 mb-4">
                                <c:choose>
                                    <c:when test="${not empty table}">Cập nhật bàn</c:when>
                                    <c:otherwise>Thêm bàn mới</c:otherwise>
                                </c:choose>
                            </h2>

                            <c:set var="formAction" value="${pageContext.request.contextPath}/manager/tables/add"/>
                            <c:if test="${not empty table}">
                                <c:set var="formAction" value="${pageContext.request.contextPath}/manager/tables/edit"/>
                            </c:if>

                            <form action="${formAction}" method="post" class="space-y-4">
                                <c:if test="${not empty table}">
                                    <input type="hidden" name="id" value="${table.id}">
                                </c:if>

                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Tên bàn</label>
                                    <input type="text" name="name"
                                           value="${not empty table ? table.name : ''}"
                                           class="w-full border border-gray-300 rounded-lg px-3 py-2">
                                </div>

                                <div class="flex gap-3">
                                    <button type="submit"
                                            class="px-4 py-2 rounded-lg bg-cafe-brown text-white">
                                        Lưu
                                    </button>

                                    <a href="${pageContext.request.contextPath}/manager/tables"
                                       class="px-4 py-2 rounded-lg bg-gray-100">
                                        Hủy
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="lg:col-span-2">

                        <div class="flex gap-3 mb-4">
                            <a href="?tab=empty"
                               class="px-4 py-2 rounded-lg ${empty param.tab || param.tab=='empty' ? 'bg-green-500 text-white' : 'bg-green-100'}">
                                Bàn trống
                            </a>

                            <a href="?tab=occupied"
                               class="px-4 py-2 rounded-lg ${param.tab=='occupied' ? 'bg-red-500 text-white' : 'bg-red-100'}">
                                Đang dùng
                            </a>

                            <a href="?tab=hidden"
                               class="px-4 py-2 rounded-lg ${param.tab=='hidden' ? 'bg-gray-700 text-white' : 'bg-gray-200'}">
                                Bàn ẩn
                            </a>
                        </div>

                        <div class="bg-white border rounded-xl">
                            <table class="min-w-full">

                                <thead class="bg-gray-50 border-b">
                                <tr>
                                    <th class="px-4 py-3 text-left">ID</th>
                                    <th class="px-4 py-3 text-left">Tên bàn</th>
                                    <th class="px-4 py-3 text-left">Trạng thái</th>
                                    <th class="px-4 py-3 text-left">Thao tác</th>
                                </tr>
                                </thead>

                                <tbody>

                                <c:if test="${empty param.tab || param.tab=='empty'}">
                                    <c:forEach var="t" items="${list}">
                                        <c:if test="${t.active && t.status=='empty'}">
                                            <tr class="border-b hover:bg-gray-50">
                                                <td class="px-4 py-3">${t.id}</td>
                                                <td class="px-4 py-3">${t.name}</td>
                                                <td class="px-4 py-3">
                                                    <span class="bg-green-100 px-2 py-1 text-xs rounded">Trống</span>
                                                </td>
                                                <td class="px-4 py-3">
                                                    <a href="${pageContext.request.contextPath}/manager/tables?id=${t.id}"
                                                       class="px-3 py-1.5 bg-blue-50 text-blue-700 rounded">Sửa</a>

                                                    <form action="${pageContext.request.contextPath}/manager/tables/hide"
                                                          method="post" class="inline">
                                                        <input type="hidden" name="id" value="${t.id}">
                                                        <button class="ml-2 text-green-600">Ẩn</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:if>

                                <c:if test="${param.tab=='occupied'}">
                                    <c:forEach var="t" items="${list}">
                                        <c:if test="${t.active && (t.status=='occupied' || t.status=='using')}">
                                            <tr class="border-b hover:bg-gray-50">
                                                <td class="px-4 py-3">${t.id}</td>
                                                <td class="px-4 py-3">${t.name}</td>
                                                <td class="px-4 py-3">
                                                    <span class="bg-red-100 px-2 py-1 text-xs rounded">Đang dùng</span>
                                                </td>
                                                <td class="px-4 py-3">-</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:if>

                                <c:if test="${param.tab=='hidden'}">
                                    <c:forEach var="t" items="${list}">
                                        <c:if test="${!t.active || t.status=='hidden'}">
                                            <tr class="border-b hover:bg-gray-50">
                                                <td class="px-4 py-3">${t.id}</td>
                                                <td class="px-4 py-3">${t.name}</td>
                                                <td class="px-4 py-3">
                                                    <span class="bg-gray-200 px-2 py-1 text-xs rounded">Ẩn</span>
                                                </td>
                                                <td class="px-4 py-3">
                                                    <form action="${pageContext.request.contextPath}/manager/tables/show"
                                                          method="post" class="inline">
                                                        <input type="hidden" name="id" value="${t.id}">
                                                        <button class="text-gray-600">Bật</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:if>

                                </tbody>

                            </table>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>