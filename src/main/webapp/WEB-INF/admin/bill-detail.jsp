<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Bill Detail</title>

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

    <!-- MAIN -->
    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <!-- CONTENT -->
        <div class="p-8">

            <div class="max-w-[1200px] mx-auto">

                <!-- TITLE -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">
                        Bill Detail #${bill.id}
                    </h1>

                    <a href="${pageContext.request.contextPath}/manager/bill"
                       class="bg-gray-600 text-white px-4 py-2 rounded-lg">
                        Back
                    </a>
                </div>

                <!-- BILL INFO -->
                <div class="bg-white rounded-xl shadow-md p-6 mb-6 grid grid-cols-2 gap-6">

                    <div>
                        <p class="text-gray-600">Table</p>
                        <p class="font-semibold text-lg">Table ${bill.tableId}</p>
                    </div>

                    <div>
                        <p class="text-gray-600">Status</p>

                        <c:choose>
                            <c:when test="${bill.status == 'finish'}">
                                <span class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-semibold">
                                    Completed
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="bg-red-100 text-red-600 px-3 py-1 rounded-full text-sm font-semibold">
                                    Cancelled
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div>
                        <p class="text-gray-600">Created At</p>
                        <p class="font-semibold">${bill.createdAt}</p>
                    </div>

                    <div>
                        <p class="text-gray-600">Total</p>
                        <p class="font-bold text-xl text-green-600">
                            ${bill.total} đ
                        </p>
                    </div>

                </div>

                <!-- BILL ITEMS -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden">

                    <table class="w-full text-sm text-center">

                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr>
                            <th class="p-3">Drink</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                        </thead>

                        <tbody>

                        <c:forEach var="item" items="${billItems}">
                            <tr class="border-t hover:bg-gray-50">

                                <td class="p-3">${item.drinkName}</td>
                                <td>${item.price} đ</td>
                                <td>${item.quantity}</td>
                                <td class="font-semibold">
                                    ${item.price * item.quantity} đ
                                </td>

                            </tr>
                        </c:forEach>

                        <c:if test="${empty billItems}">
                            <tr>
                                <td colspan="4" class="p-4 text-gray-500">
                                    No items found
                                </td>
                            </tr>
                        </c:if>

                        </tbody>

                    </table>

                </div>

                <!-- TOTAL FOOTER -->
                <div class="mt-6 text-right">
                    <p class="text-lg">
                        Total:
                        <span class="font-bold text-green-600 text-xl">
                            ${bill.total} đ
                        </span>
                    </p>
                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>