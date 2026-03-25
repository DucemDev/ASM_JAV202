<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<h2>Quên mật khẩu</h2>

<h2>Xác nhận OTP</h2>

<form action="${pageContext.request.contextPath}/verifyotp" method="post">

<input type="text" name="otp" placeholder="Nhập mã OTP">

<button type="submit">Xác nhận</button>

</form>

<p style="color:red">${message}</p>
</form>
</body>
</html>