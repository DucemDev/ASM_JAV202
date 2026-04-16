<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang cá nhân - PolyCafe</title>
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

                    <h1 class="text-2xl font-bold text-gray-800 mb-6">Thông tin cá nhân</h1>

                    <div class="grid grid-cols-2 gap-6 text-sm">
                        <div><span class="text-gray-500">Họ tên</span><div class="font-medium text-gray-800 mt-1">${sessionScope.user.fullname}</div></div>
                        <div><span class="text-gray-500">Email</span><div class="font-medium text-gray-800 mt-1">${sessionScope.user.email}</div></div>
                        <div><span class="text-gray-500">Mật khẩu</span><div class="font-medium text-gray-800 mt-1">••••••••</div></div>
                        <div><span class="text-gray-500">Mã người dùng</span><div class="font-medium text-gray-800 mt-1">${sessionScope.user.id}</div></div>
                        <div><span class="text-gray-500">Số điện thoại</span><div class="font-medium text-gray-800 mt-1">${sessionScope.user.phone}</div></div>
                    </div>

                    <div class="mt-8 flex gap-4">
                        <a href="${pageContext.request.contextPath}/change-information" class="btn btn-primary">Chỉnh sửa thông tin</a>
                        <a href="${pageContext.request.contextPath}/change-password" class="btn btn-secondary">Đổi mật khẩu</a>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>