<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Tables</title>

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

                <!-- 🔥 KHUNG CHÍNH -->
                <div class="bg-white rounded-2xl shadow-lg p-6">

                    <!-- HEADER -->
                    <div class="flex justify-between items-center mb-6">

                        <h2 class="text-xl font-semibold">Danh sách bàn</h2>

                        <!-- ADD -->
                        <form method="post"
                              action="${pageContext.request.contextPath}/seller/tables/add"
                              class="flex gap-2">

                            <input type="text" name="name"
                                   class="border rounded-lg px-3 py-2"
                                   placeholder="Tên bàn" required>

                            <button class="bg-cafe-brown text-white px-4 rounded-lg">
                                + Thêm
                            </button>

                        </form>

                    </div>

                    <!-- 🔍 SEARCH + FILTER -->
                    <div class="flex justify-between items-center mb-6">

                        <!-- SEARCH -->
                        <form method="get"
                              action="${pageContext.request.contextPath}/seller/tables"
                              class="flex gap-2">

                            <input type="text" name="keyword"
                                   value="${param.keyword}"
                                   placeholder="Tìm bàn..."
                                   class="border px-4 py-2 rounded-lg w-60">

                            <button class="bg-cafe-brown text-white px-4 rounded-lg">
                                Tìm
                            </button>

                        </form>

                        <!-- FILTER -->
                        <div class="flex gap-2">

                            <a href="?status=&keyword=${param.keyword}"
                               class="px-4 py-2 rounded-full text-sm shadow
                               ${empty currentStatus ? 'bg-cafe-brown text-white' : 'bg-gray-100'}">
                                Tất cả
                            </a>

                            <a href="?status=empty&keyword=${param.keyword}"
                               class="px-4 py-2 rounded-full text-sm shadow
                               ${currentStatus == 'empty' ? 'bg-green-500 text-white' : 'bg-gray-100'}">
                                Trống
                            </a>

                            <a href="?status=using&keyword=${param.keyword}"
                               class="px-4 py-2 rounded-full text-sm shadow
                               ${currentStatus == 'using' ? 'bg-red-500 text-white' : 'bg-gray-100'}">
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
                                        shadow-sm hover:shadow-md transition

                                        ${t.status == 'empty'
                                            ? 'bg-green-100 border border-green-300'
                                            : 'bg-red-100 border border-red-300'}">

                                        <h3 class="font-semibold text-lg mb-2">${t.name}</h3>

                                        <p class="text-sm">
                                            <c:choose>
                                                <c:when test="${t.status == 'empty'}">
                                                    Trống
                                                </c:when>
                                                <c:otherwise>
                                                    Đang dùng
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