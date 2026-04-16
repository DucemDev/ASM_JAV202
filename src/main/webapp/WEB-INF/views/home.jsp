<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>

<div class="layout">

    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <div id="mainContent" class="main">

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <div class="content">

            <div class="grid grid-2 gap-4">

                <!-- SLIDE -->
                <div class="card col-span-2 overflow-hidden">
                    <div id="slides" class="flex transition-all duration-500">
                        <img src="${pageContext.request.contextPath}/assets/image/slide1.jpg" class="w-full">
                        <img src="${pageContext.request.contextPath}/assets/image/slide2.jpg" class="w-full">
                        <img src="${pageContext.request.contextPath}/assets/image/slide3.jpg" class="w-full">
                    </div>
                </div>

                <!-- CARD -->
                <div class="card">
                    <p>Bàn đang dùng</p>
                    <p class="text-2xl font-bold">0</p>
                </div>

                <!-- TABLE -->
                <div class="card">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Tên</th>
                            <th>Ngày</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr><td>--</td><td>--</td></tr>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>

    </div>

</div>

<script>
let i = 0;
setInterval(() => {
    const slides = document.getElementById("slides");
    if (!slides) return;
    i = (i + 1) % 3;
    slides.style.transform = `translateX(-${i * 100}%)`;
}, 3000);
</script>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>