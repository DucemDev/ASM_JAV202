<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="sidebar"
     class="fixed top-0 left-0 h-screen bg-white border-r border-gray-200 w-64 flex flex-col transition-all duration-300 shadow-lg z-50">

    <!-- LOGO -->

    <div class="flex items-center justify-center py-6 border-b border-gray-100">
        <img src="${pageContext.request.contextPath}/assets/image/logo.png" class="h-9">
    </div>

    <!-- TOGGLE -->

    <div class="flex justify-end px-3 py-2">
        <button onclick="toggleSidebar()"
                class="p-2 rounded-lg hover:bg-cafe-bg transition">


            <svg class="w-5 h-5 text-gray-600"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M4 6h16M4 12h16M4 18h16"/>
            </svg>

        </button>


    </div>

    <!-- MENU -->

    <nav class="flex flex-col px-4 py-4 space-y-2 flex-1 overflow-y-auto">

        <!-- HOME -->

        <a href="${pageContext.request.contextPath}/home"
           class="group flex items-center gap-3 p-3 rounded-xl hover:bg-cafe-bg transition">

            <svg class="w-5 h-5 text-gray-500 group-hover:text-gray-800 transition"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M3 9.75L12 4l9 5.75v9.25A2 2 0 0 1 19 21H5a2 2 0 0 1-2-2z"/>
            </svg>

            <span class="menu-text text-gray-700">Trang chủ</span>

        </a>

        <!-- SELL (STAFF + ADMIN) -->
        <c:set var="sellUrl" value="/seller/tables"/>

        <c:if test="${sessionScope.user != null && (sessionScope.user.role == 0)}">
            <c:set var="sellUrl" value="/seller/tables"/>
        </c:if>

        <a href="${pageContext.request.contextPath}${sellUrl}"
           class="group flex items-center gap-3 p-3 rounded-xl hover:bg-cafe-bg transition">

            <svg class="w-5 h-5 text-gray-500 group-hover:text-gray-800 transition"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M3 3h18v4H3zM5 7v13h14V7"/>
            </svg>

            <span class="menu-text text-gray-700">Bán hàng</span>

        </a>

            <!-- PROFILE -->

            <a href="${pageContext.request.contextPath}/profile"
               class="group flex items-center gap-3 p-3 rounded-xl hover:bg-cafe-bg transition">

                <svg class="w-5 h-5 text-gray-500 group-hover:text-gray-800 transition"
                     fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24">
                    <path d="M12 15a4 4 0 100-8 4 4 0 000 8z"/>
                    <path d="M4 21v-1a7 7 0 0114 0v1"/>
                </svg>

                <span class="menu-text text-gray-700">Cài đặt</span>

            </a>

            <!-- ADMIN -->

            <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}"> <a
                href="${pageContext.request.contextPath}/admin"
                class="group flex items-center gap-3 p-3 rounded-xl hover:bg-cafe-bg transition">

            <svg class="w-5 h-5 text-gray-500 group-hover:text-gray-800 transition"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M5 13l4 4L19 7"/>
            </svg>

            <span class="menu-text text-gray-700">Quản lý</span>

        </a>
            </c:if>

    </nav>

    <!-- LOGOUT -->

    <div class="p-4 border-t border-gray-100">

        <a href="${pageContext.request.contextPath}/logout"
           class="group flex items-center gap-3 p-3 rounded-xl hover:bg-red-50 transition">

            <svg class="w-5 h-5 text-red-400 group-hover:text-red-600 transition"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/>
                <path d="M16 17l5-5-5-5"/>
                <path d="M21 12H9"/>
            </svg>

            <span class="menu-text text-red-400">Đăng xuất</span>

        </a>

    </div>

</div>

<script>
    let collapsed = false;

    function toggleSidebar() {

        const sidebar = document.getElementById("sidebar");
        const text = document.querySelectorAll(".menu-text");
        const main = document.getElementById("mainContent");

        collapsed = !collapsed;

        if (collapsed) {
            sidebar.classList.replace("w-64", "w-20");
            if (main) main.classList.replace("ml-64", "ml-20");
            text.forEach(t => t.classList.add("hidden"));
        } else {
            sidebar.classList.replace("w-20", "w-64");
            if (main) main.classList.replace("ml-20", "ml-64");
            text.forEach(t => t.classList.remove("hidden"));
        }
    }
</script>
