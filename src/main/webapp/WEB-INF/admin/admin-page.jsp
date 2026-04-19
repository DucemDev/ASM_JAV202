<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<title>Dashboard | PolyCafe</title>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body class="min-h-screen relative overflow-hidden"
      style="
      background:
      linear-gradient(135deg,#e6e8dc,#cfd5a5);
      ">

<!-- TEXTURE OVERLAY -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="
     background-image:url('https://grainy-gradients.vercel.app/noise.svg');
     "></div>

<div class="flex h-screen relative z-10">

<jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

<div id="mainContent"
class="flex-1 flex flex-col ml-64 transition-all duration-300">

<jsp:include page="/WEB-INF/public/layout/header.jsp"/>

<div class="p-8 overflow-auto">

<!-- TITLE -->
<div class="mb-8">
    <h1 class="text-3xl font-bold text-[#27301B]">
        Dashboard
    </h1>
    <p class="text-[#41521E]">
        Tổng quan hoạt động quán
    </p>
</div>

<!-- FILTER -->
<form method="get" class="mb-8 flex gap-3">

    <input type="date" name="fromDate"
           value="${param.fromDate}"
           class="px-4 py-2 rounded-xl border backdrop-blur-xl"
           style="
           background:rgba(255,255,255,0.25);
           border-color:rgba(255,255,255,0.4);
           ">

    <input type="date" name="toDate"
           value="${param.toDate}"
           class="px-4 py-2 rounded-xl border backdrop-blur-xl"
           style="
           background:rgba(255,255,255,0.25);
           border-color:rgba(255,255,255,0.4);
           ">

    <button class="px-6 py-2 rounded-xl text-white font-semibold shadow-lg transition hover:scale-105"
            style="background:linear-gradient(135deg,#27301B,#41521E);">
        Lọc
    </button>

</form>

<!-- CARDS -->
<div class="grid grid-cols-4 gap-6">

<div class="p-6 rounded-2xl shadow-xl backdrop-blur-xl border hover:scale-105 transition"
     style="
     background:rgba(255,255,255,0.25);
     border:1px solid rgba(255,255,255,0.3);
     ">
    <p class="text-[#909632]">Tổng doanh thu</p>
    <h2 class="text-3xl font-bold text-[#27301B] mt-2">
        ${String.format("%,d", totalRevenue).replace(",", ".")} ₫
    </h2>
</div>

<div class="p-6 rounded-2xl shadow-xl backdrop-blur-xl border hover:scale-105 transition"
     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
    <p class="text-[#909632]">Hôm nay</p>
    <h2 class="text-3xl font-bold text-[#27301B] mt-2">
        ${String.format("%,d", todayRevenue).replace(",", ".")} ₫
    </h2>
</div>

<div class="p-6 rounded-2xl shadow-xl backdrop-blur-xl border hover:scale-105 transition"
     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
    <p class="text-[#909632]">Hóa đơn</p>
    <h2 class="text-3xl font-bold text-[#27301B] mt-2">
        ${billCount}
    </h2>
</div>

<div class="p-6 rounded-2xl shadow-xl backdrop-blur-xl border hover:scale-105 transition"
     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
    <p class="text-[#909632]">Bàn đang dùng</p>
    <h2 class="text-3xl font-bold text-[#27301B] mt-2">
        ${usingTables}
    </h2>
</div>

</div>

<!-- CHART -->
<div class="grid grid-cols-3 gap-6 mt-10">

<div class="col-span-2 p-6 rounded-2xl shadow-xl backdrop-blur-xl border"
     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
    <h2 class="text-lg font-semibold mb-4 text-[#27301B]">
        Doanh thu
    </h2>
    <canvas id="revenueChart"></canvas>
</div>

<div class="p-6 rounded-2xl shadow-xl backdrop-blur-xl border"
     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
    <h2 class="text-lg font-semibold mb-4 text-[#27301B]">
        Top đồ uống
    </h2>
    <canvas id="pieChart"></canvas>
</div>

</div>

<!-- QUICK -->
<div class="mt-10">
<h2 class="text-lg font-semibold mb-4 text-[#27301B]">
Quản lý nhanh
</h2>

<div class="grid grid-cols-5 gap-6">

<a href="${pageContext.request.contextPath}/manager/staff"
class="p-5 rounded-xl backdrop-blur-xl border shadow-xl hover:scale-105 transition text-center"
style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
Nhân viên
</a>

<a href="${pageContext.request.contextPath}/manager/categories"
class="p-5 rounded-xl backdrop-blur-xl border shadow-xl hover:scale-105 transition text-center"
style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
Loại
</a>

<a href="${pageContext.request.contextPath}/manager/tables"
class="p-5 rounded-xl backdrop-blur-xl border shadow-xl hover:scale-105 transition text-center"
style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
Bàn
</a>

<a href="${pageContext.request.contextPath}/manager/drinks"
class="p-5 rounded-xl backdrop-blur-xl border shadow-xl hover:scale-105 transition text-center"
style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
Đồ uống
</a>

<a href="${pageContext.request.contextPath}/manager/bill"
class="p-5 rounded-xl backdrop-blur-xl border shadow-xl hover:scale-105 transition text-center"
style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">
Hóa đơn
</a>

</div>
</div>

</div>
</div>
</div>

<script>
const revenueData = ${revenueData != null ? revenueData : "[]"} || [];
const labels = revenueData.map(e => e.x);
const values = revenueData.map(e => e.y);

new Chart(document.getElementById('revenueChart'), {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            data: values,
            backgroundColor: '#41521E',
            borderRadius: 10
        }]
    },
    options: { plugins: { legend: { display: false } } }
});

new Chart(document.getElementById('pieChart'), {
    type: 'doughnut',
    data: {
        labels: ${labels != null ? labels : "['No data']"},
        datasets: [{
            data: ${data != null ? data : "[1]"},
            backgroundColor: [
                '#27301B','#41521E','#909632','#99A558','#DDDAA8'
            ]
        }]
    }
});
</script>

</body>
</html>
