<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa thông tin - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
</head>

<body class="app-bg">
<div class="flex">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="flex-1 flex flex-col">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">
            <div class="max-w-[1400px] mx-auto">
                <div class="bg-white rounded-2xl shadow-lg p-8 border border-gray-200">

                    <h1 class="text-2xl font-bold text-gray-800 mb-6">Chỉnh sửa thông tin cá nhân</h1>

                    <c:if test="${sessionScope.message != null}">
                        <div class="mb-4 p-3 rounded-lg bg-red-100 text-red-700">
                            ${sessionScope.message}
                        </div>
                        <c:remove var="message" scope="session"/>
                    </c:if>

                    <form method="post" action="<c:url value='/change-information/save'/>" class="space-y-5" data-disable-on-submit="true">

                        <div>
                            <label class="text-sm text-gray-500">Mã người dùng</label>
                            <input value="${sessionScope.user.id}" name="id" type="text"
                                   class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 bg-gray-100 cursor-not-allowed" readonly>
                        </div>

                        <div>
                            <label class="text-sm text-gray-500">Họ tên</label>
                            <input value="${sessionScope.user.fullname}" name="fullname" type="text"
                                   class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 outline-none">
                        </div>

                        <div>
                            <label class="text-sm text-gray-500">Email</label>
                            <input value="${sessionScope.user.email}" name="email" type="email"
                                   class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 outline-none">
                        </div>

                        <div>
                            <label class="text-sm text-gray-500">Số điện thoại</label>
                            <input value="${sessionScope.user.phone}" name="phone" type="text"
                                   class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 outline-none">
                        </div>

                        <div>
                            <label class="text-sm text-gray-500">Vai trò</label>
                            <input
                                value="<c:choose><c:when test='${sessionScope.user.role == 2}'>Quản trị viên</c:when><c:when test='${sessionScope.user.role == 1}'>Nhân viên</c:when><c:otherwise>Khách hàng</c:otherwise></c:choose>"
                                type="text"
                                class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 bg-gray-100"
                                readonly>
                        </div>

                        <div class="flex gap-4 pt-4">
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-secondary">Quay lại</a>
                        </div>

                    </form>

                </div>
            </div>
        </div>

    </div>
</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>