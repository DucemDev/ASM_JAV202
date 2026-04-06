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
    <div id="mainContent" class="flex-1 flex flex-col ml-64 transition-all duration-300">

        <!-- HEADER -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <!-- CONTENT -->
        <div class="p-8">

            <div class="max-w-[1400px] mx-auto">

                <!-- CARD -->
                <div class="bg-white rounded-2xl shadow-lg p-8 border border-gray-200">

                    <h1 class="text-2xl font-bold text-gray-800 mb-6">
                        Đổi mật khẩu
                    </h1>

                    <form method="post"
                          action="${pageContext.request.contextPath}/change-password"
                          class="space-y-5">

                        <!-- NEW PASSWORD -->
                        <div>
                            <label class="text-sm text-gray-500">Mật khẩu mới</label>
                            <input type="password" name="newPassword"
                                   placeholder="Nhập mật khẩu mới"
                                   class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2
                      focus:ring-2 focus:ring-cafe-brown outline-none">
                        </div>

                        <!-- CONFIRM PASSWORD -->
                        <div>
                            <label class="text-sm text-gray-500">Xác nhận mật khẩu</label>
                            <input type="password" name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu"
                                   class="w-full mt-1 border border-gray-300 rounded-lg px-3 py-2
                      focus:ring-2 focus:ring-cafe-brown outline-none">
                        </div>

                        <!-- ERROR MESSAGE -->
                        <c:if test="${not empty message}">
                            <p class="text-red-500 text-sm">${message}</p>
                        </c:if>

                        <!-- BUTTON -->
                        <div class="flex gap-4 pt-4">

                            <button type="submit"
                                    class="bg-cafe-brown text-white px-6 py-2 rounded-lg hover:opacity-90 transition">
                                Đổi mật khẩu
                            </button>

                            <a href="${pageContext.request.contextPath}/profile">
                                <button type="button"
                                        class="bg-gray-500 text-white px-6 py-2 rounded-lg hover:opacity-90 transition">
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