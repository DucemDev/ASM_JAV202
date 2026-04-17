<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Lỗi hệ thống</title>

<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative flex items-center justify-center"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- BG -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<!-- CARD -->
<div class="relative z-10 w-full max-w-md rounded-2xl shadow-2xl p-8 text-center backdrop-blur-xl border"
     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

    <!-- ICON -->
    <div class="text-6xl mb-4">
        ⚠️
    </div>

    <!-- TITLE -->
    <c:choose>

        <c:when test="${pageContext.errorData.statusCode == 404}">
            <h1 class="text-2xl font-bold text-[#27301B] mb-2">
                Trang không tồn tại
            </h1>
            <p class="text-gray-600 mb-6">
                Trang bạn tìm kiếm không tồn tại hoặc đã bị xóa
            </p>
        </c:when>

        <c:when test="${pageContext.errorData.statusCode == 403}">
            <h1 class="text-2xl font-bold text-[#27301B] mb-2">
                Không có quyền truy cập
            </h1>
            <p class="text-gray-600 mb-6">
                Bạn không có quyền truy cập vào trang này
            </p>
        </c:when>

        <c:otherwise>
            <h1 class="text-2xl font-bold text-[#27301B] mb-2">
                Lỗi hệ thống
            </h1>
            <p class="text-gray-600 mb-6">
                Đã xảy ra lỗi. Vui lòng thử lại sau
            </p>
        </c:otherwise>

    </c:choose>

    <!-- BUTTON -->
    <a href="${pageContext.request.contextPath}/"
       class="inline-block text-white px-6 py-3 rounded-xl shadow hover:scale-105 transition"
       style="background:#27301B;">
        Về trang chủ
    </a>

</div>

</body>
</html>
