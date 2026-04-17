<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>

<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa thông tin</title>

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

            <div class="max-w-[700px] mx-auto">

                <!-- CARD -->
                <div class="rounded-2xl shadow-2xl p-8 border backdrop-blur-xl"
                     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

                    <!-- TITLE -->
                    <h1 class="text-2xl font-bold text-[#27301B] mb-8 text-center">
                        Chỉnh sửa thông tin cá nhân
                    </h1>

                    <!-- MESSAGE -->
                    <c:if test="${sessionScope.message != null}">
                        <div class="mb-4 p-3 rounded-lg bg-red-100 text-red-700 text-sm">
                            ${sessionScope.message}
                        </div>
                        <c:remove var="message" scope="session"/>
                    </c:if>

                    <!-- FORM -->
                    <form method="post" action="<c:url value='/change-information/save'/>" class="space-y-5">

                        <!-- ID -->
                        <div>
                            <label class="text-sm text-[#909632]">ID</label>
                            <input value="${sessionScope.user.id}" name="id" type="text"
                                   class="w-full mt-1 rounded-lg px-3 py-2 bg-gray-100 cursor-not-allowed border"
                                   readonly>
                        </div>

                        <!-- FULLNAME -->
                        <div>
                            <label class="text-sm text-[#909632]">Họ tên</label>
                            <input value="${sessionScope.user.fullname}" name="fullname" type="text"
                                   class="w-full mt-1 rounded-lg px-3 py-2 border focus:ring-2 outline-none"
                                   style="background:rgba(255,255,255,0.4); border-color:#909632;">
                        </div>

                        <!-- EMAIL -->
                        <div>
                            <label class="text-sm text-[#909632]">Email</label>
                            <input value="${sessionScope.user.email}" name="email" type="email"
                                   class="w-full mt-1 rounded-lg px-3 py-2 border focus:ring-2 outline-none"
                                   style="background:rgba(255,255,255,0.4); border-color:#909632;">
                        </div>

                        <!-- PHONE -->
                        <div>
                            <label class="text-sm text-[#909632]">Số điện thoại</label>
                            <input value="${sessionScope.user.phone}" name="phone" type="text"
                                   class="w-full mt-1 rounded-lg px-3 py-2 border focus:ring-2 outline-none"
                                   style="background:rgba(255,255,255,0.4); border-color:#909632;">
                        </div>

                        <!-- ROLE -->
                        <div>
                            <label class="text-sm text-[#909632]">Vai trò</label>
                            <input
                                    value="<c:choose>
            <c:when test='${sessionScope.user.role == 2}'>Quản trị</c:when>
            <c:when test='${sessionScope.user.role == 1}'>Nhân viên</c:when>
            <c:otherwise>Khách hàng</c:otherwise>
       </c:choose>"
                                    type="text"
                                    class="w-full mt-1 rounded-lg px-3 py-2 bg-gray-100 border"
                                    readonly>
                        </div>

                        <!-- BUTTON -->
                        <div class="flex gap-4 pt-4 justify-center">

                            <button type="submit"
                                    class="text-white px-6 py-2 rounded-xl shadow-lg hover:scale-105 transition"
                                    style="background:#27301B;">
                                Lưu thay đổi
                            </button>

                            <a href="${pageContext.request.contextPath}/profile">
                                <button type="button"
                                        class="text-white px-6 py-2 rounded-xl shadow-lg hover:scale-105 transition"
                                        style="background:#41521E;">
                                    Quay lại
                                </button>
                            </a>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>