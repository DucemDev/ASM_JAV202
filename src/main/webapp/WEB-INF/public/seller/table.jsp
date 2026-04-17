<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Danh sách bàn</title>

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
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <!-- MAIN -->
    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <!-- CONTENT -->
        <div class="p-8">

            <div class="max-w-[1400px] mx-auto">

                <!-- CARD -->
                <div class="rounded-2xl shadow-2xl p-6 backdrop-blur-xl border"
                     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

                    <!-- HEADER -->
                    <div class="flex justify-between items-center mb-6">

                        <h2 class="text-2xl font-bold text-[#27301B]">
                            Danh sách bàn
                        </h2>

                        <!-- ADD -->
                        <form method="post"
                              action="${pageContext.request.contextPath}/seller/tables/add"
                              class="flex gap-2">

                            <input type="text" name="name"
                                   class="rounded-lg px-3 py-2 border backdrop-blur-xl"
                                   style="background:rgba(255,255,255,0.4); border-color:#909632;"
                                   placeholder="Tên bàn" required>

                            <button class="text-white px-4 rounded-lg shadow hover:scale-105 transition"
                                    style="background:#27301B;">
                                + Thêm
                            </button>

                        </form>

                    </div>

                    <!-- SEARCH + FILTER -->
                    <div class="flex justify-between items-center mb-6">

                        <!-- SEARCH -->
                        <form method="get"
                              action="${pageContext.request.contextPath}/seller/tables"
                              class="flex gap-2">

                            <input type="text" name="keyword"
                                   value="${param.keyword}"
                                   placeholder="Tìm bàn..."
                                   class="rounded-lg px-4 py-2 border backdrop-blur-xl w-60"
                                   style="background:rgba(255,255,255,0.4); border-color:#909632;">

                            <button class="text-white px-4 rounded-lg shadow"
                                    style="background:#41521E;">
                                Tìm kiếm
                            </button>

                        </form>

                        <!-- FILTER -->
                        <div class="flex gap-2">

                            <a href="?status=&keyword=${param.keyword}"
                               class="px-4 py-2 rounded-full text-sm shadow transition
                               ${empty currentStatus ? 'text-white' : ''}"
                               style="${empty currentStatus ? 'background:#27301B;' : 'background:#e5e7eb;'}">
                                Tất cả
                            </a>

                            <a href="?status=empty&keyword=${param.keyword}"
                               class="px-4 py-2 rounded-full text-sm shadow transition
                               ${currentStatus == 'empty' ? 'text-white' : ''}"
                               style="${currentStatus == 'empty' ? 'background:#22c55e;' : 'background:#e5e7eb;'}">
                                Trống
                            </a>

                            <a href="?status=using&keyword=${param.keyword}"
                               class="px-4 py-2 rounded-full text-sm shadow transition
                               ${currentStatus == 'using' ? 'text-white' : ''}"
                               style="${currentStatus == 'using' ? 'background:#ef4444;' : 'background:#e5e7eb;'}">
                                Đang dùng
                            </a>

                        </div>

                    </div>

                    <!-- GRID -->
                    <div class="grid grid-cols-5 gap-5">

                        <c:forEach var="t" items="${tables}">

                            <div class="relative">

                                <!-- HIDE -->
                                <c:if test="${t.status == 'empty'}">
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/seller/tables/hide"
                                          class="absolute top-2 right-2 z-10">

                                        <input type="hidden" name="id" value="${t.id}"/>
                                        <input type="hidden" name="status" value="${t.status}"/>

                                        <button class="text-gray-400 hover:text-red-500 text-lg">×</button>
                                    </form>
                                </c:if>

                                <!-- CARD -->
                                <a href="${pageContext.request.contextPath}/seller/order?tableId=${t.id}">

                                    <div class="aspect-square rounded-xl flex flex-col justify-center items-center text-center
                                        shadow-lg hover:shadow-2xl hover:scale-105 transition backdrop-blur-xl border"

                                        style="${t.status == 'empty'
                                            ? 'background:rgba(220,252,231,0.6); border-color:#86efac;'
                                            : 'background:rgba(254,226,226,0.6); border-color:#fca5a5;'}">

                                        <h3 class="font-bold text-lg mb-2 text-[#27301B]">
                                            ${t.name}
                                        </h3>

                                        <p class="text-sm font-medium">

                                            <c:choose>
                                                <c:when test="${t.status == 'empty'}">
                                                    <span class="text-green-600">Trống</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-red-500">Đang dùng</span>
                                                </c:otherwise>
                                            </c:choose>

                                        </p>

                                    </div>

                                </a>

                            </div>

                        </c:forEach>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>