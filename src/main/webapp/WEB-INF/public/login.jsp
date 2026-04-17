<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đăng nhập | PolyCafe</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        cafe: {
                            noir: '#4C3D19',
                            kombu: '#354024',
                            moss: '#889063',
                            tan: '#CFB899',
                            bone: '#E5D7C4'
                        }
                    }
                }
            }
        }
    </script>
</head>

<body class="h-screen overflow-hidden bg-cafe-bone/70">
<div class="relative h-full w-full">
    <!-- Nền ngoài: ảnh tĩnh -->
    <img src="<c:url value='/assets/image/background.jpg'/>"
         alt="Nền cà phê"
         class="absolute inset-0 w-full h-full object-cover">
    <div class="absolute inset-0 bg-gradient-to-br from-cafe-kombu/70 via-cafe-noir/55 to-cafe-moss/45"></div>

    <div class="relative z-10 h-full flex items-center justify-center px-4 py-4">
        <div class="w-full max-w-5xl rounded-3xl border border-cafe-bone/40 bg-white/88 backdrop-blur-md shadow-2xl overflow-hidden">
            <div class="grid grid-cols-1 lg:grid-cols-2">

                <!-- Khối trái: slideshow 50% -->
                <div class="relative min-h-[560px]">
                    <img id="welcomeSlide"
                         src="<c:url value='/assets/image/slide1.jpg'/>"
                         alt="Slideshow chào mừng"
                         class="absolute inset-0 w-full h-full object-cover transition-opacity duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-cafe-noir/92 via-cafe-kombu/45 to-cafe-noir/35"></div>

                    <!-- Dời chữ xuống dưới -->
                    <div class="relative z-10 h-full p-6 md:p-8 text-cafe-bone flex flex-col justify-end">
                        <div>
                            <p class="text-xs uppercase tracking-[0.2em] text-cafe-tan font-semibold drop-shadow">PolyCafe</p>
                            <h2 class="mt-3 text-3xl font-extrabold leading-tight text-white drop-shadow-[0_3px_10px_rgba(0,0,0,0.55)]">
                                Chào mừng bạn trở lại
                            </h2>
                            <p class="mt-3 text-sm md:text-base text-white/95 font-semibold drop-shadow-[0_2px_8px_rgba(0,0,0,0.45)]">
                                Đăng nhập để tiếp tục quản lý quán, đơn hàng và khách hàng nhanh chóng.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Khối đăng nhập 50% -->
                <div class="p-6 md:p-8 bg-white/78 backdrop-blur-lg">
                    <h1 class="text-2xl md:text-3xl font-extrabold text-white tracking-tight">
                        Đăng nhập hệ thống
                    </h1>
                    <p class="mt-1 text-sm font-medium text-white/85">
                        Nhập thông tin để truy cập PolyCafe.
                    </p>

                    <form action="<c:url value='/logining'/>" method="post" class="mt-5 space-y-3">
                        <div>
                            <label for="emailIp" class="block text-sm font-semibold text-white mb-1">Email</label>
                            <input id="emailIp"
                                   type="text"
                                   name="emailIp"
                                   placeholder="Ví dụ: tenban@gmail.com"
                                   required
                                   class="w-full rounded-xl bg-white/95 px-4 py-2.5 text-sm text-black font-normal placeholder:text-black/45 focus:outline-none focus:ring-2 focus:ring-cafe-moss shadow-sm border-0">
                        </div>

                        <div>
                            <label for="passwordIp" class="block text-sm font-semibold text-white mb-1">Mật khẩu</label>
                            <input id="passwordIp"
                                   type="password"
                                   name="passwordIp"
                                   placeholder="Nhập mật khẩu"
                                   required
                                   class="w-full rounded-xl bg-white/95 px-4 py-2.5 text-sm text-black font-normal placeholder:text-black/45 focus:outline-none focus:ring-2 focus:ring-cafe-moss shadow-sm border-0">
                        </div>

                        <c:if test="${not empty message}">
                            <div class="rounded-xl bg-red-50/95 px-3 py-2 text-sm font-semibold text-red-700 border-0">
                                ${message}
                            </div>
                        </c:if>

                        <div class="flex items-center justify-between text-sm pt-1">
                            <p class="text-white/85 font-medium">
                                Chưa có tài khoản?
                                <a href="<c:url value='/register'/>" class="font-bold text-white hover:text-cafe-bone transition">Đăng ký</a>
                            </p>
                            <a href="<c:url value='/forgotpassword'/>" class="font-semibold text-white hover:text-cafe-bone transition">
                                Quên mật khẩu?
                            </a>
                        </div>

                        <button type="submit"
                                class="w-full rounded-xl bg-cafe-noir text-cafe-bone py-2.5 font-bold hover:bg-cafe-bone hover:text-cafe-noir transition shadow-lg shadow-cafe-noir/25">
                            Đăng nhập
                        </button>
                    </form>

                    <div class="my-4 flex items-center gap-3">
                        <div class="h-px flex-1 bg-white/20"></div>
                        <span class="text-[11px] font-semibold uppercase tracking-wider text-white/70">Hoặc</span>
                        <div class="h-px flex-1 bg-white/20"></div>
                    </div>

                    <jsp:include page="login-google.jsp"/>

                    <div class="mt-4 rounded-xl bg-white/70 p-3 text-xs text-black/90">
                        <p class="font-semibold text-black mb-1">Tài khoản demo</p>
                        <p>truongmk@gmail.com | 123 (Quản trị)</p>
                        <p>ngoctm@gmail.com | 123 (Nhân viên)</p>
                        <p>thangtv@gmail.com | 123 (Khách hàng)</p>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    const ctx = "${pageContext.request.contextPath}";
    const welcomeImages = [
        ctx + "/assets/image/slide1.jpg",
        ctx + "/assets/image/slide2.jpg",
        ctx + "/assets/image/slide3.jpg"
    ];

    let welcomeIndex = 0;
    const welcomeSlide = document.getElementById("welcomeSlide");

    setInterval(() => {
        welcomeIndex = (welcomeIndex + 1) % welcomeImages.length;
        welcomeSlide.style.opacity = "0.72";
        setTimeout(() => {
            welcomeSlide.src = welcomeImages[welcomeIndex];
            welcomeSlide.style.opacity = "1";
        }, 220);
    }, 4500);
</script>
</body>
</html>