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
<h1>Trang chỉnh sửa thông tin cá nhân</h1>
<p>ID</p>
<input value="${sessionScope.user.id}" name="id" type="text">
<p>Fullname</p>
<input value="${sessionScope.user.fullname}" name="fullname" type="text">
<p>Email</p>
<input value="${sessionScope.user.email}" name="email" type="email">
<p>SDT</p>
<input value="${sessionScope.user.phone}" name="phone" type="text">
<p>Role</p>
<input value="${sessionScope.user.role ? 'Admin' : 'Staff'}" name="role" type="text" readonly>

</body>
</html>
