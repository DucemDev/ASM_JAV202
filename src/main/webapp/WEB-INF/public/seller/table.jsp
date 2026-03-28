<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tables</title>

    <!-- TAILWIND -->
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
    <div class="flex-1 ml-64">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">

            <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-200 max-w-[1400px] mx-auto">

                <h2 class="text-xl font-semibold mb-6">Danh sách bàn</h2>

                <!-- GRID -->
                <div class="grid grid-cols-4 gap-5">

                    <c:forEach var="t" items="${tables}">
                        <div class="border rounded-xl p-4 hover:shadow transition">

                            <h3 class="font-semibold text-lg mb-2">${t.name}</h3>

                            <p class="text-sm mb-3">
                                Trạng thái:
                                <span class="px-2 py-1 rounded text-xs
                                    ${t.status == 'empty' ? 'bg-green-200 text-green-800' : 'bg-red-200 text-red-800'}">
                                    ${t.status}
                                </span>
                            </p>

                            <a href="${pageContext.request.contextPath}/seller/order?tableId=${t.id}"
                               class="block text-center bg-cafe-brown text-white py-1 rounded hover:opacity-90">
                                Chọn bàn
                            </a>

                        </div>
                    </c:forEach>

                </div>

                <!-- ADD TABLE -->
                <div class="mt-8 max-w-md">

                    <form method="post"
                          action="${pageContext.request.contextPath}/seller/tables/add"
                          class="flex gap-3">

                        <input type="text" name="name"
                               class="border border-gray-300 rounded-lg px-3 py-2 w-full"
                               placeholder="Tên bàn" required>

                        <button class="bg-cafe-brown text-white px-4 rounded hover:opacity-90">
                            Thêm
                        </button>
                    </form>

                </div>

            </div>

        </div>



    </div>

</div>

</body>
</html>