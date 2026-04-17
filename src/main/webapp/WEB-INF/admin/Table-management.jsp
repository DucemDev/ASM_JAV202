<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bàn</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

    <jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

    <div id="mainContent"
         class="flex-1 flex flex-col ml-64 transition-all duration-300 h-screen overflow-y-auto">

        <jsp:include page="/WEB-INF/public/layout/header.jsp"/>

        <div class="p-8">
            <div class="rounded-2xl shadow-2xl p-8 border backdrop-blur-xl"
                 style="background:rgba(255,255,255,0.28); border:1px solid rgba(255,255,255,0.35);">

                <!-- HEADER -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-[#27301B]">Quản lý bàn</h1>


                </div>

                <!-- MESSAGE -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="mb-4 p-3 rounded-xl bg-green-100 text-green-700">
                        ${sessionScope.message}
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="mb-4 p-3 rounded-xl bg-red-100 text-red-700">
                        ${sessionScope.error}
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

                    <!-- FORM -->
                    <div class="lg:col-span-1">
                        <div class="rounded-xl p-5 backdrop-blur-xl border shadow"
                             style="background:rgba(255,255,255,0.35); border-color:#ddd;">

                            <h2 class="text-lg font-semibold text-[#27301B] mb-4">
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
                                    <label class="block text-sm text-[#41521E] mb-1">Tên bàn</label>
                                    <input type="text" name="name"
                                           value="${not empty table ? table.name : ''}"
                                           class="w-full rounded-lg px-3 py-2 border backdrop-blur-xl"
                                           style="background:rgba(255,255,255,0.4); border-color:#909632;">
                                </div>

                                <div class="flex gap-3">
                                    <button type="submit"
                                            class="px-4 py-2 rounded-lg text-white hover:scale-105 transition"
                                            style="background:#27301B;">
                                        Lưu
                                    </button>

                                    <a href="${pageContext.request.contextPath}/manager/tables"
                                       class="px-4 py-2 rounded-lg bg-gray-200">
                                        Hủy
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- TABLE -->
                    <div class="lg:col-span-2">

                        <!-- TAB -->
                        <div class="flex gap-3 mb-4">
                            <a href="?tab=empty"
                               class="px-4 py-2 rounded-xl transition ${empty param.tab || param.tab=='empty' ? 'text-white' : ''}"
                               style="${empty param.tab || param.tab=='empty' ? 'background:#41521E;' : 'background:#dfe6c3;'}">
                                Bàn trống
                            </a>

                            <a href="?tab=occupied"
                               class="px-4 py-2 rounded-xl transition ${param.tab=='occupied' ? 'text-white' : ''}"
                               style="${param.tab=='occupied' ? 'background:#b91c1c;' : 'background:#f2d2d2;'}">
                                Đang dùng
                            </a>

                            <a href="?tab=hidden"
                               class="px-4 py-2 rounded-xl transition ${param.tab=='hidden' ? 'text-white' : ''}"
                               style="${param.tab=='hidden' ? 'background:#374151;' : 'background:#e5e7eb;'}">
                                Bàn ẩn
                            </a>
                        </div>

                        <!-- TABLE -->
                        <div class="rounded-xl overflow-hidden backdrop-blur-xl border shadow"
                             style="background:rgba(255,255,255,0.3); border:1px solid rgba(255,255,255,0.3);">

                            <table class="min-w-full">

                                <thead style="background:rgba(65,82,30,0.25);" class="text-[#27301B]">
                                <tr>
                                    <th class="px-4 py-3 text-left">ID</th>
                                    <th class="px-4 py-3 text-left">Tên bàn</th>
                                    <th class="px-4 py-3 text-left">Trạng thái</th>
                                    <th class="px-4 py-3 text-left">Thao tác</th>
                                </tr>
                                </thead>

                                <tbody>

                                <!-- EMPTY -->
                                <c:if test="${empty param.tab || param.tab=='empty'}">
                                    <c:forEach var="t" items="${list}">
                                        <c:if test="${t.active && t.status=='empty'}">
                                            <tr class="border-t border-white/30 hover:bg-white/15 transition">
                                                <td class="px-4 py-3">${t.id}</td>
                                                <td class="px-4 py-3 font-medium">${t.name}</td>
                                                <td class="px-4 py-3">
                                                    <span class="bg-green-100 px-3 py-1 text-xs rounded-full">
                                                        Trống
                                                    </span>
                                                </td>
                                                <td class="px-4 py-3">
                                                    <a href="${pageContext.request.contextPath}/manager/tables?id=${t.id}"
                                                       class="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg">
                                                        Sửa
                                                    </a>

                                                    <form action="${pageContext.request.contextPath}/manager/tables/hide"
                                                          method="post" class="inline">
                                                        <input type="hidden" name="id" value="${t.id}">
                                                        <button class="ml-2 text-[#909632] font-medium">
                                                            Ẩn
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:if>

                                <!-- OCCUPIED -->
                                <c:if test="${param.tab=='occupied'}">
                                    <c:forEach var="t" items="${list}">
                                        <c:if test="${t.active && (t.status=='occupied' || t.status=='using')}">
                                            <tr class="border-t border-white/30 hover:bg-white/15 transition">
                                                <td class="px-4 py-3">${t.id}</td>
                                                <td class="px-4 py-3 font-medium">${t.name}</td>
                                                <td class="px-4 py-3">
                                                    <span class="bg-red-100 px-3 py-1 text-xs rounded-full">
                                                        Đang dùng
                                                    </span>
                                                </td>
                                                <td class="px-4 py-3">-</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:if>

                                <!-- HIDDEN -->
                                <c:if test="${param.tab=='hidden'}">
                                    <c:forEach var="t" items="${list}">
                                        <c:if test="${!t.active || t.status=='hidden'}">
                                            <tr class="border-t border-white/30 hover:bg-white/15 transition">
                                                <td class="px-4 py-3">${t.id}</td>
                                                <td class="px-4 py-3 font-medium">${t.name}</td>
                                                <td class="px-4 py-3">
                                                    <span class="bg-gray-200 px-3 py-1 text-xs rounded-full">
                                                        Ẩn
                                                    </span>
                                                </td>
                                                <td class="px-4 py-3">
                                                    <form action="${pageContext.request.contextPath}/manager/tables/show"
                                                          method="post" class="inline">
                                                        <input type="hidden" name="id" value="${t.id}">
                                                        <button class="text-gray-700 font-medium">
                                                            Bật
                                                        </button>
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
