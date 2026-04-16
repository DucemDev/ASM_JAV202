<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
</head>
<body>

<c:choose>
    <c:when test="${pageContext.errorData.statusCode == 404}">
        <h1>Trang không tồn tại</h1>
    </c:when>

    <c:when test="${pageContext.errorData.statusCode == 403}">
        <h1>Không có quyền truy cập</h1>
    </c:when>

    <c:otherwise>
        <h1>Lỗi hệ thống</h1>
    </c:otherwise>
</c:choose>

</body>
</html>