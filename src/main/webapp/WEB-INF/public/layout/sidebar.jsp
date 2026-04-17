<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div id="sidebar"
     class="fixed top-0 left-0 h-screen w-64 flex flex-col transition-all duration-300 shadow-2xl z-50"
     style="background:#27301B; color:#DDDAA8;">

    <!-- LOGO -->
    <div class="flex items-center justify-center py-6 border-b border-[#99A558]/20">
        <img src="${pageContext.request.contextPath}/assets/image/logo.png" class="h-10">
    </div>

    <!-- TOGGLE -->
    <div class="flex justify-end px-3 py-2">
        <button onclick="toggleSidebar()"
                class="p-2 rounded-lg transition hover:bg-[#909632]/40">
            <svg class="w-5 h-5" style="color:#DDDAA8"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M4 6h16M4 12h16M4 18h16"/>
            </svg>
        </button>
    </div>

    <!-- MENU -->
    <nav class="flex flex-col px-3 py-4 space-y-2 flex-1 overflow-y-auto">

        <c:set var="homeUrl" value="/home"/>
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 0}">
            <c:set var="homeUrl" value="/customer"/>
        </c:if>

        <!-- ITEM -->
        <a href="${pageContext.request.contextPath}${homeUrl}"
           class="group flex items-center gap-3 px-4 py-3 rounded-xl transition hover:bg-[#909632]/40">

            <svg class="w-5 h-5 transition group-hover:text-white"
                 style="color:#99A558"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M3 9.75L12 4l9 5.75v9.25A2 2 0 0 1 19 21H5a2 2 0 0 1-2-2z"/>
            </svg>

            <span class="menu-text font-medium">Trang chủ</span>
        </a>

        <!-- CUSTOMER -->
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 0}">
            <a href="${pageContext.request.contextPath}/customer/order"
               class="group flex items-center gap-3 px-4 py-3 rounded-xl transition hover:bg-[#909632]/40">

                <svg class="w-5 h-5" style="color:#99A558"
                     fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24">
                    <path d="M3 3h2l.4 2M7 13h10l4-8H5.4"/>
                </svg>

                <span class="menu-text">Đặt hàng</span>
            </a>
        </c:if>

        <!-- BILL -->
        <c:if test="${sessionScope.user != null && (sessionScope.user.role == 0 || sessionScope.user.role == 1)}">
            <a href="${pageContext.request.contextPath}/personal-bill"
               class="group flex items-center gap-3 px-4 py-3 rounded-xl transition hover:bg-[#909632]/40">

                <svg class="w-5 h-5" style="color:#99A558"
                     fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24">
                    <path d="M6 2h12v20l-6-3-6 3z"/>
                </svg>

                <span class="menu-text">Lịch sử hóa đơn</span>
            </a>
        </c:if>

        <!-- SELL -->
        <c:if test="${sessionScope.user != null && (sessionScope.user.role == 1 || sessionScope.user.role == 2)}">
            <a href="${pageContext.request.contextPath}/seller/tables"
               class="group flex items-center gap-3 px-4 py-3 rounded-xl transition hover:bg-[#909632]/40">

                <svg class="w-5 h-5" style="color:#99A558"
                     fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24">
                    <path d="M3 3h2l.4 2M7 13h10l4-8H5.4"/>
                </svg>

                <span class="menu-text">Bán hàng</span>
            </a>
        </c:if>

        <!-- ADMIN -->
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
            <a href="${pageContext.request.contextPath}/admin"
               class="group flex items-center gap-3 px-4 py-3 rounded-xl transition hover:bg-[#909632]/40">

                <svg class="w-5 h-5" style="color:#99A558"
                     fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24">
                    <path d="M5 13l4 4L19 7"/>
                </svg>

                <span class="menu-text">Quản lý</span>
            </a>
        </c:if>

        <!-- PROFILE -->
        <a href="${pageContext.request.contextPath}/profile"
           class="group flex items-center gap-3 px-4 py-3 rounded-xl transition hover:bg-[#909632]/40">

            <svg class="w-5 h-5" style="color:#99A558"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M12 15a4 4 0 100-8 4 4 0 000 8z"/>
                <path d="M4 21v-1a7 7 0 0114 0v1"/>
            </svg>

            <span class="menu-text">Cài đặt</span>
        </a>
<!-- ONLINE ORDER (STAFF + ADMIN) -->
<c:if test="${sessionScope.user != null && (sessionScope.user.role == 1 || sessionScope.user.role == 2)}">
    <a href="${pageContext.request.contextPath}/seller/online-orders"
       class="group flex items-center gap-3 px-4 py-3 rounded-xl transition hover:bg-[#909632]/40">

        <svg class="w-5 h-5 transition group-hover:text-white"
             style="color:#99A558"
             fill="none" stroke="currentColor" stroke-width="2"
             viewBox="0 0 24 24">
            <path d="M5 13l4 4L19 7"/>
        </svg>

        <span class="menu-text font-medium">Đơn hàng online</span>
    </a>
</c:if>
    </nav>

    <!-- LOGOUT -->
    <div class="p-4 border-t border-[#99A558]/20">
        <a href="${pageContext.request.contextPath}/logout"
           class="group flex items-center gap-3 px-4 py-3 rounded-xl transition hover:bg-red-500/20">

            <svg class="w-5 h-5 text-red-300 group-hover:text-red-500 transition"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/>
                <path d="M16 17l5-5-5-5"/>
                <path d="M21 12H9"/>
            </svg>

            <span class="menu-text text-red-300">Đăng xuất</span>
        </a>
    </div>

</div>
<style>
.sidebar-collapsed #sidebar {
    width: 5rem !important; /* w-20 */
}
.sidebar-collapsed #mainContent {
    margin-left: 5rem !important;
}
.sidebar-collapsed .menu-text {
    display: none !important;
}
</style>
<script>
// load trạng thái khi vào trang (KHÔNG GIẬT)
(function () {
    const collapsed = localStorage.getItem("sidebarCollapsed") === "true";
    if (collapsed) {
        document.documentElement.classList.add("sidebar-collapsed");
    }
})();

// toggle
function toggleSidebar() {
    const isCollapsed = document.documentElement.classList.contains("sidebar-collapsed");

    if (isCollapsed) {
        document.documentElement.classList.remove("sidebar-collapsed");
        localStorage.setItem("sidebarCollapsed", "false");
    } else {
        document.documentElement.classList.add("sidebar-collapsed");
        localStorage.setItem("sidebarCollapsed", "true");
    }
}
</script>
