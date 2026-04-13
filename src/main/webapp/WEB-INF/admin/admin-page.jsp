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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
tailwind.config = {
    theme: {
        extend: {
            colors: {
                cafe: {
                    bg: '#f6efe7',      // 🔥 đậm hơn nhẹ
                    brown: '#8b5e3c'
                }
            }
        }
    }
}
</script>

</head>

<body class="bg-cafe-bg">

<div class="flex h-screen">

<!-- SIDEBAR -->
<jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

<!-- RIGHT CONTENT -->
<div id="mainContent"
class="flex-1 flex flex-col bg-cafe-bg ml-64 transition-all duration-300">

<!-- HEADER -->
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- CONTENT -->
<div class="p-8">

<div class="bg-white rounded-2xl shadow-lg p-8 border border-gray-200">

<!-- HEADER -->
<div class="flex justify-between items-center mb-5">
    <h1 class="text-lg font-semibold text-gray-800">
        Thống kê
    </h1>
</div>
    <form method="get" class="mb-6 flex gap-3">
        <input type="date" name="fromDate"
               value="${param.fromDate}"
               class="border px-3 py-1 rounded">

        <input type="date" name="toDate"
               value="${param.toDate}"
               class="border px-3 py-1 rounded">

        <button class="bg-cafe-brown text-white px-4 py-1 rounded">
            Lọc
        </button>
    </form>
<!-- MAIN GRID -->
<div class="max-w-[1300px] mx-auto">
<div class="grid grid-cols-3 gap-6">

<!-- LEFT -->
<div class="col-span-2 grid grid-cols-2 gap-6">

<!-- DOANH THU -->
<div class="group bg-gradient-to-br from-white to-[#f1e4d7] border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition">

<div class="flex justify-between items-center">
<span class="text-gray-500 text-sm">Tổng doanh thu</span>

<svg class="w-5 h-5 text-gray-400 group-hover:text-cafe-brown transition"
fill="none" stroke="currentColor" stroke-width="2"
viewBox="0 0 24 24">
<path d="M12 1v22M17 5H9a4 4 0 000 8h6a4 4 0 010 8H7"/>
</svg>
</div>

    <div class="text-2xl font-semibold text-gray-800 mt-4">
        ${totalRevenue} ₫
    </div>

</div>

<!-- HÔM NAY -->
<div class="group bg-gradient-to-br from-white to-[#f1e4d7] border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition">

<div class="flex justify-between items-center">
<span class="text-gray-500 text-sm">Hôm nay</span>

<svg class="w-5 h-5 text-gray-400 group-hover:text-cafe-brown transition"
fill="none" stroke="currentColor" stroke-width="2"
viewBox="0 0 24 24">
<path d="M3 17l6-6 4 4 7-7"/>
</svg>
</div>

    <div class="text-2xl font-semibold text-gray-800 mt-4">
        ${todayRevenue} ₫
    </div>

</div>

<!-- HÓA ĐƠN -->
<div class="group bg-gradient-to-br from-white to-[#f1e4d7] border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition">

<div class="flex justify-between items-center">
<span class="text-gray-500 text-sm">Hóa đơn</span>

<svg class="w-5 h-5 text-gray-400 group-hover:text-cafe-brown transition"
fill="none" stroke="currentColor" stroke-width="2"
viewBox="0 0 24 24">
<path d="M6 2h12v20l-6-3-6 3z"/>
</svg>
</div>

    <div class="text-2xl font-semibold text-gray-800 mt-4">
        ${billCount}
    </div>

</div>

<!-- BÀN -->
<div class="group bg-gradient-to-br from-white to-[#f1e4d7] border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition">

<div class="flex justify-between items-center">
<span class="text-gray-500 text-sm">Bàn đang dùng</span>

<svg class="w-5 h-5 text-gray-400 group-hover:text-cafe-brown transition"
fill="none" stroke="currentColor" stroke-width="2"
viewBox="0 0 24 24">
<path d="M3 10h18M5 10v10M19 10v10"/>
</svg>
</div>

    <div class="text-2xl font-semibold text-gray-800 mt-4">
        ${usingTables}
    </div>

</div>

</div>

<!-- RIGHT -->
<div class="bg-white border border-gray-200 rounded-xl p-6 shadow-sm">
<h2 class="text-sm text-gray-500 mb-4">
Tỷ lệ doanh thu
</h2>
<canvas id="pieChart"></canvas>
</div>

</div>
</div>

<!-- QUICK ACTION (GIỮ NGUYÊN NÚT CỦA BẠN) -->
<div class="mt-10">

<h2 class="text-lg font-semibold text-gray-800 mb-4">
Quản lý
</h2>

<div class="grid grid-cols-4 gap-6">

<!-- NHÂN VIÊN -->
<a href="${pageContext.request.contextPath}/manager/staff"
class="group bg-white border border-gray-200 p-5 rounded-xl text-center shadow-sm hover:shadow-lg hover:-translate-y-1 transition">

<svg class="w-6 h-6 mx-auto text-gray-500 group-hover:text-cafe-brown transition mb-2"
fill="none" stroke="currentColor" stroke-width="2"
viewBox="0 0 24 24">
<path d="M16 14c2 0 4 2 4 4H4c0-2 2-4 4-4"/>
<circle cx="12" cy="8" r="4"/>
</svg>

<div class="text-sm text-gray-700">Quản lý nhân viên</div>

</a>


<!-- LOẠI -->
<a href="${pageContext.request.contextPath}/manager/categories"
class="group bg-white border border-gray-200 p-5 rounded-xl text-center shadow-sm hover:shadow-lg hover:-translate-y-1 transition">

<svg class="w-6 h-6 mx-auto text-gray-500 group-hover:text-cafe-brown transition mb-2"
fill="none" stroke="currentColor" stroke-width="2"
viewBox="0 0 24 24">
<path d="M3 7h18M3 12h18M3 17h18"/>
</svg>

<div class="text-sm text-gray-700">Quản lý loại</div>

</a>



<!-- ĐỒ UỐNG -->
<a href="${pageContext.request.contextPath}/manager/drinks"
class="group bg-white border border-gray-200 p-5 rounded-xl text-center shadow-sm hover:shadow-lg hover:-translate-y-1 transition">


<svg class="w-6 h-6 mx-auto text-gray-500 group-hover:text-cafe-brown transition mb-2"
fill="none" stroke="currentColor" stroke-width="2"
viewBox="0 0 24 24">
<path d="M8 2h8l-1 8H9z"/>
<path d="M9 10h6v10H9z"/>
</svg>

<div class="text-sm text-gray-700">Quản lý đồ uống</div>

</a>


<!-- HÓA ĐƠN -->
<a href="${pageContext.request.contextPath}/bills"
class="group bg-white border border-gray-200 p-5 rounded-xl text-center shadow-sm hover:shadow-lg hover:-translate-y-1 transition">

<svg class="w-6 h-6 mx-auto text-gray-500 group-hover:text-cafe-brown transition mb-2"
fill="none" stroke="currentColor" stroke-width="2"
viewBox="0 0 24 24">
<path d="M6 2h12v20l-6-3-6 3z"/>
</svg>

<div class="text-sm text-gray-700">Quản lý hóa đơn</div>

</a>

</div>

</div>

</div>
</div>

</div>

</div>

<script>
    const labels = [<c:forEach var="c" items="${chartData}">
        '${c.name}',
        </c:forEach>];

    const data = [<c:forEach var="c" items="${chartData}">
        ${c.value},
        </c:forEach>];

    new Chart(document.getElementById('pieChart'), {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: ['#8b5e3c','#d6bfa9','#f1e4d7','#c4a484'],
                borderWidth: 0
            }]
        },
        options: {
            plugins: { legend: { position: 'bottom' } },
            cutout: '70%'
        }
    });
</script>

</body>
</html>