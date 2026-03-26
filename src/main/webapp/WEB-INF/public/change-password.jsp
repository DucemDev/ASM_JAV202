<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
<h1>Đổi mật khẩu</h1>

<form method="post" action="${pageContext.request.contextPath}/change-password">
    <input type="password" name="newPassword" placeholder="Mật khẩu mới" />
    <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" />
    <button type="submit">Đổi mật khẩu</button>
</form>

</body>
</html>
