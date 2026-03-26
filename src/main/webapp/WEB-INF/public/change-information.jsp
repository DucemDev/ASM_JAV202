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

<h1 class="text-2xl font-bold text-gray-800 mb-6">
Chỉnh sửa thông tin cá nhân
</h1>

<form method="post" class="space-y-5">

<!-- ID -->
<div>
<label class="text-sm text-gray-500">ID</label>
<input value="${sessionScope.user.id}" name="id" type="text"
class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 bg-gray-100 cursor-not-allowed" readonly>
</div>

<!-- FULLNAME -->
<div>
<label class="text-sm text-gray-500">Họ tên</label>
<input value="${sessionScope.user.fullname}" name="fullname" type="text"
class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-cafe-brown outline-none">
</div>

<!-- EMAIL -->
<div>
<label class="text-sm text-gray-500">Email</label>
<input value="${sessionScope.user.email}" name="email" type="email"
class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-cafe-brown outline-none">
</div>

<!-- PHONE -->
<div>
<label class="text-sm text-gray-500">Số điện thoại</label>
<input value="${sessionScope.user.phone}" name="phone" type="text"
class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-cafe-brown outline-none">
</div>

<!-- ROLE -->
<div>
<label class="text-sm text-gray-500">Vai trò</label>
<input value="${sessionScope.user.role ? 'Admin' : 'Staff'}"
type="text"
class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2 bg-gray-100" readonly>
</div>

<!-- BUTTON -->
<div class="flex gap-4 pt-4">

<button type="submit"
class="bg-cafe-brown text-white px-6 py-2 rounded-lg hover:opacity-90 transition">
Lưu thay đổi
</button>

<a href="${pageContext.request.contextPath}/profile">
<button type="button"
class="bg-gray-500 text-white px-6 py-2 rounded-lg hover:opacity-90 transition">
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