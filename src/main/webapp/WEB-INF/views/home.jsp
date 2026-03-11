<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="user" value="${sessionScope.user}" />

<h2>Xin chào ${user.fullname}</h2>

<div style="display:grid;grid-template-columns:repeat(3,200px);gap:20px">

<c:choose>

<c:when test="${user.role}">

<button>Quản lý loại</button>
<button>Quản lý đồ uống</button>
<button>Quản lý bàn</button>
<button>Quản lý nhân viên</button>
<button>Quản lý hóa đơn</button>
<button>Thống kê</button>

</c:when>

<c:otherwise>

<button>Bán hàng</button>
<button>Quản lý bàn</button>
<button>Hóa đơn</button>
<button>Lịch sử hóa đơn</button>

</c:otherwise>

</c:choose>

</div>