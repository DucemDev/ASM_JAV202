<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">
<title>Admin Dashboard</title>

<script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-gray-200">

<div class="flex h-screen">

<!-- SIDEBAR -->
<jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>


<!-- RIGHT CONTENT -->
<div class="flex-1 flex flex-col">

<!-- HEADER -->
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>


<!-- CONTENT -->
<div class="p-8">

<h1 class="text-3xl font-bold text-gray-800 mb-6">
Dashboard Admin
</h1>


<!-- DASHBOARD -->
<div class="grid grid-cols-4 gap-6">

<!-- TOTAL REVENUE -->
<div class="bg-white shadow rounded-lg p-6">

<div class="text-gray-500">
Tổng doanh thu
</div>

<div class="text-3xl font-bold text-green-600 mt-2">
0 ₫
</div>

</div>



<!-- TODAY REVENUE -->
<div class="bg-white shadow rounded-lg p-6">

<div class="text-gray-500">
Doanh thu hôm nay
</div>

<div class="text-3xl font-bold text-blue-600 mt-2">
0 ₫
</div>

</div>



<!-- TOTAL BILL -->
<div class="bg-white shadow rounded-lg p-6">

<div class="text-gray-500">
Tổng hóa đơn
</div>

<div class="text-3xl font-bold text-purple-600 mt-2">
0
</div>

</div>



<!-- TABLE USING -->
<div class="bg-white shadow rounded-lg p-6">

<div class="text-gray-500">
Bàn đang sử dụng
</div>

<div class="text-3xl font-bold text-red-600 mt-2">
0
</div>

</div>

</div>



<!-- QUICK ACTION -->
<div class="mt-10">

<h2 class="text-xl font-semibold mb-4">
Quản lý hệ thống
</h2>


<div class="grid grid-cols-4 gap-6">

<a href="users"
class="bg-white shadow p-6 rounded-lg text-center hover:bg-gray-50">

<div class="text-4xl mb-2">👤</div>
<div>Quản lý nhân viên</div>

</a>


<a href="categories"
class="bg-white shadow p-6 rounded-lg text-center hover:bg-gray-50">

<div class="text-4xl mb-2">📂</div>
<div>Loại đồ uống</div>

</a>


<a href="drink"
class="bg-white shadow p-6 rounded-lg text-center hover:bg-gray-50">

<div class="text-4xl mb-2">☕</div>
<div>Đồ uống</div>

</a>


<a href="bills"
class="bg-white shadow p-6 rounded-lg text-center hover:bg-gray-50">

<div class="text-4xl mb-2">🧾</div>
<div>Hóa đơn</div>

</a>

</div>

</div>

</div>

</div>

</div>

</body>
</html>