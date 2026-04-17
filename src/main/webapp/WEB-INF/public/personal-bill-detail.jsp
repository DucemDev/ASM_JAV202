<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Chi tiết hóa đơn cá nhân</title>
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

    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <jsp:include page="/WEB-INF/public/layout/header.jsp"/>

        <div class="p-8">
            <div class="max-w-[1200px] mx-auto">

                <!-- HEADER -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-[#27301B]">
                        Hóa đơn #${bill.id}
                    </h1>

                    <a href="${pageContext.request.contextPath}/personal-bill"
                       class="text-white px-4 py-2 rounded-xl shadow hover:scale-105 transition"
                       style="background:#41521E;">
                        Quay lại
                    </a>
                </div>

                <!-- INFO -->
                <div class="rounded-2xl shadow-xl p-6 mb-6 grid grid-cols-2 gap-6 backdrop-blur-xl border"
                     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.3);">

                    <div>
                        <p class="text-[#909632] text-sm">Loại</p>
                        <p class="font-semibold text-[#27301B]">${bill.type}</p>
                    </div>

                    <div>
                        <p class="text-[#909632] text-sm">Trạng thái</p>
                        <p class="font-semibold text-[#27301B]">${bill.status}</p>
                    </div>

                    <div>
                        <p class="text-[#909632] text-sm">Bàn</p>
                        <p class="font-semibold text-[#27301B]">
                            <c:choose>
                                <c:when test="${bill.type == 'online' || bill.tableId <= 0}">
                                    Online (không bàn)
                                </c:when>
                                <c:otherwise>Bàn ${bill.tableId}</c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <div>
                        <p class="text-[#909632] text-sm">Ngày tạo</p>
                        <p class="font-semibold text-[#27301B]">${bill.createdAt}</p>
                    </div>

                </div>

                <!-- TABLE -->
                <div class="rounded-2xl shadow-xl overflow-hidden backdrop-blur-xl border"
                     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.3);">

                    <table class="w-full text-sm text-center">

                        <thead style="background:linear-gradient(135deg,#dfe6c3,#cfd5a5);" class="text-[#27301B]">
                        <tr>
                            <th class="p-3 text-left">Tên nước</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:set var="sum" value="0"/>

                        <c:forEach var="item" items="${billItems}">
                            <c:set var="lineTotal" value="${item.price * item.quantity}"/>
                            <c:set var="sum" value="${sum + lineTotal}"/>

                            <tr class="border-t border-white/40 hover:bg-white/20 transition">

                                <td class="p-3 text-left font-medium text-[#27301B]">
                                    <c:set var="drinkName" value="Không rõ"/>
                                    <c:forEach var="d" items="${drinks}">
                                        <c:if test="${d.id == item.drinkId}">
                                            <c:set var="drinkName" value="${d.name}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${drinkName}
                                </td>

                                <td class="text-[#41521E]">${item.price} đ</td>

                                <td>${item.quantity}</td>

                                <td class="font-semibold text-[#27301B]">${lineTotal} đ</td>

                            </tr>
                        </c:forEach>

                        <c:if test="${empty billItems}">
                            <tr>
                                <td colspan="4" class="p-6 text-gray-500">
                                    Không có món trong hóa đơn
                                </td>
                            </tr>
                        </c:if>

                        </tbody>

                    </table>

                </div>

                <!-- TOTAL -->
                <div class="mt-6 flex justify-end items-center text-lg">
                    <span class="mr-2 text-gray-600">Tổng:</span>
                    <span class="font-bold text-xl text-[#27301B]">
                        ${sum} đ
                    </span>
                </div>

            </div>
        </div>

    </div>

</div>

</body>
</html>
