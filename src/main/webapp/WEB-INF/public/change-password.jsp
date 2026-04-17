<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>

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

            <div class="max-w-[600px] mx-auto">

                <!-- CARD -->
                <div class="rounded-2xl shadow-2xl p-8 border backdrop-blur-xl"
                     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

                    <!-- TITLE -->
                    <h1 class="text-2xl font-bold text-[#27301B] mb-8 text-center">
                        Đổi mật khẩu
                    </h1>

                    <!-- FORM -->
                    <form method="post"
                          action="${pageContext.request.contextPath}/change-password"
                          class="space-y-5">

                        <!-- NEW PASSWORD -->
                        <div>
                            <label class="text-sm text-[#909632]">Mật khẩu mới</label>
                            <input type="password" name="newPassword"
                                   placeholder="Nhập mật khẩu mới"
                                   class="w-full mt-1 rounded-lg px-3 py-2 border focus:ring-2 outline-none"
                                   style="background:rgba(255,255,255,0.4); border-color:#909632;">
                        </div>

                        <!-- CONFIRM PASSWORD -->
                        <div>
                            <label class="text-sm text-[#909632]">Xác nhận mật khẩu</label>
                            <input type="password" name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu"
                                   class="w-full mt-1 rounded-lg px-3 py-2 border focus:ring-2 outline-none"
                                   style="background:rgba(255,255,255,0.4); border-color:#909632;">
                        </div>

                        <!-- ERROR MESSAGE -->
                        <c:if test="${not empty message}">
                            <p class="text-red-500 text-sm">${message}</p>
                        </c:if>

                        <!-- BUTTON -->
                        <div class="flex gap-4 pt-4 justify-center">

                            <button type="submit"
                                    class="text-white px-6 py-2 rounded-xl shadow-lg hover:scale-105 transition"
                                    style="background:#27301B;">
                                Đổi mật khẩu
                            </button>

                            <a href="${pageContext.request.contextPath}/profile">
                                <button type="button"
                                        class="text-white px-6 py-2 rounded-xl shadow-lg hover:scale-105 transition"
                                        style="background:#41521E;">
                                    Quay lại
                                </button>
                            </a>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>