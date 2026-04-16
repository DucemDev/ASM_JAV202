<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý hóa đơn</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>

<div class="layout">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="main">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="content">

            <div class="card">

                <div class="flex-between mb-4">
                    <h1>Quản lý hóa đơn</h1>
                    <a href="${pageContext.request.contextPath}/manager/bill/export" class="btn btn-success">Xuất Excel</a>
                </div>

                <form method="get" class="flex gap-2 mb-4">
                    <input type="text" name="keyword" value="${keyword}" class="input" placeholder="Tìm...">
                    <button class="btn btn-primary">Lọc</button>
                </form>

                <table class="table table-hover">

                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tổng</th>
                        <th>Ngày</th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="b" items="${billList}">
                        <tr>
                            <td>${b.id}</td>
                            <td data-currency="${b.total}"></td>
                            <td>${b.createdAt}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/manager/bill-detail?id=${b.id}" class="btn btn-outline">Xem</a>
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