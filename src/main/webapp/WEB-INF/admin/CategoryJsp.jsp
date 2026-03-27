<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý loại đồ uống</title>

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
    <div id="mainContent" class="flex-1 ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">

            <!-- CARD -->
            <div class="bg-white rounded-2xl shadow-lg p-8 border border-gray-200 max-w-[1400px] mx-auto">

                <h2 class="text-xl font-semibold text-gray-800 mb-6">
                    Quản lý loại đồ uống
                </h2>

                <!-- MESSAGE -->
                <c:if test="${not empty sessionScope.message}">
                    <p class="mb-4 text-green-600 font-medium">${sessionScope.message}</p>
                    <c:remove var="message" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <p class="mb-4 text-red-500 font-medium">${sessionScope.error}</p>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <!-- FORM -->
                <form method="post"
                      action="${pageContext.request.contextPath}/manager/categories/${category != null ? 'edit' : 'add'}"
                      class="grid grid-cols-3 gap-4 items-end mb-8">

                    <!-- ID hidden -->
                    <input type="hidden" name="id" value="${category.id}" />

                    <!-- NAME -->
                    <div>
                        <label class="block text-sm text-gray-600 mb-1">Tên loại</label>
                        <input type="text" name="name" value="${category.name}"
                               required
                               class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-cafe-brown"/>
                    </div>

                    <!-- STATUS -->
                    <div>
                        <label class="block text-sm text-gray-600 mb-1">Trạng thái</label>

                        <div class="flex gap-4 mt-2">

                            <label class="flex items-center gap-2 text-sm">
                                <input type="radio" name="active" value="true"
                                ${category == null || category.active ? 'checked' : ''}>
                                Hoạt động
                            </label>

                            <label class="flex items-center gap-2 text-sm">
                                <input type="radio" name="active" value="false"
                                ${category != null && !category.active ? 'checked' : ''}>
                                Ngừng
                            </label>

                        </div>
                    </div>

                    <!-- BUTTON -->
                    <div>
                        <button type="submit"
                                class="w-full bg-cafe-brown text-white py-2 rounded-lg hover:opacity-90 transition">

                            ${category != null ? 'Cập nhật' : 'Thêm mới'}

                        </button>
                    </div>

                </form>

                <!-- TABLE -->
                <div class="overflow-x-auto">

                    <table class="w-full border border-gray-200 rounded-xl overflow-hidden">

                        <thead class="bg-[#f1e4d7] text-gray-700 text-sm">
                        <tr>
                            <th class="py-3">ID</th>
                            <th>Tên</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody class="text-center text-sm">

                        <c:forEach var="item" items="${list}">
                            <tr class="border-t hover:bg-gray-50">

                                <td class="py-3">${item.id}</td>

                                <td>${item.name}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${item.active}">
                                            <span class="text-green-600 font-medium">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-500">Ngừng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="space-x-2">

                                    <!-- EDIT -->
                                    <a href="${pageContext.request.contextPath}/manager/categories?id=${item.id}"
                                       class="px-3 py-1 text-sm bg-blue-500 text-white rounded-lg hover:opacity-90">
                                        Sửa
                                    </a>

                                    <!-- DELETE -->
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/manager/categories/delete"
                                          class="inline">

                                        <input type="hidden" name="id" value="${item.id}" />

                                        <button onclick="return confirm('Bạn có chắc muốn xóa?')"
                                                class="px-3 py-1 text-sm bg-red-500 text-white rounded-lg hover:opacity-90">
                                            Xóa
                                        </button>

                                    </form>

                                </td>

                            </tr>
                        </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>