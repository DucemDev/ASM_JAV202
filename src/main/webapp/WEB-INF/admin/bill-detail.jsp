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
                    <h1 class="text-2xl font-bold text-gray-800">Bill Detail #${bill.id}</h1>
                    <a href="${pageContext.request.contextPath}/manager/bill"
                       class="bg-gray-600 text-white px-4 py-2 rounded-lg">Back</a>
                </div>

                <!-- PREP DISPLAY VALUES -->
                <c:set var="isOnline" value="${bill.type == 'online'}"/>
                <c:set var="displayTable" value="${isOnline || bill.tableId <= 0 ? 'Online (không bàn)' : 'Table '.concat(bill.tableId)}"/>
                <c:set var="displayCreator" value="${not empty bill.userFullName ? bill.userFullName : 'Unknown'}"/>

                <!-- BILL INFO -->
                <div class="bg-white rounded-xl shadow-md p-6 mb-6 grid grid-cols-2 gap-6">

                    <div>
                        <p class="text-gray-600">Table</p>
                        <p class="font-semibold text-lg">${displayTable}</p>
                    </div>

                    <div>
                        <p class="text-gray-600">Status</p>
                        <c:choose>
                            <c:when test="${bill.status == 'waiting'}">
                                <span class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-sm font-semibold">Waiting</span>
                            </c:when>
                            <c:when test="${bill.status == 'pending_verify'}">
                                <span class="bg-amber-100 text-amber-700 px-3 py-1 rounded-full text-sm font-semibold">Pending Verify</span>
                            </c:when>
                            <c:when test="${bill.status == 'finish'}">
                                <span class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-semibold">Completed</span>
                            </c:when>
                            <c:when test="${bill.status == 'cancel'}">
                                <span class="bg-red-100 text-red-600 px-3 py-1 rounded-full text-sm font-semibold">Cancelled</span>
                            </c:when>
                            <c:otherwise>
                                <span class="bg-gray-100 text-gray-700 px-3 py-1 rounded-full text-sm font-semibold">${bill.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div>
                        <p class="text-gray-600">Type</p>
                        <p class="font-semibold">
                            <c:choose>
                                <c:when test="${bill.type == 'pos'}">POS</c:when>
                                <c:when test="${bill.type == 'online'}">Online</c:when>
                                <c:otherwise>${bill.type}</c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <div>
                        <p class="text-gray-600">Created By</p>
                        <p class="font-semibold">${displayCreator}</p>
                    </div>

                    <div>
                        <p class="text-gray-600">Created At</p>
                        <p class="font-semibold">${bill.createdAt}</p>
                    </div>

                    <div>
                        <p class="text-gray-600">Total (DB)</p>
                        <p class="font-bold text-xl text-green-600">${bill.total} đ</p>
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
                        <c:set var="computedTotal" value="0"/>
                        <c:forEach var="item" items="${billItems}">
                            <c:set var="lineTotal" value="${item.price * item.quantity}"/>
                            <c:set var="computedTotal" value="${computedTotal + lineTotal}"/>

                            <tr class="border-t hover:bg-gray-50">
                                <td class="p-3">
                                    <c:set var="drinkName" value="Unknown"/>
                                    <c:forEach var="d" items="${drinks}">
                                        <c:if test="${d.id == item.drinkId}">
                                            <c:set var="drinkName" value="${d.name}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${drinkName}
                                </td>
                                <td>${item.price} đ</td>
                                <td>${item.quantity}</td>
                                <td class="font-semibold">${lineTotal} đ</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty billItems}">
                            <tr>
                                <td colspan="4" class="p-4 text-gray-500">No items found</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- TOTAL FOOTER -->
                <div class="mt-6 text-right">
                    <p class="text-lg">
                        Total (computed):
                        <span class="font-bold text-green-600 text-xl">${computedTotal} đ</span>
                    </p>
                </div>

            </div>
        </div>

    </div>
</div>
</body>
</html>