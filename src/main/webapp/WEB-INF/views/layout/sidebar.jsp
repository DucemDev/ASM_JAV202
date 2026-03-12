<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div id="sidebar"
class="h-screen bg-gray-900 text-white transition-all duration-300 w-60 flex flex-col">

<div class="flex justify-end p-3">
<button onclick="toggleSidebar()" class="text-xl">☰</button>
</div>

<nav class="flex flex-col p-4 space-y-2">

<a href="home" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>🏠</span>
<span class="ml-3 menu-text">Trang chủ</span>
</a>

<!-- ADMIN -->
<c:if test="${sessionScope.user.role}">
<a href="categories" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>📂</span>
<span class="ml-3 menu-text">Danh mục</span>
</a>

<a href="drink" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>🥤</span>
<span class="ml-3 menu-text">Đồ uống</span>
</a>

<a href="tables" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>🪑</span>
<span class="ml-3 menu-text">Bàn</span>
</a>

<a href="users" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>👤</span>
<span class="ml-3 menu-text">Nhân viên</span>
</a>

<a href="bills" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>🧾</span>
<span class="ml-3 menu-text">Hóa đơn</span>
</a>

<a href="report" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>📊</span>
<span class="ml-3 menu-text">Thống kê</span>
</a>
</c:if>

<!-- STAFF -->
<c:if test="${!sessionScope.user.role}">
<a href="sell" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>💰</span>
<span class="ml-3 menu-text">Bán hàng</span>
</a>

<a href="tables" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>🪑</span>
<span class="ml-3 menu-text">Bàn</span>
</a>

<a href="bills" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>🧾</span>
<span class="ml-3 menu-text">Hóa đơn</span>
</a>

<a href="history" class="hover:bg-gray-700 p-2 rounded flex items-center">
<span>📜</span>
<span class="ml-3 menu-text">Lịch sử</span>
</a>
</c:if>

</nav>
<!-- LOGOUT -->
<div class="p-4 border-t border-gray-700">

<a href="logout"
class="hover:bg-red-600 p-2 rounded flex items-center">

<span>🚪</span>
<span class="ml-3 menu-text">Đăng xuất</span>

</a>

</div>
</div>

<script>

let collapsed = false;

function toggleSidebar(){

    let sidebar = document.getElementById("sidebar");
    let text = document.querySelectorAll(".menu-text");

    collapsed = !collapsed;

    if(collapsed){

        sidebar.classList.remove("w-60");
        sidebar.classList.add("w-20");

        text.forEach(t => t.style.display = "none");

    }else{

        sidebar.classList.remove("w-20");
        sidebar.classList.add("w-60");

        text.forEach(t => t.style.display = "inline");

    }

}

</script>