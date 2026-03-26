<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Quản lý loại đồ uống</title>

    <style>
        body {
            font-family: 'Segoe UI';
            background: #f4f6f9;
            padding: 30px;
        }

        h2 {
            color: #333;
        }

        /* THÔNG BÁO */
        .msg {
            padding: 10px;
            background: #d4edda;
            color: #155724;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .err {
            padding: 10px;
            background: #f8d7da;
            color: #721c24;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        /* FORM */
        .form-box {
            background: white;
            padding: 20px;
            width: 400px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .radio-group {
            margin: 10px 0;
        }

        button {
            padding: 10px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-save {
            background: #4CAF50;
            color: white;
        }

        .btn-save:hover {
            background: #45a049;
        }

        /* TABLE */
        table {
            margin-top: 30px;
            width: 90%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        th {
            background: #2c3e50;
            color: white;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        tr:hover {
            background: #f1f1f1;
        }

        /* STATUS */
        .active {
            color: green;
            font-weight: bold;
        }

        .inactive {
            color: red;
            font-weight: bold;
        }

        /* BUTTON */
        .btn-delete {
            background: red;
            color: white;
        }

        .btn-delete:hover {
            background: darkred;
        }

        .btn-edit {
            background: orange;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
        }

        /* DISABLE */
        .disabled {
            opacity: 0.5;
            pointer-events: none;
        }
    </style>
</head>

<body>

<h2>Quản lý loại đồ uống</h2>

<!-- MESSAGE -->
<c:if test="${not empty sessionScope.message}">
    <div class="msg">${sessionScope.message}</div>
    <c:remove var="message" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.error}">
    <div class="err">${sessionScope.error}</div>
    <c:remove var="error" scope="session"/>
</c:if>

<!-- FORM -->
<div class="form-box">
    <form method="post"
          action="${pageContext.request.contextPath}/manager/categories/${category != null ? 'edit' : 'add'}">

        <input type="hidden" name="id" value="${category.id}" />

        <label>Tên loại:</label>
        <input type="text" name="name" value="${category.name}" required />

        <div class="radio-group">
            <label>Trạng thái:</label><br>

            <input type="radio" name="active" value="true"
            ${category == null || category.active ? 'checked' : ''}> Hoạt động

            <input type="radio" name="active" value="false"
            ${category != null && !category.active ? 'checked' : ''}> Ngừng
        </div>

        <button class="btn-save">
            ${category != null ? 'Cập nhật' : 'Thêm mới'}
        </button>

    </form>
</div>

<!-- TABLE -->
<table>
    <tr>
        <th>ID</th>
        <th>Tên loại</th>
        <th>Trạng thái</th>
        <th>Hành động</th>
    </tr>

    <c:forEach var="c" items="${list}">
        <tr>
            <td>${c.id}</td>
            <td>${c.name}</td>

            <td>
<span class="${c.active ? 'active' : 'inactive'}">
        ${c.active ? 'Hoạt động' : 'Ngừng'}
</span>
            </td>

            <td>
                <a class="btn-edit"
                   href="${pageContext.request.contextPath}/manager/categories?id=${c.id}">
                    Sửa
                </a>

                <form method="post"
                      action="${pageContext.request.contextPath}/manager/categories/delete"
                      style="display:inline;">

                    <input type="hidden" name="id" value="${c.id}">
                    <button class="btn-delete"
                            onclick="return confirm('Bạn có chắc muốn xóa?')">
                        Xóa
                    </button>

                </form>
            </td>
        </tr>
    </c:forEach>

</table>

</body>
</html>