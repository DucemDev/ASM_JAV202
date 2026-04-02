<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý đồ uống</title>

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
    <div id="mainContent" class="flex-1 ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">

            <div class="max-w-[1400px] mx-auto">

                <!-- CARD -->
                <div class="bg-white rounded-2xl shadow-lg p-8 border border-gray-200">

                    <h2 class="text-xl font-semibold text-gray-800 mb-6">
                        🍹 Quản lý đồ uống
                    </h2>

                    <!-- ERROR -->
                    <c:if test="${not empty error}">
                        <p class="mb-4 text-red-500 font-medium">${error}</p>
                    </c:if>

                    <!-- ADD BUTTON -->
                    <button onclick="openModal()"
                            class="mb-6 bg-cafe-brown text-white px-5 py-2 rounded-lg hover:opacity-90 transition">
                        + Thêm đồ uống
                    </button>

                    <!-- TABLE -->
                    <div class="overflow-x-auto">

                        <table class="w-full border border-gray-200 rounded-xl overflow-hidden">

                            <thead class="bg-[#f1e4d7] text-gray-700 text-sm">
                            <tr>
                                <th class="py-3">ID</th>
                                <th>Ảnh</th>
                                <th>Tên</th>
                                <th>Giá</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>

                            <tbody class="text-center text-sm">

                            <c:forEach items="${drinks}" var="d">
                                <tr class="border-t hover:bg-gray-50">

                                    <td class="py-3">${d.id}</td>

                                    <td>
                                        <img src="${pageContext.request.contextPath}/${d.image}"
                                             class="w-14 h-14 object-cover rounded-lg mx-auto"/>
                                    </td>

                                    <td class="font-medium">${d.name}</td>

                                    <td class="text-gray-600">${d.price} đ</td>

                                    <td class="space-x-2">

                                        <!-- EDIT -->
                                        <button
                                                class="px-3 py-1 text-sm bg-blue-500 text-white rounded-lg hover:opacity-90"
                                                data-id="${d.id}"
                                                data-name="${d.name}"
                                                data-price="${d.price}"
                                                onclick="editDrink(this)">
                                            Sửa
                                        </button>

                                        <!-- DELETE -->
                                        <form action="${pageContext.request.contextPath}/manager/drinks/delete"
                                              method="post"
                                              class="inline">

                                            <input type="hidden" name="id" value="${d.id}">

                                            <button onclick="return confirm('Bạn có chắc muốn xóa?')"
                                                    class="px-3 py-1 text-sm bg-red-500 text-white rounded-lg hover:opacity-90">
                                                Xóa
                                            </button>

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

    </div>

</div>

<!-- MODAL -->
<div class="fixed inset-0 bg-black/40 hidden items-center justify-center z-50" id="modal">

    <div class="bg-white rounded-xl p-6 w-[400px] shadow-lg">

        <h3 class="text-lg font-semibold mb-4">Thông tin đồ uống</h3>

        <form id="form" method="post" enctype="multipart/form-data" class="space-y-4">

            <input type="hidden" name="id" id="id">

            <!-- NAME -->
            <div>
                <label class="text-sm text-gray-600">Tên</label>
                <input name="name" id="name"
                       value="${oldName}"
                       class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2
                      focus:ring-2 focus:ring-cafe-brown outline-none
                      ${not empty errorName ? 'border-red-500' : ''}">
                <c:if test="${not empty errorName}">
                    <p class="text-red-500 text-sm">${errorName}</p>
                </c:if>
            </div>

            <!-- CATEGORY -->
            <div>
                <label class="text-sm text-gray-600">Loại</label>
                <select name="categoryId"
                        class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2">
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.id}" ${c.id == oldCategory ? 'selected' : ''}>
                                ${c.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- PRICE -->
            <div>
                <label class="text-sm text-gray-600">Giá</label>
                <input name="price" id="price"
                       value="${oldPrice}"
                       class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2
                      focus:ring-2 focus:ring-cafe-brown outline-none
                      ${not empty errorPrice ? 'border-red-500' : ''}">
                <c:if test="${not empty errorPrice}">
                    <p class="text-red-500 text-sm">${errorPrice}</p>
                </c:if>
            </div>

            <!-- IMAGE -->
            <div>
                <label class="text-sm text-gray-600">Ảnh</label>
                <input type="file" name="image"
                       class="w-full mt-1 text-sm">
            </div>

            <!-- BUTTON -->
            <div class="flex gap-2 pt-2">

                <button type="submit"
                        class="w-1/2 bg-cafe-brown text-white py-2 rounded-lg hover:opacity-90">
                    Lưu
                </button>

                <button type="button"
                        onclick="closeModal()"
                        class="w-1/2 bg-gray-400 text-white py-2 rounded-lg">
                    Hủy
                </button>

            </div>

        </form>

    </div>
</div>

<script>
    function openModal() {
        document.getElementById("modal").classList.remove("hidden");
        document.getElementById("modal").classList.add("flex");

        document.getElementById("form").action =
            "${pageContext.request.contextPath}/manager/drinks/add";

        document.getElementById("id").value = "";
        document.getElementById("name").value = "";
        document.getElementById("price").value = "";
    }

    function editDrink(btn) {
        document.getElementById("modal").classList.remove("hidden");
        document.getElementById("modal").classList.add("flex");

        document.getElementById("form").action =
            "${pageContext.request.contextPath}/manager/drinks/edit";

        document.getElementById("id").value = btn.dataset.id;
        document.getElementById("name").value = btn.dataset.name;
        document.getElementById("price").value = btn.dataset.price;
    }

    function closeModal() {
        document.getElementById("modal").classList.add("hidden");
    }
</script>

<script>
    window.onload = function () {
        const open = "${openModal}";
        if (open === "true") {
            openModal();
        }
    }
</script>

</body>
</html>