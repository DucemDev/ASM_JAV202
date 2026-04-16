<div class="flex-between p-4 border-b bg-[var(--surface)] shadow-sm">

    <div class="font-semibold">

        <c:choose>
            <c:when test="${sessionScope.user != null && sessionScope.user.role == 2}">
                BẢNG ĐIỀU KHIỂN QUẢN TRỊ
            </c:when>

            <c:when test="${sessionScope.user != null && sessionScope.user.role == 1}">
                BẢNG ĐIỀU KHIỂN NHÂN VIÊN
            </c:when>

            <c:otherwise>
                Trang người dùng
            </c:otherwise>
        </c:choose>

    </div>

    <div class="flex items-center gap-3">

        <div class="w-10 h-10 rounded-full bg-[var(--primary-100)] flex-center">
            👤
        </div>

        <div>
            <div class="font-semibold text-sm">
                <c:out value="${sessionScope.user.fullname}" default="Khách"/>
            </div>

            <div class="text-xs text-gray-500">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 2}">Admin</c:when>
                    <c:when test="${sessionScope.user.role == 1}">Nhân viên</c:when>
                    <c:otherwise>Khách</c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>

</div>