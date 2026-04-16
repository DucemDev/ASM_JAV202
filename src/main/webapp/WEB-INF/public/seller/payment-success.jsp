<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn thanh toán - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
</head>

<body class="app-bg">
<div class="flex">
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="flex-1 flex flex-col">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">
            <div class="max-w-[600px] mx-auto">
                <div class="bg-white rounded-2xl shadow-lg p-6 border">

                    <div class="text-center border-b pb-4 mb-4">
                        <h2 class="text-xl font-bold">☕ PolyCafe POS</h2>
                        <p class="text-xs text-gray-400">Hóa đơn thanh toán</p>
                    </div>

                    <div class="text-sm mb-4 space-y-1">
                        <p>Mã hóa đơn: <b>${bill.code}</b></p>
                        <p>Bàn: <b>${bill.tableId}</b></p>
                        <p>Thời gian:
                            <b>
                                <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
                                        .format(new java.util.Date()) %>
                            </b>
                        </p>
                    </div>

                    <table class="w-full text-sm border-t border-b mb-4">
                        <thead>
                        <tr class="text-left">
                            <th>Món</th>
                            <th>SL</th>
                            <th class="text-right">Giá</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${billDetails}">
                            <tr>
                                <td>
                                    <c:forEach var="d" items="${drinks}">
                                        <c:if test="${d.id == item.drinkId}">
                                            ${d.name}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${item.quantity}</td>
                                <td class="text-right js-currency" data-currency="${item.price}"></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="text-right text-lg font-bold mb-4">
                        Tổng: <span class="js-currency" data-currency="${total}"></span>
                    </div>

                    <div class="text-center text-xs text-gray-400 mb-4">
                        Cảm ơn quý khách ❤️ Hẹn gặp lại!
                    </div>

                    <a href="${pageContext.request.contextPath}/seller/tables"
                       class="block text-center btn btn-secondary">
                        Quay lại danh sách bàn
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>