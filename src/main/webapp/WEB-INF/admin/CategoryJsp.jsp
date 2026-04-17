<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý loại đồ uống</title>

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

        <div class="p-8">

            <!-- CARD -->
            <div class="rounded-2xl shadow-xl p-8 border backdrop-blur-xl max-w-[1400px] mx-auto"
                 style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">

                <h2 class="text-xl font-semibold text-[#27301B] mb-6">
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

                    <input type="hidden" name="id" value="${category.id}" />

                    <div>
                        <label class="block text-sm text-[#41521E] mb-1">Tên loại</label>
                        <input type="text" name="name" value="${category.name}"
                               required
                               class="w-full rounded-lg px-3 py-2 outline-none border backdrop-blur-xl"
                               style="background:rgba(255,255,255,0.3); border-color:#909632;">
                    </div>

                    <div>
                        <label class="block text-sm text-[#41521E] mb-1">Trạng thái</label>

                        <div class="flex gap-4 mt-2">

                            <label class="flex items-center gap-2 text-sm">
                                <input type="radio" name="active" value="true"
                                ${category == null || category.active ? 'checked' : ''}>
                                Hoạt động
                            </label>

                            <label class="flex items-center gap-2 text-sm">
                                <input type="radio" name="active" value="false"
                                ${category != null && !category.active ? 'checked' : ''}>
                                Ngừng hoạt động
                            </label>

                        </div>
                    </div>

                    <div>
                        <button type="submit"
                                class="w-full text-white py-2 rounded-lg hover:scale-105 transition shadow-lg"
                                style="background:#27301B;">

                            ${category != null ? 'Cập nhật' : 'Thêm mới'}

                        </button>
                    </div>

                </form>

                <!-- SEARCH -->
                <form method="get"
                      action="${pageContext.request.contextPath}/manager/categories"
                      class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end mb-8">

                    <div>
                        <label class="block text-sm text-[#41521E] mb-1">Tìm theo tên loại</label>
                        <input type="text" name="keyword" value="${keyword}"
                               class="w-full rounded-lg px-3 py-2 outline-none border backdrop-blur-xl"
                               style="background:rgba(255,255,255,0.3); border-color:#909632;">
                    </div>

                    <div>
                        <label class="block text-sm text-[#41521E] mb-1">Lọc trạng thái</label>
                        <select name="active"
                                class="w-full rounded-lg px-3 py-2 outline-none border backdrop-blur-xl"
                                style="background:rgba(255,255,255,0.3); border-color:#909632;">
                            <option value="">Tất cả</option>
                            <option value="true" ${active == 'true' ? 'selected' : ''}>Hoạt động</option>
                            <option value="false" ${active == 'false' ? 'selected' : ''}>Ngừng hoạt động</option>
                        </select>
                    </div>

                    <div>
                        <button type="submit"
                                class="w-full text-white py-2 rounded-lg hover:scale-105 transition shadow-lg"
                                style="background:#41521E;">
                            Tìm kiếm
                        </button>
                    </div>

                </form>

                <!-- TABLE -->
                <div class="overflow-x-auto">

                    <table class="w-full rounded-xl overflow-hidden">

                        <thead style="background:rgba(65,82,30,0.2);" class="text-[#27301B] text-sm">
                        <tr>
                            <th class="py-3">ID</th>
                            <th>Tên</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody class="text-center text-sm">

                        <c:forEach var="item" items="${list}">
                            <tr class="border-t border-white/20 hover:bg-white/10 transition">

                                <td class="py-3">${item.id}</td>

                                <td>${item.name}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${item.active}">
                                            <span class="text-green-600 font-medium">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-500">Ngừng hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="space-x-2">

                                    <a href="${pageContext.request.contextPath}/manager/categories?id=${item.id}"
                                       class="px-3 py-1 text-sm text-white rounded-lg hover:scale-105 transition"
                                       style="background:#909632;">
                                        Sửa
                                    </a>

                                    <form method="post"
                                          action="${pageContext.request.contextPath}/manager/categories/delete"
                                          class="inline">

                                        <input type="hidden" name="id" value="${item.id}" />

                                        <button onclick="return confirm('Bạn có chắc muốn xóa?')"
                                                class="px-3 py-1 text-sm text-white rounded-lg hover:scale-105 transition"
                                                style="background:#b91c1c;">
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
