<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Thông báo lỗi - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- BG -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="flex relative z-10">

    <!-- SIDEBAR -->
    <jsp:include page="/WEB-INF/public/layout/sidebar.jsp"/>

    <!-- MAIN -->
    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <jsp:include page="/WEB-INF/public/layout/header.jsp"/>

        <!-- CONTENT -->
        <div class="p-8 flex items-center justify-center min-h-[70vh]">

            <div class="max-w-[500px] w-full">

                <!-- CARD -->
                <div class="rounded-3xl shadow-2xl p-10 backdrop-blur-xl border text-center"
                     style="background:rgba(255,255,255,0.4); border:1px solid rgba(255,255,255,0.4);">

                    <!-- ICON -->
                    <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                    </div>

                    <!-- TITLE -->
                    <h1 class="text-3xl font-bold text-[#27301B] mb-4">
                        Đã có lỗi xảy ra!
                    </h1>

                    <p class="text-gray-600 mb-8 leading-relaxed">
                        Rất tiếc, hệ thống gặp sự cố không mong muốn hoặc trang bạn tìm không tồn tại.
                    </p>

                    <!-- BUTTON -->
                    <div class="space-y-3">
                        <a href="${pageContext.request.contextPath}/home" 
                           class="block w-full text-white py-3 rounded-xl shadow-lg hover:scale-105 transition font-semibold"
                           style="background:#27301B;">
                            Về trang chủ
                        </a>
                        
                        <button onclick="history.back()" 
                                class="block w-full py-3 rounded-xl border border-gray-400 text-[#27301B] hover:bg-white/40 transition font-semibold">
                            Quay lại trang trước
                        </button>
                    </div>

                    <!-- FOOTER -->
                    <p class="mt-8 text-xs text-gray-500 italic">
                        Nếu lỗi vẫn tiếp diễn, vui lòng liên hệ bộ phận hỗ trợ kỹ thuật.
                    </p>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>
