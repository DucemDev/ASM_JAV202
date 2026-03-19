<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-900 text-white">

<div class="flex h-screen">

<!-- LEFT -->
<div class="w-3/4 p-6 overflow-y-auto">

    <h1 class="text-2xl font-bold mb-4">
        Bàn ${tableId}
    </h1>

    <!-- 🔥 CATEGORY -->
    <div class="flex space-x-3 mb-6 overflow-x-auto">

        <a href="sell?tableId=${tableId}"
           class="px-4 py-2 rounded-lg ${empty param.categoryId ? 'bg-orange-500' : 'bg-gray-700'}">
            Tất cả
        </a>

        <c:forEach var="c" items="${categories}">

            <a href="sell?tableId=${tableId}&categoryId=${c.id}"
               class="px-4 py-2 rounded-lg whitespace-nowrap
               ${param.categoryId == c.id ? 'bg-orange-500' : 'bg-gray-700'}">

                ${c.name}

            </a>

        </c:forEach>

    </div>

    <!-- 🔥 DRINK LIST -->
    <div class="grid grid-cols-4 gap-4">

        <c:forEach var="d" items="${drinks}">

            <div class="bg-gray-800 p-4 rounded-xl">

                <img src="${pageContext.request.contextPath}/assets/image/${d.image}"
                     class="h-32 w-full object-cover rounded-lg mb-3">

                <h2 class="font-bold">${d.name}</h2>
                <p class="text-sm text-gray-400">${d.description}</p>

                <div class="flex justify-between items-center mt-3">

                    <span class="text-orange-400 font-bold">
                        ${d.price}đ
                    </span>

                    <form action="add-to-cart" method="post">
                        <input type="hidden" name="drinkId" value="${d.id}">
                        <input type="hidden" name="tableId" value="${tableId}">

                        <button class="bg-orange-500 px-3 py-1 rounded">
                            + Add
                        </button>
                    </form>

                </div>

            </div>

        </c:forEach>

    </div>

</div>

<!-- RIGHT -->
<div class="w-1/4 bg-gray-800 p-6">

    <h2 class="text-xl font-bold mb-4">Đơn hàng</h2>

    <c:choose>

        <c:when test="${empty billDetails}">
            <p>Chưa có món</p>
        </c:when>

        <c:otherwise>

            <c:forEach var="bd" items="${billDetails}">
                <div class="mb-2 border-b pb-2">
                    Món ID: ${bd.drinkId} | SL: ${bd.quantity}
                </div>
            </c:forEach>

        </c:otherwise>

    </c:choose>

    <div class="mt-6 border-t pt-4">
        <p class="font-bold">Tổng: 0đ</p>

        <button class="bg-orange-600 w-full py-2 mt-3 rounded">
            Thanh toán
        </button>
    </div>

</div>

</div>

</body>
</html>