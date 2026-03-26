<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Change Info</title>
</head>
<body>

<h1>Trang chỉnh sửa thông tin cá nhân</h1>

<form action="${pageContext.request.contextPath}/change-information/save" method="post">

    <p>Fullname</p>
    <input value="${sessionScope.user.fullname}" name="fullname" type="text">

    <p>Email</p>
    <input value="${sessionScope.user.email}" name="email" type="email">

    <p>SDT</p>
    <input value="${sessionScope.user.phone}" name="phone" type="text">


    <br><br>
    <button type="submit">Lưu thông tin thay đổi</button>
<p style="color: red">${sessionScope.message}</p>
</form>

</body>
</html>

