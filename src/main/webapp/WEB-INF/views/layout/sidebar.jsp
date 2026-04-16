<div id="sidebar" class="bg-[var(--surface)] border-r w-64 min-h-screen p-4 transition-all">

    <div class="mb-6 text-center font-bold">PolyCafe</div>

    <button class="btn btn-outline mb-4 w-full" data-action="toggle-sidebar">
        Thu gọn
    </button>

    <nav class="flex flex-col gap-2">

        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline">Trang chủ</a>

        <a href="${pageContext.request.contextPath}/seller/tables" class="btn btn-outline">Bán hàng</a>

        <a href="${pageContext.request.contextPath}/manager/bill" class="btn btn-outline">Hóa đơn</a>

        <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline">Cài đặt</a>

        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Đăng xuất</a>

    </nav>

</div>