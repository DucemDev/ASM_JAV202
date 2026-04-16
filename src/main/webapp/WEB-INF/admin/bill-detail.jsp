<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết hóa đơn</title>

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
                    <h1>Chi tiết hóa đơn #${bill.id}</h1>
                    <a href="${pageContext.request.contextPath}/manager/bill" class="btn btn-outline">Quay lại</a>
                </div>

                <div class="grid grid-2 gap-4 mb-6">
                    <div>Bàn: ${bill.tableId}</div>
                    <div>Tổng: <span data-currency="${bill.total}"></span></div>
                </div>

                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Món</th>
                        <th>SL</th>
                        <th>Giá</th>
                        <th>Thành tiền</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="item" items="${billItems}">
                        <tr>
                            <td>${item.drinkId}</td>
                            <td>${item.quantity}</td>
                            <td data-currency="${item.price}"></td>
                            <td data-currency="${item.price * item.quantity}"></td>
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