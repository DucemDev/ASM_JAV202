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

    <jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

    <div id="mainContent"
         class="flex-1 flex flex-col ml-64 transition-all duration-300 h-screen overflow-y-auto">

        <jsp:include page="/WEB-INF/public/layout/header.jsp"/>

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

                        <div class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/manager/drinks"
                               class="px-5 py-2 rounded-xl text-white shadow hover:scale-105 transition flex items-center gap-2"
                               style="background:#6b7280;">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                                </svg>
                                Làm mới
                            </a>
                            <button onclick="openModal()"
                                    class="px-5 py-2 rounded-xl text-white shadow-lg hover:scale-105 transition"
                                    style="background:linear-gradient(135deg,#27301B,#41521E);">
                                + Thêm đồ uống
                            </button>
                        </div>
                    </div>

                    <!-- NOTIFICATIONS -->
                    <div id="notification-area">
                        <c:if test="${not empty sessionScope.message}">
                            <div class="alert-box mb-4 p-3 rounded-xl bg-green-100 text-green-700 shadow-sm border border-green-200 flex justify-between items-center">
                                <span><strong class="font-bold">Thành công!</strong> ${sessionScope.message}</span>
                                <button onclick="this.parentElement.remove()" class="text-green-900">&times;</button>
                            </div>
                            <c:remove var="message" scope="session"/>
                        </c:if>

                        <c:if test="${not empty sessionScope.error or not empty error}">
                            <div class="alert-box mb-4 p-3 rounded-xl bg-red-100 text-red-700 shadow-sm border border-red-200 flex justify-between items-center">
                                <span><strong class="font-bold">Lỗi!</strong> ${not empty sessionScope.error ? sessionScope.error : error}</span>
                                <button onclick="this.parentElement.remove()" class="text-red-900">&times;</button>
                            </div>
                            <c:remove var="error" scope="session"/>
                        </c:if>
                    </div>

                    <!-- FILTER -->
                    <form method="get"
                          action="${pageContext.request.contextPath}/manager/drinks"
                          class="mb-6 grid grid-cols-1 md:grid-cols-4 gap-3">

                        <input type="text"
                               name="keyword"
                               value="${keyword}"
                               placeholder="Tìm theo tên đồ uống"
                               class="rounded-xl px-4 py-2 border backdrop-blur-xl focus:outline-none focus:ring-2 focus:ring-[#909632] transition"
                               style="background:rgba(255,255,255,0.35); border-color:#909632;">

                        <select name="categoryId"
                                class="rounded-xl px-4 py-2 border backdrop-blur-xl focus:outline-none focus:ring-2 focus:ring-[#909632] transition"
                                style="background:rgba(255,255,255,0.35); border-color:#909632;">
                            <option value="">Tất cả loại</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}" ${filterCategoryId == c.id ? 'selected' : ''}>${c.name}</option>
                            </c:forEach>
                        </select>

                        <select name="active"
                                class="rounded-xl px-4 py-2 border backdrop-blur-xl focus:outline-none focus:ring-2 focus:ring-[#909632] transition"
                                style="background:rgba(255,255,255,0.35); border-color:#909632;">
                            <option value="">Tất cả trạng thái</option>
                            <option value="true" ${filterActive == 'true' ? 'selected' : ''}>Hoạt động</option>
                            <option value="false" ${filterActive == 'false' ? 'selected' : ''}>Ngừng hoạt động</option>
                        </select>

                        <button type="submit" class="text-white px-5 py-2 rounded-xl shadow hover:scale-105 transition"
                                style="background:#41521E;">
                            Tìm kiếm
                        </button>

                    </form>

                    <!-- TABLE -->
                    <div class="overflow-x-auto rounded-xl">

                        <table class="w-full">

                            <thead class="text-[#27301B] text-sm uppercase tracking-wider"
                                   style="background:rgba(65,82,30,0.25);">
                            <tr>
                                <th class="py-4">STT</th>
                                <th>Ảnh</th>
                                <th>Tên</th>
                                <th>Giá</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>

                            <tbody class="text-center text-sm">

                            <c:forEach items="${drinks}" var="d" varStatus="status">
                                <tr class="border-t border-white/30 hover:bg-white/15 transition">

                                    <td class="py-4 font-semibold text-gray-600">
                                        ${(currentPage - 1) * 10 + status.index + 1}
                                    </td>

                                    <td>
                                        <img src="${pageContext.request.contextPath}/${d.image}"
                                             class="w-14 h-14 object-cover rounded-xl mx-auto shadow-md border border-white/50"/>
                                    </td>

                                    <td class="font-bold text-[#27301B]">${d.name}</td>

                                    <td class="text-[#41521E] font-bold">
                                            ${String.format("%,d", d.price)} ₫
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${d.active}">
                                                <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 text-xs font-bold">
                                                    Hoạt động
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 rounded-full bg-gray-200 text-gray-700 text-xs font-bold">
                                                    Ngừng hoạt động
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <div class="flex justify-center">
                                            <button
                                                    class="w-16 py-1.5 text-xs font-bold text-white rounded-lg hover:scale-105 transition shadow-md"
                                                    style="background:#909632;"
                                                    data-id="${d.id}"
                                                    data-name="${d.name}"
                                                    data-price="${d.price}"
                                                    data-active="${d.active}"
                                                    data-category="${d.categoryId}"
                                                    onclick="editDrink(this)">
                                                Sửa
                                            </button>
                                        </div>
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

            <input type="hidden" name="id" id="id" value="${oldId}">
            <input type="hidden" name="page" value="${currentPage}">

            <div>
                <label class="text-sm text-[#41521E]">Tên</label>
                <input name="name" id="name" value="${oldName}"
                       class="w-full mt-1 px-3 py-2 rounded-lg border focus:ring-2 focus:ring-[#909632] outline-none">
                <c:if test="${not empty errorName}">
                    <p class="text-red-500 text-xs mt-1 font-medium">${errorName}</p>
                </c:if>
            </div>

            <div>
                <label class="text-sm text-[#41521E]">Loại</label>
                <select name="categoryId" id="categoryId" class="w-full mt-1 px-3 py-2 rounded-lg border focus:ring-2 focus:ring-[#909632] outline-none">
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.id}" ${oldCategory == c.id ? 'selected' : ''}>${c.name}</option>
                    </c:forEach>
                </select>
                <c:if test="${not empty errorCategory}">
                    <p class="text-red-500 text-xs mt-1 font-medium">${errorCategory}</p>
                </c:if>
            </div>

            <div>
                <label class="text-sm text-[#41521E]">Giá</label>
                <input name="price" id="price" value="${oldPrice}"
                       class="w-full mt-1 px-3 py-2 rounded-lg border focus:ring-2 focus:ring-[#909632] outline-none">
                <c:if test="${not empty errorPrice}">
                    <p class="text-red-500 text-xs mt-1 font-medium">${errorPrice}</p>
                </c:if>
            </div>

            <div>
                <label class="text-sm text-[#41521E]">Trạng thái</label>
                <select name="active" id="activeSelect"
                        class="w-full mt-1 px-3 py-2 rounded-lg border focus:ring-2 focus:ring-[#909632] outline-none">
                    <option value="true">Hoạt động</option>
                    <option value="false">Ngừng hoạt động</option>
                </select>
            </div>

            <div class="flex flex-col items-center gap-3">
                <label class="text-sm text-[#41521E] self-start">Ảnh đồ uống</label>
                <div class="relative w-32 h-32 rounded-xl overflow-hidden border-2 border-dashed border-[#909632] flex items-center justify-center bg-gray-50">
                    <img id="previewImage" src="" class="w-full h-full object-cover hidden">
                    <span id="noImageText" class="text-gray-400 text-xs text-center px-2">Chưa có ảnh</span>
                </div>
                <input type="file" name="image" onchange="previewFile(this)" 
                       class="w-full text-xs text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-xs file:font-semibold file:bg-[#909632]/10 file:text-[#41521E] hover:file:bg-[#909632]/20">
            </div>

            <div class="flex gap-2 pt-2">

                <button type="submit"
                        class="w-1/2 text-white py-2 rounded-lg font-bold shadow-md hover:scale-105 transition"
                        style="background:#27301B;">
                    Lưu
                </button>

                <button type="button"
                        onclick="closeModal()"
                        class="w-1/2 bg-gray-400 text-white py-2 rounded-lg font-bold shadow-md hover:scale-105 transition">
                    Hủy
                </button>

            </div>

        </form>

    </div>
</div>

<script>
    // Xem trước ảnh khi chọn file
    function previewFile(input) {
        const preview = document.getElementById('previewImage');
        const text = document.getElementById('noImageText');
        const file = input.files[0];
        const reader = new FileReader();

        reader.onloadend = function () {
            preview.src = reader.result;
            preview.classList.remove('hidden');
            text.classList.add('hidden');
        }

        if (file) {
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
            preview.classList.add('hidden');
            text.classList.remove('hidden');
        }
    }

    // Tự động ẩn thông báo sau 3 giây
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert-box');
        alerts.forEach(alert => {
            alert.style.transition = "opacity 0.5s ease";
            alert.style.opacity = "0";
            setTimeout(() => alert.remove(), 500);
        });
    }, 3000);

    // Giữ modal mở nếu có lỗi từ server
    window.onload = function() {
        <c:if test="${openModal}">
            document.getElementById("modal").classList.remove("hidden");
            document.getElementById("modal").classList.add("flex");
            
            // Nếu là lỗi khi Edit, gán lại ID vào form action
            <c:if test="${not empty oldId}">
                document.getElementById("form").action = "${pageContext.request.contextPath}/manager/drinks/edit";
            </c:if>
        </c:if>
    }

    function openModal() {
        document.getElementById("modal").classList.remove("hidden");
        document.getElementById("modal").classList.add("flex");

        document.getElementById("form").action =
            "${pageContext.request.contextPath}/manager/drinks/add";

        document.getElementById("id").value = "";
        document.getElementById("name").value = "";
        document.getElementById("price").value = "";
        document.getElementById("activeSelect").value = "true";
        
        // Reset ảnh xem trước
        document.getElementById("previewImage").src = "";
        document.getElementById("previewImage").classList.add("hidden");
        document.getElementById("noImageText").classList.remove("hidden");
        
        // Xóa các thông báo lỗi cũ
        const errorMsgs = document.querySelectorAll('#modal p.text-red-500');
        errorMsgs.forEach(m => m.remove());
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
        document.getElementById("categoryId").value = btn.dataset.category;
        
        // Hiển thị ảnh hiện tại
        const currentImage = btn.closest('tr').querySelector('img').src;
        const preview = document.getElementById("previewImage");
        const text = document.getElementById("noImageText");
        
        if (currentImage) {
            preview.src = currentImage;
            preview.classList.remove("hidden");
            text.classList.add("hidden");
        }

        // Xóa các thông báo lỗi cũ
        const errorMsgs = document.querySelectorAll('#modal p.text-red-500');
        errorMsgs.forEach(m => m.remove());
    }

    function closeModal() {
        document.getElementById("modal").classList.add("hidden");
        // Reset URL về mặc định để xóa các attribute cũ nếu cần
        if(window.location.search.includes('openModal')) {
            window.location.href = "${pageContext.request.contextPath}/manager/drinks";
        }
    }
</script>

</body>
</html>
