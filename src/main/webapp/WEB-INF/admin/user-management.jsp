<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng - PolyCafe</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        cafe: {
                            bg: '#f6efe7',
                            brown: '#8b5e3c'
                        }
                    }
                }
            }
        };
    </script>
</head>

<body class="bg-cafe-bg">

<div class="flex">
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="flex-1 flex flex-col ml-64">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <c:if test="${formMode != null}">
            <div class="bg-white p-6 rounded-xl shadow-md m-6">

                <h2 class="text-xl font-bold mb-4">
                    ${formMode == 'add' ? 'Thêm người dùng' : 'Chỉnh sửa người dùng'}
                </h2>

                <c:if test="${error != null}">
                    <div class="bg-red-100 text-red-600 px-4 py-2 rounded mb-4">${error}</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/manager/staff/${formMode}">
                    <input type="hidden" name="userId" value="${user.id}"/>

                    <div class="grid grid-cols-2 gap-4">

                        <div>
                            <label>Email</label>
                            <input type="text" name="email" value="${user.email}"
                                   class="w-full border px-3 py-2 rounded">
                        </div>

                        <div>
                            <label>Mật khẩu</label>
                            <input type="password" name="password"
                                   class="w-full border px-3 py-2 rounded">
                        </div>

                        <div>
                            <label>Họ tên</label>
                            <input type="text" name="fullName" value="${user.fullname}"
                                   class="w-full border px-3 py-2 rounded">
                        </div>

                        <div>
                            <label>Số điện thoại</label>
                            <input type="text" name="phone" value="${user.phone}"
                                   class="w-full border px-3 py-2 rounded">
                        </div>

                        <div>
                            <label>Trạng thái</label>
                            <select name="active" class="w-full border px-3 py-2 rounded">
                                <option value="1" ${user.active ? 'selected' : ''}>Hoạt động</option>
                                <option value="0" ${!user.active ? 'selected' : ''}>Bị khóa</option>
                            </select>
                        </div>

                        <div>
                            <label>Vai trò</label>
                            <select name="role" class="w-full border px-3 py-2 rounded">
                                <option value="1" ${user.role == 1 ? 'selected' : ''}>Nhân viên</option>
                                <option value="2" ${user.role == 2 ? 'selected' : ''}>Quản trị viên</option>
                            </select>
                        </div>

                    </div>

                    <div class="mt-4">
                        <button class="bg-green-600 text-white px-5 py-2 rounded">
                            ${formMode == 'add' ? 'Tạo mới' : 'Cập nhật'}
                        </button>

                        <a href="${pageContext.request.contextPath}/manager/staff"
                           class="ml-3 text-gray-600">
                            Hủy
                        </a>
                    </div>
                </form>

            </div>
        </c:if>

        <div class="p-8">
            <div class="max-w-[1400px] mx-auto">

                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">Quản lý người dùng</h1>

                    <a href="${pageContext.request.contextPath}/manager/staff/add"
                       class="bg-cafe-brown text-white px-5 py-2 rounded-lg">
                        + Thêm người dùng
                    </a>
                </div>

                <form method="get"
                      action="${pageContext.request.contextPath}/manager/staff"
                      class="mb-4 flex gap-3">

                    <input type="text" name="keyword"
                           value="${keyword}"
                           placeholder="Tìm theo tên hoặc email..."
                           class="border rounded-lg px-4 py-2 w-72">

                    <select name="status" class="border rounded-lg px-3 py-2">
                        <option value="">Tất cả</option>
                        <option value="1" ${status == '1' ? 'selected' : ''}>Hoạt động</option>
                        <option value="0" ${status == '0' ? 'selected' : ''}>Bị khóa</option>
                    </select>

                    <button class="bg-gray-700 text-white px-5 py-2 rounded-lg">
                        Tìm kiếm
                    </button>
                </form>

                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <table class="w-full text-sm text-center">
                        <thead class="bg-[#f1e4d7]">
                        <tr>
                            <th class="p-3">ID</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="u" items="${staffList}">
                            <tr class="border-t hover:bg-gray-50">

                                <td class="p-3">${u.id}</td>
                                <td>${u.fullname}</td>
                                <td>${u.email}</td>
                                <td>${u.phone}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${u.role == 2}">
                                            <span class="text-purple-600 font-semibold">Quản trị viên</span>
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
                                            <span class="text-red-500 font-semibold">Bị khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="space-x-2">
                                    <a href="${pageContext.request.contextPath}/manager/staff/edit?userId=${u.id}"
                                       class="bg-blue-500 text-white px-3 py-1 rounded">
                                        Sửa
                                    </a>

                                    <a href="${pageContext.request.contextPath}/manager/staff/delete?userId=${u.id}"
                                       onclick="return confirm('Bạn có chắc muốn xóa?')"
                                       class="bg-red-500 text-white px-3 py-1 rounded">
                                        Xóa
                                    </a>

                                    <a href="${pageContext.request.contextPath}/manager/staff/update-status?userId=${u.id}&status=${u.active ? 0 : 1}"
                                       class="bg-yellow-500 text-white px-3 py-1 rounded">
                                        Đổi trạng thái
                                    </a>
                                </td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${totalPages > 1}">
                    <div class="flex justify-center gap-2 mt-6">
                        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                            <a href="${pageContext.request.contextPath}/manager/staff?page=${pageNumber}&keyword=${keyword}&status=${status}"
                               class="px-3 py-2 border rounded ${pageNumber == currentPage ? 'bg-cafe-brown text-white' : 'bg-white'}">
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