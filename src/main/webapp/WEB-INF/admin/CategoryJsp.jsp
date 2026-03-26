<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Quản lý Category</title>
    <style>
        table { border-collapse: collapse; width: 60%; }
        th, td { border: 1px solid black; padding: 8px; text-align: center; }
        .msg { color: green; }
        .err { color: red; }
    </style>
</head>
<body>

<h2>Quản lý Category</h2>
<!-- Hiển thị thông báo -->
<c:if test="${not empty message}"> <p class="msg">${message}</p></c:if>
<c:if test="${not empty error}"><p class="err">${error}</p></c:if>

<form method="post" >

    <input type="hidden" name="id" value="${not empty category ? category.id : ''}" />

    <label>Tên loại:</label>
    <input type="text" name="name" value="${category.name}" />

    <label>Trạng thái:</label>
    <input type="radio" name="name" value="${category.name}" />

    <button type="submit">
        ${category != null ? 'Cập nhật' : 'Thêm mới'}
    </button>

</form>

<br>

<table>
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Trạng thái</th>
        <th>Hành động</th>
    </tr>

    <c:forEach var="item" items="${list}">
        <tr>
            <td>${item.id}</td>
            <td>${item.name}</td>
            <td>
                <c:choose>
                    <c:when test="${item.active}">Hoạt động</c:when>
                    <c:otherwise>Ngừng</c:otherwise>
                </c:choose>
            </td>

            <td>
                <!-- EDIT -->
                <a href="${pageContext.request.contextPath}/manager/categories?id=${item.id}">
                    Sửa
                </a>

                <!-- DELETE -->
                <form method="post" action="${pageContext.request.contextPath}/manager/categories/delete" style="display:inline;">
                    <input type="hidden" name="id" value="${item.id}" />
                    <button onclick="return confirm('Bạn có chắc muốn xóa?')">
                        Xóa
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>

</table>

</body>
</html>