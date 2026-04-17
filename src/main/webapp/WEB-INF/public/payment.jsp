<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán QR</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen relative"
      style="background:linear-gradient(135deg,#e6e8dc,#cfd5a5);">

<!-- TEXTURE -->
<div class="absolute inset-0 z-0 opacity-30 pointer-events-none"
     style="background-image:url('https://grainy-gradients.vercel.app/noise.svg');">
</div>

<div class="relative z-10 flex items-center justify-center min-h-screen p-6">

<div class="w-full max-w-md rounded-2xl shadow-2xl p-6 text-center backdrop-blur-xl border"
     style="background:rgba(255,255,255,0.35); border:1px solid rgba(255,255,255,0.35);">

    <!-- TITLE -->
    <h2 class="text-xl font-bold mb-4 text-[#27301B]">
        Quét QR để thanh toán
    </h2>

    <!-- QR -->
    <div class="bg-white p-4 rounded-xl shadow mb-4">
        <img class="mx-auto"
             src="https://img.vietqr.io/image/MB-0813716449-compact2.png?amount=${total}&addInfo=${bill.code}&accountName=HUYNH LE DUC ANH"
             alt="QR Payment"/>
    </div>

    <!-- INFO -->
    <div class="text-sm text-[#27301B] space-y-1 mb-4">
        <p>Số tiền: <b>${total} đ</b></p>
        <p>Nội dung: <b>${bill.code}</b></p>
    </div>

    <!-- NOTE -->
    <p class="text-xs text-gray-500 mb-4">
        Vui lòng chuyển khoản đúng nội dung để hệ thống xác nhận nhanh hơn
    </p>

    <!-- BUTTON -->
    <form action="${pageContext.request.contextPath}/customer/order/confirm-payment" method="post">
        <input type="hidden" name="billId" value="${bill.id}" />

        <button class="w-full text-white py-2 rounded-xl shadow hover:scale-105 transition"
                style="background:#27301B;">
            Tôi đã thanh toán
        </button>
    </form>

</div>

</div>

</body>
</html>
