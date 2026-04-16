<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu - PolyCafe</title>
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
                    <h1 class="text-2xl font-bold text-gray-800 mb-6">Đổi mật khẩu</h1>

                    <form method="post"
                          action="${pageContext.request.contextPath}/change-password"
                          class="space-y-5"
                          data-disable-on-submit="true">

                        <div>
                            <label class="text-sm text-gray-500">Mật khẩu mới</label>
                            <input type="password" name="newPassword"
                                   placeholder="Nhập mật khẩu mới"
                                   class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 outline-none">
                        </div>

                        <div>
                            <label class="text-sm text-gray-500">Xác nhận mật khẩu mới</label>
                            <input type="password" name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu mới"
                                   class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 outline-none">
                        </div>

                        <c:if test="${not empty message}">
                            <p class="text-red-500 text-sm">${message}</p>
                        </c:if>

                        <div class="flex gap-4 pt-4">
                            <button type="submit" class="btn btn-primary">Cập nhật mật khẩu</button>
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