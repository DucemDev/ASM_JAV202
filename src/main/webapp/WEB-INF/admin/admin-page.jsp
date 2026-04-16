<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>POS - PolyCafe</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>

<div class="layout">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="main">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="content max-w-6xl mx-auto">

            <div class="flex-between mb-6">
                <h1 class="text-xl font-semibold">Bán hàng tại quầy (POS)</h1>
                <a href="${pageContext.request.contextPath}/staff" class="btn btn-outline">Quay lại</a>
            </div>

            <div class="grid grid-2 gap-4">

                <!-- MENU -->
                <div class="card">
                    <h2 class="mb-4 font-semibold">Thực đơn</h2>

                    <div class="grid grid-2 gap-2">
                        <c:forEach var="drink" items="${drinks}">
                            <form method="post"
                                  action="${pageContext.request.contextPath}/employee/pos/add-item"
                                  class="card">

                                <input type="hidden" name="billId" value="${bill != null ? bill.id : 0}">
                                <input type="hidden" name="drinkId" value="${drink.id}">

                                <div class="font-medium">${drink.name}</div>
                                <div class="text-sm text-gray-500" data-currency="${drink.price}"></div>

                                <button class="btn btn-primary mt-2 w-full">Thêm món</button>
                            </form>
                        </c:forEach>
                    </div>
                </div>

                <!-- BILL -->
                <div class="card">

                    <div class="flex-between mb-4">
                        <h2 class="font-semibold">Hóa đơn hiện tại</h2>
                        <c:if test="${bill != null}">
                            <span class="text-sm text-gray-500">${bill.code}</span>
                        </c:if>
                    </div>

                    <c:choose>

                        <c:when test="${bill == null}">
                            <p class="text-gray-500">Chưa có hóa đơn. Hãy thêm món.</p>
                        </c:when>

                        <c:otherwise>

                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Món</th>
                                    <th>SL</th>
                                    <th>Giá</th>
                                    <th></th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="item" items="${billDetails}">
                                    <tr>

                                        <td>${item.drinkId}</td>

                                        <td>${item.quantity}</td>

                                        <td data-currency="${item.price}"></td>

                                        <td class="flex gap-2">

                                            <form method="post" action="${pageContext.request.contextPath}/employee/pos/update-quantity">
                                                <input type="hidden" name="billId" value="${bill.id}">
                                                <input type="hidden" name="billDetailId" value="${item.id}">
                                                <input type="hidden" name="action" value="increase">
                                                <button class="btn btn-outline">+</button>
                                            </form>

                                            <form method="post" action="${pageContext.request.contextPath}/employee/pos/update-quantity">
                                                <input type="hidden" name="billId" value="${bill.id}">
                                                <input type="hidden" name="billDetailId" value="${item.id}">
                                                <input type="hidden" name="action" value="decrease">
                                                <button class="btn btn-outline">-</button>
                                            </form>

                                            <form method="post" action="${pageContext.request.contextPath}/employee/pos/update-quantity">
                                                <input type="hidden" name="billId" value="${bill.id}">
                                                <input type="hidden" name="billDetailId" value="${item.id}">
                                                <input type="hidden" name="action" value="remove">
                                                <button class="btn btn-danger" data-confirm="Xóa món này?">Xóa</button>
                                            </form>

                                        </td>

                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <div class="text-right mt-4 font-semibold">
                                Tổng: <span data-currency="${total}"></span>
                            </div>

                            <div class="flex gap-3 mt-4">

                                <form method="post" action="${pageContext.request.contextPath}/employee/pos/checkout">
                                    <input type="hidden" name="billId" value="${bill.id}">
                                    <button class="btn btn-success">Thanh toán</button>
                                </form>

                                <form method="post" action="${pageContext.request.contextPath}/employee/pos/cancel">
                                    <input type="hidden" name="billId" value="${bill.id}">
                                    <button class="btn btn-danger" data-confirm="Hủy hóa đơn?">Hủy</button>
                                </form>

                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>

    </div>

</div>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>