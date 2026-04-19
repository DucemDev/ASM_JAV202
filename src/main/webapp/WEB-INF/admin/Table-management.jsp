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
                    
                    <a href="${pageContext.request.contextPath}/manager/tables"
                       class="px-5 py-2 rounded-xl text-white shadow hover:scale-105 transition flex items-center gap-2"
                       style="background:#6b7280;">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                        </svg>
                        Làm mới
                    </a>
                </div>

                <!-- MESSAGE -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="mb-4 p-3 rounded-xl bg-green-100 text-green-700 shadow-sm border border-green-200">
                        ${sessionScope.message}
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="mb-4 p-3 rounded-xl bg-red-100 text-red-700 shadow-sm border border-red-200">
                        ${sessionScope.error}
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">

                    <!-- FORM -->
                    <div class="lg:col-span-1">
                        <div class="rounded-xl p-6 backdrop-blur-xl border shadow-lg sticky top-8"
                             style="background:rgba(255,255,255,0.35); border-color:rgba(255,255,255,0.4);">

                            <h2 class="text-lg font-semibold text-[#27301B] mb-4 flex items-center gap-2">
                                <span class="w-2 h-6 bg-[#27301B] rounded-full"></span>
                                <c:choose>
                                    <c:when test="${not empty table}">Cập nhật bàn</c:when>
                                    <c:otherwise>Thêm bàn mới</c:otherwise>
                                </c:choose>
                            </h2>

                            <c:set var="formAction" value="${pageContext.request.contextPath}/manager/tables/add"/>
                            <c:if test="${not empty table}">
                                <c:set var="formAction" value="${pageContext.request.contextPath}/manager/tables/edit"/>
                            </c:if>

                            <form action="${formAction}" method="post" class="space-y-5">
                                <c:if test="${not empty table}">
                                    <input type="hidden" name="id" value="${table.id}">
                                </c:if>

                                <div>
                                    <label class="block text-sm font-medium text-[#41521E] mb-2">Tên bàn</label>
                                    <input type="text" name="name"
                                           required
                                           value="${not empty table ? table.name : ''}"
                                           placeholder="Nhập tên bàn..."
                                           class="w-full rounded-lg px-4 py-2.5 border outline-none focus:ring-2 focus:ring-[#909632] transition backdrop-blur-xl"
                                           style="background:rgba(255,255,255,0.4); border-color:#909632;">
                                </div>

                                <div class="flex gap-3 pt-2">
                                    <button type="submit"
                                            class="flex-1 py-2.5 rounded-lg text-white font-semibold hover:scale-105 transition shadow-md"
                                            style="background:#27301B;">
                                        Lưu bàn
                                    </button>

                                    <a href="${pageContext.request.contextPath}/manager/tables"
                                       class="flex-1 py-2.5 rounded-lg bg-white/50 border border-gray-300 text-gray-700 font-semibold text-center hover:bg-white transition">
                                        Hủy
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- TABLE -->
                    <div class="lg:col-span-3">

                        <!-- TAB -->
                        <div class="flex flex-wrap gap-2 mb-6">
                            <a href="?tab=all"
                               class="px-5 py-2 rounded-xl font-medium transition shadow-sm ${empty param.tab || param.tab=='all' ? 'text-white scale-105' : 'hover:bg-white/40'}"
                               style="${empty param.tab || param.tab=='all' ? 'background:#27301B;' : 'background:rgba(255,255,255,0.2); border:1px solid rgba(255,255,255,0.3);'}">
                                Tất cả
                            </a>

                            <a href="?tab=empty"
                               class="px-5 py-2 rounded-xl font-medium transition shadow-sm ${param.tab=='empty' ? 'text-white scale-105' : 'hover:bg-white/40'}"
                               style="${param.tab=='empty' ? 'background:#41521E;' : 'background:rgba(255,255,255,0.2); border:1px solid rgba(255,255,255,0.3);'}">
                                Bàn trống
                            </a>

                            <a href="?tab=occupied"
                               class="px-5 py-2 rounded-xl font-medium transition shadow-sm ${param.tab=='occupied' ? 'text-white scale-105' : 'hover:bg-white/40'}"
                               style="${param.tab=='occupied' ? 'background:#b91c1c;' : 'background:rgba(255,255,255,0.2); border:1px solid rgba(255,255,255,0.3);'}">
                                Đang dùng
                            </a>

                            <a href="?tab=hidden"
                               class="px-5 py-2 rounded-xl font-medium transition shadow-sm ${param.tab=='hidden' ? 'text-white scale-105' : 'hover:bg-white/40'}"
                               style="${param.tab=='hidden' ? 'background:#374151;' : 'background:rgba(255,255,255,0.2); border:1px solid rgba(255,255,255,0.3);'}">
                                Bàn ẩn
                            </a>
                        </div>

                        <!-- TABLE -->
                        <div class="rounded-2xl overflow-hidden backdrop-blur-xl border shadow-xl"
                             style="background:rgba(255,255,255,0.3); border:1px solid rgba(255,255,255,0.35);">

                            <table class="w-full text-sm">

                                <thead style="background:rgba(65,82,30,0.25);" class="text-[#27301B] text-center uppercase tracking-wider">
                                <tr>
                                    <th class="px-6 py-4">STT</th>
                                    <th class="px-6 py-4">Tên bàn</th>
                                    <th class="px-6 py-4">Trạng thái</th>
                                    <th class="px-6 py-4 text-center">Thao tác</th>
                                </tr>
                                </thead>

                                <tbody class="text-center">

                                <c:set var="stt" value="0"/>
                                <c:forEach var="t" items="${list}">
                                    <!-- ẨN BÀN ONLINE ORDERS -->
                                    <c:if test="${!t.name.toLowerCase().contains('online')}">
                                        
                                        <c:set var="showRow" value="false"/>
                                        <c:choose>
                                            <c:when test="${empty param.tab || param.tab == 'all'}">
                                                <c:set var="showRow" value="true"/>
                                            </c:when>
                                            <c:when test="${param.tab == 'empty' && t.active && t.status == 'empty'}">
                                                <c:set var="showRow" value="true"/>
                                            </c:when>
                                            <c:when test="${param.tab == 'occupied' && t.active && (t.status == 'occupied' || t.status == 'using')}">
                                                <c:set var="showRow" value="true"/>
                                            </c:when>
                                            <c:when test="${param.tab == 'hidden' && (!t.active || t.status == 'hidden')}">
                                                <c:set var="showRow" value="true"/>
                                            </c:when>
                                        </c:choose>

                                        <c:if test="${showRow}">
                                            <c:set var="stt" value="${stt + 1}"/>
                                            <tr class="border-t border-white/40 hover:bg-white/20 transition">
                                                <td class="px-6 py-4 font-semibold text-gray-600">${stt}</td>
                                                <td class="px-6 py-4 font-bold text-[#27301B]">${t.name}</td>
                                                <td class="px-6 py-4">
                                                    <c:choose>
                                                        <c:when test="${!t.active || t.status == 'hidden'}">
                                                            <span class="bg-gray-200 text-gray-700 px-3 py-1 text-xs rounded-full font-bold">Ẩn</span>
                                                        </c:when>
                                                        <c:when test="${t.status == 'empty'}">
                                                            <span class="bg-green-100 text-green-700 px-3 py-1 text-xs rounded-full font-bold">Trống</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="bg-red-100 text-red-700 px-3 py-1 text-xs rounded-full font-bold">Đang dùng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4 flex justify-center gap-3">
                                                    <a href="${pageContext.request.contextPath}/manager/tables?id=${t.id}&tab=${param.tab}"
                                                       class="w-16 py-1.5 bg-blue-100 text-blue-700 rounded-lg hover:bg-blue-200 transition text-xs font-bold flex items-center justify-center">
                                                        Sửa
                                                    </a>

                                                    <c:choose>
                                                        <c:when test="${t.active && t.status == 'empty'}">
                                                            <form action="${pageContext.request.contextPath}/manager/tables/hide" method="post" class="inline">
                                                                <input type="hidden" name="id" value="${t.id}">
                                                                <button class="w-16 py-1.5 bg-orange-100 text-orange-700 rounded-lg hover:bg-orange-200 transition text-xs font-bold flex items-center justify-center">
                                                                    Ẩn
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:when test="${!t.active || t.status == 'hidden'}">
                                                            <form action="${pageContext.request.contextPath}/manager/tables/show" method="post" class="inline">
                                                                <input type="hidden" name="id" value="${t.id}">
                                                                <button class="w-16 py-1.5 bg-emerald-100 text-emerald-700 rounded-lg hover:bg-emerald-200 transition text-xs font-bold flex items-center justify-center">
                                                                    Bật
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="w-16 py-1.5 bg-gray-50 text-gray-300 rounded-lg text-xs font-bold flex items-center justify-center cursor-not-allowed opacity-50">
                                                                -
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:if>
                                </c:forEach>

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
