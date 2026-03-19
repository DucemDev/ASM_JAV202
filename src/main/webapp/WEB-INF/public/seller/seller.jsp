<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Seller</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-200">

<div class="p-6">

<!-- HEADER -->
<div class="flex justify-between items-center mb-6">

<h2 class="text-2xl font-bold">Quản lý bàn</h2>

<button
onclick="location.href='create-table'"
class="bg-gray-700 text-white px-5 py-2 rounded-full">
+ tạo bàn mới
</button>

</div>

<!-- GRID -->
<div class="grid grid-cols-5 gap-6">

<c:forEach items="${tables}" var="t">

<div
onclick="location.href='sell?tableId=${t.id}'"
class="h-28 rounded-xl flex items-center justify-center text-white font-bold cursor-pointer

<c:choose>

<c:when test="${t.status == 'empty'}">
bg-green-500
</c:when>

<c:when test="${t.status == 'using'}">
bg-orange-500
</c:when>

<c:otherwise>
bg-red-500
</c:otherwise>

</c:choose>

">

${t.name}

</div>

</c:forEach>

</div>

</div>

</body>
</html>