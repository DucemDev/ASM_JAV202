<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đăng ký | PolyCafe</title>

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

                <!-- Khối đăng ký (trái) -->
                <div class="p-6 md:p-8 bg-white/78 backdrop-blur-lg">
                    <h1 class="text-2xl md:text-3xl font-extrabold text-white tracking-tight">
                        Đăng ký tài khoản
                    </h1>
                    <p class="mt-1 text-sm font-medium text-white/85">
                        Tạo tài khoản mới để sử dụng PolyCafe.
                    </p>

                    <form action="<c:url value='/register'/>" method="post" class="mt-5 space-y-3">
                        <div>
                            <label for="fullname" class="block text-sm font-semibold text-white mb-1">Họ và tên</label>
                            <input id="fullname"
                                   type="text"
                                   name="fullname"
                                   placeholder="Nhập họ và tên"
                                   required
                                   class="w-full rounded-xl bg-white/95 px-4 py-2.5 text-sm text-black font-normal placeholder:text-black/45 focus:outline-none focus:ring-2 focus:ring-cafe-moss shadow-sm border-0">
                        </div>

                        <div>
                            <label for="email" class="block text-sm font-semibold text-white mb-1">Email</label>
                            <input id="email"
                                   type="email"
                                   name="email"
                                   placeholder="Ví dụ: abc@gmail.com"
                                   pattern="[a-z0-9._%+-]+@gmail\.com$"
                                   title="Vui lòng sử dụng địa chỉ @gmail.com"
                                   required
                                   class="w-full rounded-xl bg-white/95 px-4 py-2.5 text-sm text-black font-normal placeholder:text-black/45 focus:outline-none focus:ring-2 focus:ring-cafe-moss shadow-sm border-0">
                        </div>

                        <div>
                            <label for="phone" class="block text-sm font-semibold text-white mb-1">Số điện thoại</label>
                            <input id="phone"
                                   type="tel"
                                   name="phone"
                                   placeholder="10 số, bắt đầu bằng 0"
                                   pattern="^0\\d{9}$"
                                   title="Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0"
                                   required
                                   class="w-full rounded-xl bg-white/95 px-4 py-2.5 text-sm text-black font-normal placeholder:text-black/45 focus:outline-none focus:ring-2 focus:ring-cafe-moss shadow-sm border-0">
                        </div>

                        <div>
                            <label for="password" class="block text-sm font-semibold text-white mb-1">Mật khẩu</label>
                            <input id="password"
                                   type="password"
                                   name="password"
                                   placeholder="Nhập mật khẩu"
                                   minlength="3"
                                   required
                                   class="w-full rounded-xl bg-white/95 px-4 py-2.5 text-sm text-black font-normal placeholder:text-black/45 focus:outline-none focus:ring-2 focus:ring-cafe-moss shadow-sm border-0">
                        </div>

                        <div>
                            <label for="confirmPassword" class="block text-sm font-semibold text-white mb-1">Xác nhận mật khẩu</label>
                            <input id="confirmPassword"
                                   type="password"
                                   name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu"
                                   required
                                   class="w-full rounded-xl bg-white/95 px-4 py-2.5 text-sm text-black font-normal placeholder:text-black/45 focus:outline-none focus:ring-2 focus:ring-cafe-moss shadow-sm border-0">
                        </div>

                        <c:if test="${not empty message}">
                            <div class="rounded-xl bg-red-50/95 px-3 py-2 text-sm font-semibold text-red-700 border-0">
                                ${message}
                            </div>
                        </c:if>

                        <button type="submit"
                                class="w-full rounded-xl bg-cafe-noir text-cafe-bone py-2.5 font-bold hover:bg-cafe-bone hover:text-cafe-noir transition shadow-lg shadow-cafe-noir/25">
                            Đăng ký
                        </button>
                    </form>

                    <div class="mt-4 text-sm text-white/85">
                        <a href="<c:url value='/login'/>" class="font-bold text-white hover:text-cafe-bone transition">
                            Đã có tài khoản? Đăng nhập ngay
                        </a>
                    </div>

                </div>

                <!-- Khối phải: slideshow -->
                <div class="relative min-h-[560px]">
                    <img id="welcomeSlide"
                         src="<c:url value='/assets/image/slide1.jpg'/>"
                         alt="Slideshow chào mừng"
                         class="absolute inset-0 w-full h-full object-cover transition-opacity duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-cafe-noir/92 via-cafe-kombu/45 to-cafe-noir/35"></div>

                    <div class="relative z-10 h-full p-6 md:p-8 text-cafe-bone flex flex-col justify-end">
                        <div>
                            <p class="text-xs uppercase tracking-[0.2em] text-cafe-tan font-semibold drop-shadow">PolyCafe</p>
                            <h2 class="mt-3 text-3xl font-extrabold leading-tight text-white drop-shadow-[0_3px_10px_rgba(0,0,0,0.55)]">
                                Gia nhập PolyCafe
                            </h2>
                            <p class="mt-3 text-sm md:text-base text-white/95 font-semibold drop-shadow-[0_2px_8px_rgba(0,0,0,0.45)]">
                                Trải nghiệm cà phê tuyệt vời và mua sắm nhanh hơn mỗi ngày.
                            </p>
                        </div>
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