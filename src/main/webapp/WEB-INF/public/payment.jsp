<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán QR - PolyCafe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
</head>
<body class="app-bg p-8">

<div class="max-w-md mx-auto bg-white p-6 rounded-xl shadow-lg text-center border border-gray-200">

    <h2 class="text-xl font-bold mb-4">Quét QR để thanh toán</h2>

    <img class="mx-auto mb-4"
         src="https://img.vietqr.io/image/MB-0813716449-compact2.png?amount=${total}&addInfo=${bill.code}&accountName=HUYNH LE DUC ANH"
                  alt="QR Payment"/>

    <p>Số tiền: <b class="js-currency" data-currency="${total}"></b></p>
    <p>Nội dung: <b>${bill.code}</b></p>

    <form action="${pageContext.request.contextPath}/customer/order/confirm-payment"
          method="post"
          data-disable-on-submit="true"
          data-confirm="Xác nhận bạn đã thanh toán đơn ${bill.code}?">
        <input type="hidden" name="billId" value="${bill.id}" />
        <button class="btn btn-success mt-4" type="submit">
            Tôi đã thanh toán
        </button>
    </form>

</div>

<script src="<c:url value='/assets/js/scrip.js'/>"></script>
</body>
</html>