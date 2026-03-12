<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div id="sidebar"
class="h-screen bg-gray-800 text-white transition-all duration-300 w-64 flex flex-col">

<!-- LOGO -->
<div class="flex items-center justify-center py-4 border-b border-gray-700">
    <img src="${pageContext.request.contextPath}/assets/image/logo.png" class="h-8">
</div>

<!-- TOGGLE -->
<div class="flex justify-end p-3">
    <button onclick="toggleSidebar()" class="text-xl">☰</button>
</div>

<!-- MENU -->
<nav class="flex flex-col px-4 space-y-2 flex-1">

<!-- HOME -->
<a href="home"
class="flex items-center p-2 rounded hover:bg-gray-700">

<span class="text-xl">🏠</span>
<span class="ml-3 menu-text">Trang chủ</span>

</a>


<!-- SELL -->
<a href="sell"
class="flex items-center p-2 rounded hover:bg-gray-700">

<span class="text-xl">☕</span>
<span class="ml-3 menu-text">Bán hàng</span>

</a>


<!-- PROFILE -->
<a href="profile"
class="flex items-center p-2 rounded hover:bg-gray-700">

<span class="text-xl">⚙</span>
<span class="ml-3 menu-text">Cài đặt cá nhân</span>

</a>


<!-- ADMIN ONLY -->
<c:if test="${sessionScope.user.role == true}">

<a href="admin"
class="flex items-center p-2 rounded hover:bg-gray-700">

<span class="text-xl">👤</span>
<span class="ml-3 menu-text">Trang quản lý</span>

</a>

</c:if>

</nav>


<!-- LOGOUT -->
<div class="p-4 border-t border-gray-700">

<a href="logout"
class="flex items-center p-2 rounded hover:bg-red-600">

<span class="text-xl">🚪</span>
<span class="ml-3 menu-text">Đăng xuất</span>

</a>

</div>

</div>


<script>

let collapsed = false;

function toggleSidebar(){

    const sidebar = document.getElementById("sidebar");
    const text = document.querySelectorAll(".menu-text");

    collapsed = !collapsed;

    if(collapsed){

        sidebar.classList.remove("w-64");
        sidebar.classList.add("w-20");

        text.forEach(t => t.style.display = "none");

    }else{

        sidebar.classList.remove("w-20");
        sidebar.classList.add("w-64");

        text.forEach(t => t.style.display = "inline");

    }

}

</script>