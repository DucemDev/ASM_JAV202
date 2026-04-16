<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý loại đồ uống</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>

<div class="layout">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="main">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="content">

            <div class="card">

                <h1 class="mb-4">Quản lý loại đồ uống</h1>

                <form method="post"
                      action="${pageContext.request.contextPath}/manager/categories/${category != null ? 'edit' : 'add'}"
                      class="grid grid-3 gap-4 mb-6">

                    <input type="hidden" name="id" value="${category.id}">

                    <input type="text" name="name" value="${category.name}" class="input" placeholder="Tên loại">

                    <button class="btn btn-primary">
                        ${category != null ? 'Cập nhật' : 'Thêm'}
                    </button>

                </form>

                <table class="table table-hover">

                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="item" items="${list}">
                        <tr>
                            <td>${item.id}</td>
                            <td>${item.name}</td>
                            <td class="flex gap-2">

                                <a href="${pageContext.request.contextPath}/manager/categories?id=${item.id}"
                                   class="btn btn-outline">Sửa</a>

                                <form method="post"
                                      action="${pageContext.request.contextPath}/manager/categories/delete">
                                    <input type="hidden" name="id" value="${item.id}">
                                    <button class="btn btn-danger" data-confirm="Xóa loại này?">Xóa</button>
                                </form>

                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>