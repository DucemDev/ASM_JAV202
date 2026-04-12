<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán QR</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">

<div class="max-w-md mx-auto bg-white p-6 rounded-xl shadow-lg text-center">

    <h2 class="text-xl font-bold mb-4">Quét QR để thanh toán</h2>

    <img class="mx-auto mb-4"
         src="https://img.vietqr.io/image/MB-0813716449-compact2.png?amount=${total}&addInfo=${bill.code}&accountName=HUYNH LE DUC ANH"
         alt="QR Payment"/>

    <p>Số tiền: <b>${total} đ</b></p>
    <p>Nội dung: <b>${bill.code}</b></p>

    <form action="${pageContext.request.contextPath}/customer/order/confirm-payment" method="post">
        <input type="hidden" name="billId" value="${bill.id}" />
        <button class="bg-green-500 text-white px-4 py-2 rounded mt-4">
            Tôi đã thanh toán
        </button>
    </form>

</div>

</body>
</html>