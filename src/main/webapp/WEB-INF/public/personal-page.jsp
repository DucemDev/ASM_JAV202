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
<h1>Trang cá nhân</h1>
<p>Name: ${sessionScope.user.fullname}</p>
<p>email: ${sessionScope.user.email}</p>
<p>password: ${sessionScope.user.password}</p>
<p>ID: ${sessionScope.user.id}</p>
<p>SDT: ${sessionScope.user.phone}</p>


<a href="${pageContext.request.contextPath}/change-password"><button type="button">Đổi mật khẩu</button></a>
<a href="${pageContext.request.contextPath}/change-information"><button type="button">Đổi thông tin cá nhân</button></a>


</body>
</html>