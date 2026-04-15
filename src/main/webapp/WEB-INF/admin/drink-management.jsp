<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quan ly do uong</title>

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

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="flex-1 ml-64 transition-all duration-300">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="p-8">

            <div class="max-w-[1400px] mx-auto">

                <div class="bg-white rounded-2xl shadow-lg p-8 border border-gray-200">

                    <h2 class="text-xl font-semibold text-gray-800 mb-6">
                        Quan ly do uong
                    </h2>

                    <c:if test="${not empty error}">
                        <p class="mb-4 text-red-500 font-medium">${error}</p>
                    </c:if>

                    <button onclick="openModal()"
                            class="mb-6 bg-cafe-brown text-white px-5 py-2 rounded-lg hover:opacity-90 transition">
                        + Them do uong
                    </button>

                    <form method="get"
                          action="${pageContext.request.contextPath}/manager/drinks"
                          class="mb-6 grid grid-cols-1 md:grid-cols-4 gap-3">
                        <input type="text"
                               name="keyword"
                               value="${keyword}"
                               placeholder="Tim theo ten do uong"
                               class="border rounded-lg px-4 py-2">

                        <select name="categoryId" class="border rounded-lg px-4 py-2">
                            <option value="">Tat ca loai</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}" ${filterCategoryId == c.id ? 'selected' : ''}>${c.name}</option>
                            </c:forEach>
                        </select>

                        <select name="active" class="border rounded-lg px-4 py-2">
                            <option value="">Tat ca trang thai</option>
                            <option value="true" ${filterActive == 'true' ? 'selected' : ''}>Hoat dong</option>
                            <option value="false" ${filterActive == 'false' ? 'selected' : ''}>Ngung hoat dong</option>
                        </select>

                        <button class="bg-gray-700 text-white px-5 py-2 rounded-lg hover:opacity-90">
                            Tim kiem
                        </button>
                    </form>

                    <div class="overflow-x-auto">

                        <table class="w-full border border-gray-200 rounded-xl overflow-hidden">

                            <thead class="bg-[#f1e4d7] text-gray-700 text-sm">
                            <tr>
                                <th class="py-3">ID</th>
                                <th>Anh</th>
                                <th>Ten</th>
                                <th>Gia</th>
                                <th>Trang thai</th>
                                <th>Hanh dong</th>
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

                                    <td class="text-gray-600">
                                            ${String.format("%,d", d.price)} ₫
                                    </td>
                                    <script>
                                        const priceInput = document.getElementById("price");

                                        if (priceInput) {
                                            priceInput.addEventListener("input", function () {

                                                let value = this.value.replace(/\D/g, ""); // bỏ chữ

                                                if (value === "") {
                                                    this.value = "";
                                                    return;
                                                }

                                                this.value = Number(value).toLocaleString("vi-VN");
                                            });
                                        }
                                    </script>
                                    <td>
                                        <c:choose>
                                            <c:when test="${d.active}">
                                                <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 font-medium">
                                                    Hoat dong
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 rounded-full bg-gray-200 text-gray-700 font-medium">
                                                    Ngung hoat dong
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="space-x-2">

                                        <button
                                                class="px-3 py-1 text-sm bg-blue-500 text-white rounded-lg hover:opacity-90"
                                                data-id="${d.id}"
                                                data-name="${d.name}"
                                                data-price="${d.price}"
                                                onclick="editDrink(this)">
                                            Sua
                                        </button>

                                        <form action="${pageContext.request.contextPath}/manager/drinks/delete"
                                              method="post"
                                              class="inline">

                                            <input type="hidden" name="id" value="${d.id}">
                                            <input type="hidden" name="page" value="${currentPage}">
                                            <input type="hidden" name="keyword" value="${keyword}">
                                            <input type="hidden" name="categoryId" value="${filterCategoryId}">
                                            <input type="hidden" name="active" value="${filterActive}">

                                            <button onclick="return confirm('Ban co chac muon xoa?')"
                                                    class="px-3 py-1 text-sm bg-red-500 text-white rounded-lg hover:opacity-90">
                                                Xoa
                                            </button>

                                        </form>

                                    </td>

                                </tr>
                            </c:forEach>

                            </tbody>

                        </table>

                    </div>

                    <c:if test="${totalPages > 1}">
                        <div class="flex justify-center gap-2 mt-6">
                            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                <a href="${pageContext.request.contextPath}/manager/drinks?page=${pageNumber}&keyword=${keyword}&categoryId=${filterCategoryId}&active=${filterActive}"
                                   class="px-3 py-2 rounded-lg border ${pageNumber == currentPage ? 'bg-cafe-brown text-white border-cafe-brown' : 'bg-white text-gray-700 border-gray-300 hover:bg-gray-50'}">
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

<div class="fixed inset-0 bg-black/40 hidden items-center justify-center z-50" id="modal">

    <div class="bg-white rounded-xl p-6 w-[400px] shadow-lg">

        <h3 class="text-lg font-semibold mb-4">Thong tin do uong</h3>

        <form id="form" method="post" enctype="multipart/form-data" class="space-y-4">

            <input type="hidden" name="id" id="id">
            <input type="hidden" name="page" id="page" value="${currentPage}">
            <input type="hidden" name="keyword" id="keyword" value="${keyword}">
            <input type="hidden" name="active" id="active" value="${filterActive}">
<%--            <input type="hidden" name="categoryId" id="categoryIdHidden" value="${filterCategoryId}">--%>

            <div>
                <label class="text-sm text-gray-600">Ten</label>
                <input name="name" id="name"
                       value="${oldName}"
                       class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2
                      focus:ring-2 focus:ring-cafe-brown outline-none
                      ${not empty errorName ? 'border-red-500' : ''}">
                <c:if test="${not empty errorName}">
                    <p class="text-red-500 text-sm">${errorName}</p>
                </c:if>
            </div>

            <div>
                <label class="text-sm text-gray-600">Loai</label>
                <select name="categoryId"
                        class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2">
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.id}" ${c.id == oldCategory ? 'selected' : ''}>
                                ${c.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div>
                <label class="text-sm text-gray-600">Gia</label>
                <input name="price" id="price"
                       value="${oldPrice}"
                       class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2
                      focus:ring-2 focus:ring-cafe-brown outline-none
                      ${not empty errorPrice ? 'border-red-500' : ''}">
                <c:if test="${not empty errorPrice}">
                    <p class="text-red-500 text-sm">${errorPrice}</p>
                </c:if>
            </div>

            <div>
                <label class="text-sm text-gray-600">Anh</label>
                <input type="file" name="image"
                       class="w-full mt-1 text-sm">
            </div>

            <div class="flex gap-2 pt-2">

                <button type="submit"
                        class="w-1/2 bg-cafe-brown text-white py-2 rounded-lg hover:opacity-90">
                    Luu
                </button>

                <button type="button"
                        onclick="closeModal()"
                        class="w-1/2 bg-gray-400 text-white py-2 rounded-lg">
                    Huy
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
        document.getElementById("page").value = "${currentPage}";
        document.getElementById("name").value = "";
        document.getElementById("price").value = "";
    }

    function editDrink(btn) {
        document.getElementById("modal").classList.remove("hidden");
        document.getElementById("modal").classList.add("flex");

        document.getElementById("form").action =
            "${pageContext.request.contextPath}/manager/drinks/edit";

        document.getElementById("id").value = btn.dataset.id;
        document.getElementById("page").value = "${currentPage}";
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
