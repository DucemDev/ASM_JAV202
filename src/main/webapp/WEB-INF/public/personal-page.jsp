<%@ page contentType="text/html; charset=UTF-8"
          pageEncoding="UTF-8"
          isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Trang cá nhân</title>

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

<!-- CARD -->
<div class="bg-white rounded-2xl shadow-lg p-8 border border-gray-200">

<!-- TITLE -->
<h1 class="text-2xl font-bold text-gray-800 mb-6">
Thông tin cá nhân
</h1>

<!-- INFO GRID -->
<div class="grid grid-cols-2 gap-6 text-sm">

<div>
<span class="text-gray-500">Họ tên</span>
<div class="font-medium text-gray-800 mt-1">
${sessionScope.user.fullname}
</div>
</div>

<div>
<span class="text-gray-500">Email</span>
<div class="font-medium text-gray-800 mt-1">
${sessionScope.user.email}
</div>
</div>

<div>
<span class="text-gray-500">Mật khẩu</span>
<div class="font-medium text-gray-800 mt-1">
••••••••
</div>
</div>

<div>
<span class="text-gray-500">ID</span>
<div class="font-medium text-gray-800 mt-1">
${sessionScope.user.id}
</div>
</div>

<div>
<span class="text-gray-500">Số điện thoại</span>
<div class="font-medium text-gray-800 mt-1">
${sessionScope.user.phone}
</div>
</div>

</div>

<!-- ACTION -->
<div class="mt-8 flex gap-4">

<a href="${pageContext.request.contextPath}/change-information">

<button class="bg-cafe-brown text-white px-6 py-2 rounded-lg hover:opacity-90 transition">
Chỉnh sửa thông tin
</button>

</a>

<button class="bg-gray-700 text-white px-6 py-2 rounded-lg hover:opacity-90 transition">
Đổi mật khẩu
</button>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>