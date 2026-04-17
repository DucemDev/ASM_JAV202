<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Quản lý nhân viên</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent"
         class="flex-1 flex flex-col ml-64 h-screen overflow-y-auto">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <!-- FORM -->
        <c:if test="${formMode != null}">
            <div class="p-6">
                <div class="rounded-2xl shadow-xl p-6 backdrop-blur-xl border"
                     style="background:rgba(255,255,255,0.3); border:1px solid rgba(255,255,255,0.3);">

                    <h2 class="text-xl font-bold mb-4 text-[#27301B]">
                        ${formMode == 'add' ? 'Thêm nhân viên' : 'Cập nhật nhân viên'}
                    </h2>

                    <c:if test="${error != null}">
                        <div class="bg-red-100 text-red-600 px-4 py-2 rounded mb-4">
                            ${error}
                        </div>
                    </c:if>

                    <form method="post"
                          action="${pageContext.request.contextPath}/manager/staff/${formMode}">

                        <input type="hidden" name="userId" value="${user.id}"/>

                        <div class="grid grid-cols-2 gap-4">

                            <div>
                                <label>Email</label>
                                <input type="text" name="email"
                                       value="${user.email}"
                                       class="w-full rounded-lg px-3 py-2 border"
                                       style="background:rgba(255,255,255,0.4);">
                            </div>

                            <div>
                                <label>Mật khẩu</label>
                                <input type="password" name="password"
                                       class="w-full rounded-lg px-3 py-2 border">
                            </div>

                            <div>
                                <label>Họ tên</label>
                                <input type="text" name="fullName"
                                       value="${user.fullname}"
                                       class="w-full rounded-lg px-3 py-2 border">
                            </div>

                            <div>
                                <label>Số điện thoại</label>
                                <input type="text" name="phone"
                                       value="${user.phone}"
                                       class="w-full rounded-lg px-3 py-2 border">
                            </div>

                            <div>
                                <label>Trạng thái</label>
                                <select name="active" class="w-full rounded-lg px-3 py-2 border">
                                    <option value="1" ${user.active ? 'selected' : ''}>Hoạt động</option>
                                    <option value="0" ${!user.active ? 'selected' : ''}>Khóa</option>
                                </select>
                            </div>

                            <div>
                                <label>Vai trò</label>
                                <select name="role" class="w-full rounded-lg px-3 py-2 border">
                                    <option value="1" ${user.role == 1 ? 'selected' : ''}>Nhân viên</option>
                                    <option value="2" ${user.role == 2 ? 'selected' : ''}>Quản trị</option>
                                </select>
                            </div>

                        </div>

                        <div class="mt-4">
                            <button class="px-5 py-2 rounded-lg text-white"
                                    style="background:#27301B;">
                                ${formMode == 'add' ? 'Tạo' : 'Cập nhật'}
                            </button>

                            <a href="${pageContext.request.contextPath}/manager/staff"
                               class="ml-3 text-gray-600">
                                Hủy
                            </a>
                        </div>

                    </form>

                </div>
            </div>
        </c:if>

        <!-- CONTENT -->
        <div class="p-8">

            <div class="max-w-[1400px] mx-auto">

                <!-- HEADER -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-[#27301B]">Quản lý nhân viên</h1>

                    <a href="${pageContext.request.contextPath}/manager/staff/add"
                       class="px-5 py-2 rounded-xl text-white shadow hover:scale-105 transition"
                       style="background:#27301B;">
                        + Thêm
                    </a>
                </div>

                <!-- SEARCH -->
                <form method="get"
                      action="${pageContext.request.contextPath}/manager/staff"
                      class="mb-4 flex gap-3">

                    <input type="text" name="keyword"
                           value="${keyword}"
                           placeholder="Tìm theo tên hoặc email"
                           class="rounded-lg px-4 py-2 border backdrop-blur-xl"
                           style="background:rgba(255,255,255,0.3); border-color:#909632;">

                    <select name="status"
                            class="rounded-lg px-3 py-2 border backdrop-blur-xl"
                            style="background:rgba(255,255,255,0.3); border-color:#909632;">
                        <option value="">Tất cả</option>
                        <option value="1" ${status == '1' ? 'selected' : ''}>Hoạt động</option>
                        <option value="0" ${status == '0' ? 'selected' : ''}>Khóa</option>
                    </select>

                    <button class="px-5 py-2 rounded-lg text-white"
                            style="background:#41521E;">
                        Tìm kiếm
                    </button>
                </form>

                <!-- TABLE -->
                <div class="rounded-2xl shadow-xl backdrop-blur-xl border overflow-hidden"
                     style="background:rgba(255,255,255,0.28); border:1px solid rgba(255,255,255,0.3);">

                    <table class="w-full text-sm text-center">

                        <thead style="background:rgba(65,82,30,0.25);" class="text-[#27301B]">
                        <tr>
                            <th class="p-3">ID</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Điện thoại</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="u" items="${staffList}">

                            <tr class="border-t border-white/30 hover:bg-white/15 transition">

                                <td class="p-3">${u.id}</td>
                                <td class="font-medium">${u.fullname}</td>
                                <td>${u.email}</td>
                                <td>${u.phone}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${u.role == 2}">
                                            <span class="text-purple-600 font-semibold">Admin</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-600">Nhân viên</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <span class="text-green-600 font-semibold">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-500 font-semibold">Khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="space-x-2">

                                    <a href="${pageContext.request.contextPath}/manager/staff/edit?userId=${u.id}"
                                       class="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg">
                                        Sửa
                                    </a>

                                    <a href="${pageContext.request.contextPath}/manager/staff/delete?userId=${u.id}"
                                       onclick="return confirm('Bạn có chắc muốn xóa?')"
                                       class="px-3 py-1 bg-red-100 text-red-700 rounded-lg">
                                        Xóa
                                    </a>

                                    <a href="${pageContext.request.contextPath}/manager/staff/update-status?userId=${u.id}&status=${u.active ? 0 : 1}"
                                       class="px-3 py-1 bg-yellow-100 text-yellow-700 rounded-lg">
                                        Khóa/Mở
                                    </a>

                                </td>

                            </tr>

                        </c:forEach>
                        </tbody>

                    </table>

                </div>

                <!-- PAGINATION -->
                <c:if test="${totalPages > 1}">
                    <div class="flex justify-center gap-2 mt-6">
                        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                            <a href="${pageContext.request.contextPath}/manager/staff?page=${pageNumber}&keyword=${keyword}&status=${status}"
                               class="px-3 py-2 rounded-lg border"
                               style="${pageNumber == currentPage ? 'background:#27301B;color:white;border-color:#27301B;' : 'background:white;border-color:#ccc;'}">
                                    ${pageNumber}
                            </a>
                        </c:forEach>
                    </div>
                </c:if>

            </div>
        </div>

    </div>

</div>

</body>
</html>