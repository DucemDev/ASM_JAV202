<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Quản lý đồ uống</title>

    <style>
        body { font-family: Arial; background: #f5f6fa; padding: 20px; }
        .btn { padding: 6px 12px; border-radius: 6px; border: none; cursor: pointer; }
        .btn-add { background: #44bd32; color: white; }
        .btn-edit { background: #0984e3; color: white; }
        .btn-delete { background: #d63031; color: white; }

        table { width: 100%; background: white; margin-top: 20px; }
        th, td { padding: 10px; text-align: center; }

        img { width: 60px; height: 60px; border-radius: 8px; }

        .modal {
            display: none;
            position: fixed;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
        }

        .modal-content {
            background: white;
            width: 400px;
            margin: 100px auto;
            padding: 20px;
            border-radius: 10px;
        }

        input { width: 100%; padding: 8px; margin: 5px 0; }
    </style>
</head>

<body>

<h2>🍹 Quản lý đồ uống</h2>

<button class="btn btn-add" onclick="openModal()">+ Thêm</button>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Ảnh</th>
        <th>Tên</th>
        <th>Giá</th>
        <th>Action</th>
    </tr>

    <c:forEach items="${drinks}" var="d">
        <tr>
            <td>${d.id}</td>
            <td><img src="${d.image}"></td>
            <td>${d.name}</td>
            <td>${d.price}</td>

            <td>
                <button class="btn btn-edit"
                        onclick="editDrink('${d.id}','${d.name}','${d.price}','${d.image}')">
                    Sửa
                </button>

                <form action="${pageContext.request.contextPath}/manager/drinks/delete" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${d.id}">
                    <button class="btn btn-delete">Xóa</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<div class="modal" id="modal">
    <div class="modal-content">

        <h3 id="title">Form</h3>

        <form id="form" method="post">

            <input type="hidden" name="id" id="id">

            <input name="name" id="name" placeholder="Tên">
            <input name="price" id="price" placeholder="Giá">
            <input name="image" id="image" placeholder="Link ảnh">

            <button class="btn btn-add">Lưu</button>
            <button type="button" onclick="closeModal()">Hủy</button>

        </form>
    </div>
</div>

<script>
    function openModal() {
        document.getElementById("modal").style.display = "block";
        document.getElementById("form").action = "${pageContext.request.contextPath}/manager/drinks/add";
    }

    function editDrink(id, name, price, image) {
        document.getElementById("modal").style.display = "block";

        document.getElementById("form").action = "${pageContext.request.contextPath}/manager/drinks/edit";

        document.getElementById("id").value = id;
        document.getElementById("name").value = name;
        document.getElementById("price").value = price;
        document.getElementById("image").value = image;
    }

    function closeModal() {
        document.getElementById("modal").style.display = "none";
    }
</script>

</body>
</html>