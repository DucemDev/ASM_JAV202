<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Trang cá nhân</title>

    <script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

    <!-- SIDEBAR -->
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>

    <!-- MAIN -->
    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <!-- CONTENT -->
        <div class="p-8">

            <div class="max-w-[900px] mx-auto">

                <!-- CARD -->
                <div class="rounded-2xl shadow-2xl p-8 border backdrop-blur-xl"
                     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

                    <!-- TITLE -->
                    <h1 class="text-2xl font-bold text-[#27301B] mb-8 text-center">
                        Thông tin cá nhân
                    </h1>

                    <!-- INFO GRID -->
                    <div class="grid grid-cols-2 gap-6 text-sm">

                        <div class="p-4 rounded-xl backdrop-blur-xl"
                             style="background:rgba(255,255,255,0.4);">
                            <span class="text-[#909632] text-xs">Họ tên</span>
                            <div class="font-semibold text-[#27301B] mt-1">
                                ${sessionScope.user.fullname}
                            </div>
                        </div>

                        <div class="p-4 rounded-xl backdrop-blur-xl"
                             style="background:rgba(255,255,255,0.4);">
                            <span class="text-[#909632] text-xs">Email</span>
                            <div class="font-semibold text-[#27301B] mt-1">
                                ${sessionScope.user.email}
                            </div>
                        </div>

                        <div class="p-4 rounded-xl backdrop-blur-xl"
                             style="background:rgba(255,255,255,0.4);">
                            <span class="text-[#909632] text-xs">Mật khẩu</span>
                            <div class="font-semibold text-[#27301B] mt-1">
                                ••••••••
                            </div>
                        </div>

                        <div class="p-4 rounded-xl backdrop-blur-xl"
                             style="background:rgba(255,255,255,0.4);">
                            <span class="text-[#909632] text-xs">ID</span>
                            <div class="font-semibold text-[#27301B] mt-1">
                                ${sessionScope.user.id}
                            </div>
                        </div>

                        <div class="p-4 rounded-xl backdrop-blur-xl col-span-2"
                             style="background:rgba(255,255,255,0.4);">
                            <span class="text-[#909632] text-xs">Số điện thoại</span>
                            <div class="font-semibold text-[#27301B] mt-1">
                                ${sessionScope.user.phone}
                            </div>
                        </div>

                    </div>

                    <!-- ACTION -->
                    <div class="mt-10 flex justify-center gap-6">

                        <a href="${pageContext.request.contextPath}/change-information">
                            <button class="text-white px-6 py-2 rounded-xl shadow-lg hover:scale-105 transition"
                                    style="background:#27301B;">
                                Chỉnh sửa thông tin
                            </button>
                        </a>

                        <a href="${pageContext.request.contextPath}/change-password">
                            <button class="text-white px-6 py-2 rounded-xl shadow-lg hover:scale-105 transition"
                                    style="background:#41521E;">
                                Đổi mật khẩu
                            </button>
                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>