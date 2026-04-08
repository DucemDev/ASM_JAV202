<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>User Management</title>

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
        }
    </script>
</head>

<body class="bg-cafe-bg">

<div class="flex">

    <!-- SIDEBAR -->
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <!-- RIGHT SIDE -->
    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
        <!-- FORM ADD / EDIT -->
        <c:if test="${formMode != null}">
            <div class="bg-white p-6 rounded-xl shadow-md mb-6">

                <h2 class="text-xl font-bold mb-4">
                        ${formMode == 'add' ? 'Add User' : 'Edit User'}
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
                                   class="w-full border px-3 py-2 rounded">
                        </div>

                        <div>
                            <label>Password</label>
                            <input type="password" name="password"
                                   class="w-full border px-3 py-2 rounded">
                        </div>

                        <div>
                            <label>Full Name</label>
                            <input type="text" name="fullName"
                                   value="${user.fullname}"
                                   class="w-full border px-3 py-2 rounded">
                        </div>

                        <div>
                            <label>Phone</label>
                            <input type="text" name="phone"
                                   value="${user.phone}"
                                   class="w-full border px-3 py-2 rounded">
                        </div>

                        <div>
                            <label>Status</label>
                            <select name="active" class="w-full border px-3 py-2 rounded">
                                <option value="1" ${user.active ? 'selected' : ''}>Active</option>
                                <option value="0" ${!user.active ? 'selected' : ''}>Locked</option>
                            </select>
                        </div>

                    </div>

                    <div class="mt-4">
                        <button class="bg-green-600 text-white px-5 py-2 rounded">
                                ${formMode == 'add' ? 'Create' : 'Update'}
                        </button>

                        <a href="${pageContext.request.contextPath}/manager/staff"
                           class="ml-3 text-gray-600">
                            Cancel
                        </a>
                    </div>

                </form>

            </div>
        </c:if>
        <!-- CONTENT -->
        <div class="p-8">

            <div class="max-w-[1400px] mx-auto">

                <!-- TITLE -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">User Management</h1>

                    <a href="${pageContext.request.contextPath}/manager/staff/add"
                       class="bg-cafe-brown text-white px-5 py-2 rounded-lg hover:opacity-90 transition">
                        + Add User
                    </a>
                </div>

                <!-- SEARCH -->
                <form method="get" action="${pageContext.request.contextPath}/manager/staff" class="mb-4 flex gap-3">
                    <input type="text" name="keyword"
                           placeholder="Search by email..."
                           class="border rounded-lg px-4 py-2 w-72">

                    <button class="bg-gray-700 text-white px-5 py-2 rounded-lg hover:opacity-90">
                        Search
                    </button>
                </form>

                <!-- TABLE -->
                <p>Size: ${staffList.size()}</p>
                <div class="bg-white rounded-xl shadow-md overflow-hidden">

                    <table class="w-full text-sm text-center">

                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr>
                            <th class="p-3">ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Action</th>
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
                                            <span class="text-green-600 font-semibold">Admin</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-600">Staff</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${u.active == true}">
                                            <span class="text-green-600 font-semibold">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-500 font-semibold">Locked</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                               <td class="space-x-2">

                                   <!-- EDIT -->
                                   <a href="${pageContext.request.contextPath}/manager/staff/edit?userId=${u.id}"
                                      class="bg-blue-500 text-white px-3 py-1 rounded hover:opacity-80">
                                       Edit
                                   </a>

                                   <!-- DELETE -->
                                   <a href="${pageContext.request.contextPath}/manager/staff/delete?userId=${u.id}"
                                      onclick="return confirm('Bạn có chắc muốn xóa user này không?')"
                                      class="bg-red-500 text-white px-3 py-1 rounded hover:opacity-80">
                                       Delete
                                   </a>

                                   <!-- TOGGLE STATUS -->
                                   <a href="${pageContext.request.contextPath}/manager/staff/update-status?userId=${u.id}&status=${u.active ? 0 : 1}"
                                      class="bg-yellow-500 text-white px-3 py-1 rounded hover:opacity-80">
                                       khóa/mở
                                   </a>

                               </td>

                            </tr>

                        </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>