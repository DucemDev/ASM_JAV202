<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>

<head>

<title>Home</title>

<script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-gray-200">

<div class="flex h-screen">

<!-- SIDEBAR -->
<jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>


<!-- RIGHT SIDE -->
<div class="flex-1 flex flex-col">


<!-- HEADER -->
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>


<!-- CONTENT -->
<div class="p-8">

<div class="grid grid-cols-2 gap-6">

<!-- BOX 1 -->
<div class="bg-gray-400 h-40 flex items-center justify-center text-2xl font-bold">

bao nhiêu bàn đang có khách

</div>


<!-- BOX 2 -->
<div class="bg-white border">

<div class="flex justify-end gap-4 p-4">

<button class="bg-gray-700 text-white px-6 py-1 rounded-full">
tìm kiếm
</button>

<button class="bg-gray-700 text-white px-6 py-1 rounded-full">
bộ lọc
</button>

</div>


<table class="w-full border-t text-center">

<tr class="bg-gray-100">

<th class="p-3 border">tên</th>
<th class="p-3 border">ngày tháng</th>
<th class="p-3 border">chi tiết</th>

</tr>

<tr>

<td class="border p-4"></td>
<td class="border"></td>
<td class="border"></td>

</tr>

<tr>

<td class="border p-4"></td>
<td class="border"></td>
<td class="border"></td>

</tr>

</table>

</div>


<!-- BOX 3 -->
<div class="bg-gray-500 h-64 col-span-1"></div>

</div>

</div>

</div>

</div>

</body>

</html>