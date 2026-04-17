<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Chi tiết hóa đơn</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative overflow-hidden"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

    <!-- SIDEBAR -->
    <jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

    <!-- MAIN -->
    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/public/layout/header.jsp"/>

        <!-- CONTENT -->
        <div class="p-8">
            <div class="max-w-[1200px] mx-auto">

                <!-- TITLE -->
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold text-[#27301B]">
                        Chi tiết hóa đơn #${bill.id}
                    </h1>

                    <a href="${pageContext.request.contextPath}/manager/bill"
                       class="px-4 py-2 rounded-xl text-white shadow-lg hover:scale-105 transition"
                       style="background:#27301B;">
                        Quay lại
                    </a>
                </div>

                <!-- PREP -->
                <c:set var="isOnline" value="${bill.type == 'online'}"/>
                <c:set var="displayTable" value="${isOnline || bill.tableId <= 0 ? 'Online (không bàn)' : 'Bàn '.concat(bill.tableId)}"/>
                <c:set var="displayCreator" value="${not empty bill.userFullName ? bill.userFullName : 'Không rõ'}"/>

                <!-- BILL INFO -->
                <div class="rounded-2xl shadow-xl p-6 mb-6 grid grid-cols-2 gap-6 backdrop-blur-xl border"
                     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">

                    <div>
                        <p class="text-[#41521E]">Bàn</p>
                        <p class="font-semibold text-lg text-[#27301B]">${displayTable}</p>
                    </div>

                    <div>
                        <p class="text-[#41521E]">Trạng thái</p>
                        <c:choose>
                            <c:when test="${bill.status == 'waiting'}">
                                <span class="px-3 py-1 rounded-full text-sm font-semibold"
                                      style="background:rgba(65,82,30,0.2); color:#41521E;">
                                    Đang chờ
                                </span>
                            </c:when>
                            <c:when test="${bill.status == 'pending_verify'}">
                                <span class="px-3 py-1 rounded-full text-sm font-semibold"
                                      style="background:rgba(144,150,50,0.2); color:#909632;">
                                    Chờ xác nhận
                                </span>
                            </c:when>
                            <c:when test="${bill.status == 'finish'}">
                                <span class="px-3 py-1 rounded-full text-sm font-semibold"
                                      style="background:rgba(153,165,88,0.3); color:#27301B;">
                                    Hoàn thành
                                </span>
                            </c:when>
                            <c:when test="${bill.status == 'cancel'}">
                                <span class="px-3 py-1 rounded-full text-sm font-semibold"
                                      style="background:rgba(255,0,0,0.15); color:#b91c1c;">
                                    Đã hủy
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="px-3 py-1 rounded-full text-sm font-semibold bg-gray-100 text-gray-700">
                                    ${bill.status}
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div>
                        <p class="text-[#41521E]">Loại</p>
                        <p class="font-semibold text-[#27301B]">
                            <c:choose>
                                <c:when test="${bill.type == 'pos'}">Tại quầy</c:when>
                                <c:when test="${bill.type == 'online'}">Online</c:when>
                                <c:otherwise>${bill.type}</c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <div>
                        <p class="text-[#41521E]">Người tạo</p>
                        <p class="font-semibold text-[#27301B]">${displayCreator}</p>
                    </div>

                    <div>
                        <p class="text-[#41521E]">Thời gian tạo</p>
                        <p class="font-semibold text-[#27301B]">${bill.createdAt}</p>
                    </div>

                    <div>
                        <p class="text-[#41521E]">Tổng tiền (DB)</p>
                        <p class="font-bold text-xl text-[#27301B]">${bill.total} đ</p>
                    </div>
                </div>

                <!-- TABLE -->
                <div class="rounded-2xl shadow-xl overflow-hidden backdrop-blur-xl border"
                     style="background:rgba(255,255,255,0.25); border:1px solid rgba(255,255,255,0.3);">

                    <table class="w-full text-sm text-center">
                        <thead style="background:rgba(65,82,30,0.2);" class="text-[#27301B]">
                        <tr>
                            <th class="p-3">Đồ uống</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:set var="computedTotal" value="0"/>
                        <c:forEach var="item" items="${billItems}">
                            <c:set var="lineTotal" value="${item.price * item.quantity}"/>
                            <c:set var="computedTotal" value="${computedTotal + lineTotal}"/>

                            <tr class="border-t border-white/20 hover:bg-white/10 transition">
                                <td class="p-3">
                                    <c:set var="drinkName" value="Không rõ"/>
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
                                <td colspan="4" class="p-4 text-gray-500">Không có dữ liệu</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- TOTAL -->
                <div class="mt-6 text-right">
                    <p class="text-lg text-[#27301B]">
                        Tổng:
                        <span class="font-bold text-xl">${computedTotal} đ</span>
                    </p>
                </div>

            </div>
        </div>

    </div>
</div>
</body>
</html>
