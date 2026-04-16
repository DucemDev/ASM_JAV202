<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi hệ thống - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
</head>
<body class="app-bg min-h-screen flex items-center justify-center p-4">

<div class="bg-white rounded-2xl shadow-lg p-8 w-full max-w-xl text-center">
    <div class="text-5xl mb-4">⚠️</div>

    <c:choose>
        <c:when test="${pageContext.errorData.statusCode == 404}">
            <h1 class="text-2xl font-bold text-gray-800 mb-2">Không tìm thấy trang</h1>
            <p class="text-gray-600 mb-6">Trang bạn truy cập không tồn tại hoặc đã bị di chuyển.</p>
        </c:when>

        <c:when test="${pageContext.errorData.statusCode == 403}">
            <h1 class="text-2xl font-bold text-gray-800 mb-2">Không có quyền truy cập</h1>
            <p class="text-gray-600 mb-6">Bạn không có quyền xem nội dung này.</p>
        </c:when>

        <c:otherwise>
            <h1 class="text-2xl font-bold text-gray-800 mb-2">Đã xảy ra lỗi hệ thống</h1>
            <p class="text-gray-600 mb-6">Vui lòng thử lại sau hoặc liên hệ quản trị viên.</p>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Quay về trang chủ</a>
</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>