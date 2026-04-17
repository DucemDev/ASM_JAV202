<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý đồ uống</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent"
         class="flex-1 flex flex-col ml-64 transition-all duration-300 h-screen overflow-y-auto">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">

            <div class="max-w-[1400px] mx-auto">

                <!-- CARD -->
                <div class="rounded-2xl shadow-2xl p-8 border backdrop-blur-xl"
                     style="background:rgba(255,255,255,0.28); border:1px solid rgba(255,255,255,0.35);">

                    <!-- HEADER -->
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-2xl font-bold text-[#27301B]">
                            Quản lý đồ uống
                        </h2>

                        <button onclick="openModal()"
                                class="px-5 py-2 rounded-xl text-white shadow-lg hover:scale-105 transition"
                                style="background:linear-gradient(135deg,#27301B,#41521E);">
                            + Thêm đồ uống
                        </button>
                    </div>

                    <c:if test="${not empty error}">
                        <p class="mb-4 text-red-500 font-medium">${error}</p>
                    </c:if>

                    <!-- FILTER -->
                    <form method="get"
                          action="${pageContext.request.contextPath}/manager/drinks"
                          class="mb-6 grid grid-cols-1 md:grid-cols-4 gap-3">

                        <input type="text"
                               name="keyword"
                               value="${keyword}"
                               placeholder="Tìm theo tên đồ uống"
                               class="rounded-xl px-4 py-2 border backdrop-blur-xl focus:outline-none focus:ring-2"
                               style="background:rgba(255,255,255,0.35); border-color:#909632;">

                        <select name="categoryId"
                                class="rounded-xl px-4 py-2 border backdrop-blur-xl"
                                style="background:rgba(255,255,255,0.35); border-color:#909632;">
                            <option value="">Tất cả loại</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}" ${filterCategoryId == c.id ? 'selected' : ''}>${c.name}</option>
                            </c:forEach>
                        </select>

                        <select name="active"
                                class="rounded-xl px-4 py-2 border backdrop-blur-xl"
                                style="background:rgba(255,255,255,0.35); border-color:#909632;">
                            <option value="">Tất cả trạng thái</option>
                            <option value="true" ${filterActive == 'true' ? 'selected' : ''}>Hoạt động</option>
                            <option value="false" ${filterActive == 'false' ? 'selected' : ''}>Ngừng hoạt động</option>
                        </select>

                        <button class="text-white px-5 py-2 rounded-xl shadow hover:scale-105 transition"
                                style="background:#41521E;">
                            Tìm kiếm
                        </button>

                    </form>

                    <!-- TABLE -->
                    <div class="overflow-x-auto rounded-xl">

                        <table class="w-full">

                            <thead class="text-[#27301B] text-sm"
                                   style="background:rgba(65,82,30,0.25);">
                            <tr>
                                <th class="py-3">ID</th>
                                <th>Ảnh</th>
                                <th>Tên</th>
                                <th>Giá</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>

                            <tbody class="text-center text-sm">

                            <c:forEach items="${drinks}" var="d">
                                <tr class="border-t border-white/30 hover:bg-white/15 transition">

                                    <td class="py-3">${d.id}</td>

                                    <td>
                                        <img src="${pageContext.request.contextPath}/${d.image}"
                                             class="w-14 h-14 object-cover rounded-xl mx-auto shadow"/>
                                    </td>

                                    <td class="font-semibold text-[#27301B]">${d.name}</td>

                                    <td class="text-[#41521E] font-medium">
                                            ${String.format("%,d", d.price)} ₫
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${d.active}">
                                                <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 text-xs font-semibold">
                                                    Hoạt động
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 rounded-full bg-gray-200 text-gray-700 text-xs font-semibold">
                                                    Ngừng hoạt động
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <button
                                                class="px-3 py-1 text-sm text-white rounded-lg hover:scale-105 transition shadow"
                                                style="background:#909632;"
                                                data-id="${d.id}"
                                                data-name="${d.name}"
                                                data-price="${d.price}"
                                                data-active="${d.active}"
                                                onclick="editDrink(this)">
                                            Sửa
                                        </button>
                                    </td>

                                </tr>
                            </c:forEach>

                            </tbody>

                        </table>

                    </div>

                    <!-- PAGINATION -->
                    <c:if test="${totalPages > 1}">
                        <div class="flex justify-center gap-2 mt-6">
                            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                <a href="${pageContext.request.contextPath}/manager/drinks?page=${pageNumber}&keyword=${keyword}&categoryId=${filterCategoryId}&active=${filterActive}"
                                   class="px-3 py-2 rounded-lg border transition"
                                   style="${pageNumber == currentPage ? 'background:#27301B;color:white;border-color:#27301B;' : 'background:white;color:#333;border-color:#ccc;'}">
                                        ${pageNumber}
                                </a>
                            </c:forEach>
                        </div>
                    </c:if>

                </div>

            </div>

        </div>

    </div>

</div>

<!-- MODAL -->
<div class="fixed inset-0 bg-black/40 hidden items-center justify-center z-50" id="modal">

    <div class="rounded-xl p-6 w-[400px] shadow-2xl backdrop-blur-xl border"
         style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

        <h3 class="text-lg font-semibold mb-4 text-[#27301B]">Thông tin đồ uống</h3>

        <form id="form" method="post" enctype="multipart/form-data" class="space-y-4">

            <input type="hidden" name="id" id="id">
            <input type="hidden" name="page" value="${currentPage}">

            <div>
                <label class="text-sm text-[#41521E]">Tên</label>
                <input name="name" id="name"
                       class="w-full mt-1 px-3 py-2 rounded-lg border">
            </div>

            <div>
                <label class="text-sm text-[#41521E]">Loại</label>
                <select name="categoryId" class="w-full mt-1 px-3 py-2 rounded-lg border">
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.id}">${c.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div>
                <label class="text-sm text-[#41521E]">Giá</label>
                <input name="price" id="price"
                       class="w-full mt-1 px-3 py-2 rounded-lg border">
            </div>

            <div>
                <label class="text-sm text-[#41521E]">Trạng thái</label>
                <select name="active" id="activeSelect"
                        class="w-full mt-1 px-3 py-2 rounded-lg border">
                    <option value="true">Hoạt động</option>
                    <option value="false">Ngừng hoạt động</option>
                </select>
            </div>

            <div>
                <label class="text-sm text-[#41521E]">Ảnh</label>
                <input type="file" name="image">
            </div>

            <div class="flex gap-2 pt-2">

                <button type="submit"
                        class="w-1/2 text-white py-2 rounded-lg"
                        style="background:#27301B;">
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
        document.getElementById("activeSelect").value = "true";
    }

    function editDrink(btn) {
        document.getElementById("modal").classList.remove("hidden");
        document.getElementById("modal").classList.add("flex");

        document.getElementById("form").action =
            "${pageContext.request.contextPath}/manager/drinks/edit";

        document.getElementById("id").value = btn.dataset.id;
        document.getElementById("name").value = btn.dataset.name;
        document.getElementById("price").value = btn.dataset.price;
        document.getElementById("activeSelect").value = btn.dataset.active;
    }

    function closeModal() {
        document.getElementById("modal").classList.add("hidden");
    }
</script>

</body>
</html>