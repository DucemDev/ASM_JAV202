<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Bill Management</title>

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
            <div class="max-w-[1400px] mx-auto">

                <!-- TITLE + EXPORT -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">Bill Management</h1>

                    <a href="${pageContext.request.contextPath}/manager/bill/export"
                       class="bg-green-600 text-white px-5 py-2 rounded-lg">
                        Export Excel
                    </a>
                </div>

                <!-- FILTER -->
                <form method="get"
                      action="${pageContext.request.contextPath}/manager/bill"
                      class="mb-4 flex gap-3 flex-wrap">

                    <input type="text" name="keyword"
                           placeholder="Search bill ID..."
                           class="border rounded-lg px-4 py-2 w-64">

                    <select name="status" class="border rounded-lg px-4 py-2">
                        <option value="">All Status</option>
                        <option value="finish">Finish</option>
                        <option value="cancel">Cancel</option>
                    </select>

                    <input type="date" name="fromDate" class="border rounded-lg px-4 py-2">
                    <input type="date" name="toDate" class="border rounded-lg px-4 py-2">

                    <button class="bg-gray-700 text-white px-5 py-2 rounded-lg">
                        Filter
                    </button>
                </form>

                <!-- TABLE -->
                <p>Total bills: ${billList.size()}</p>

                <div class="bg-white rounded-xl shadow-md overflow-hidden">

                    <table class="w-full text-sm text-center">

                        <thead class="bg-[#f1e4d7] text-gray-700">
                        <tr>
                            <th class="p-3">Bill ID</th>
                            <th>Table</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Created At</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>

                        <c:forEach var="b" items="${billList}">
                            <tr class="border-t hover:bg-gray-50">

                                <td class="p-3">#${b.id}</td>
                                <td>Table ${b.tableId}</td>
                                <td>${b.total} đ</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${b.status == 'finish'}">
                                            <span class="text-green-600 font-semibold">Completed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-500 font-semibold">Cancelled</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${b.createdAt}</td>

                                <!-- VIEW MODAL -->
                                <td>
                                    <button onclick="openModal()"
                                            class="bg-blue-500 text-white px-3 py-1 rounded hover:opacity-80">
                                        View
                                    </button>
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

<!-- ================= MODAL ================= -->
<div id="billModal"
     class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">

    <div class="bg-white w-[600px] rounded-xl shadow-lg p-6 relative animate-scale">

        <!-- CLOSE -->
        <button onclick="closeModal()"
                class="absolute top-3 right-3 text-gray-500 hover:text-black text-xl">
            ✕
        </button>

        <!-- TITLE -->
        <h2 class="text-xl font-bold mb-4">Bill Detail</h2>

        <!-- INFO -->
        <div class="grid grid-cols-2 gap-4 mb-4">
            <div>
                <p class="text-gray-500">Table</p>
                <p class="font-semibold">Table 5</p>
            </div>

            <div>
                <p class="text-gray-500">Status</p>
                <span class="bg-green-100 text-green-700 px-2 py-1 rounded text-sm">
                    Completed
                </span>
            </div>

            <div>
                <p class="text-gray-500">Created</p>
                <p>2026-04-08</p>
            </div>

            <div>
                <p class="text-gray-500">Total</p>
                <p class="text-green-600 font-bold">120000 đ</p>
            </div>
        </div>

        <!-- ITEMS -->
        <table class="w-full text-sm text-center border">
            <thead class="bg-gray-100">
            <tr>
                <th class="p-2">Drink</th>
                <th>Price</th>
                <th>Qty</th>
                <th>Total</th>
            </tr>
            </thead>

            <tbody>
            <tr class="border-t">
                <td class="p-2">Coffee</td>
                <td>30000</td>
                <td>2</td>
                <td>60000</td>
            </tr>
            <tr class="border-t">
                <td class="p-2">Milk Tea</td>
                <td>30000</td>
                <td>2</td>
                <td>60000</td>
            </tr>
            </tbody>
        </table>

    </div>
</div>

<!-- ================= SCRIPT ================= -->
<script>
    function openModal() {
        const modal = document.getElementById("billModal");
        modal.classList.remove("hidden");
        modal.classList.add("flex");
    }

    function closeModal() {
        const modal = document.getElementById("billModal");
        modal.classList.add("hidden");
        modal.classList.remove("flex");
    }

    // click nền để đóng
    window.onclick = function(e) {
        const modal = document.getElementById("billModal");
        if (e.target === modal) {
            closeModal();
        }
    }
</script>

<style>
    .animate-scale {
        animation: scaleIn 0.2s ease;
    }

    @keyframes scaleIn {
        from {
            transform: scale(0.9);
            opacity: 0;
        }
        to {
            transform: scale(1);
            opacity: 1;
        }
    }
</style>

</body>
</html>