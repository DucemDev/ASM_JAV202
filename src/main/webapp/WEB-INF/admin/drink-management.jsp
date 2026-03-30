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
            display: none;   /* chỉ để 1 cái này */
            position: fixed;
            top: 0;
            left: 0;

            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);

            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            width: 400px;
            margin: 100px auto;
            padding: 20px;
            border-radius: 10px;
        }
        .error {
            border: 1px solid red;
        }
        input { width: 100%; padding: 8px; margin: 5px 0; }
    </style>
</head>

<body>

<h2>🍹 Quản lý đồ uống</h2>

<button type="button" class="btn btn-add" onclick="openModal()">+ Thêm</button>
<c:if test="${not empty error}">
    <div style="color:red; margin:10px 0;">
            ${error}
    </div>
</c:if>
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
            <td><img src="${pageContext.request.contextPath}/${d.image}"></td>
            <td>${d.name}</td>
            <td>${d.price}</td>

            <td>
                <button class="btn btn-edit"
                        data-id="${d.id}"
                        data-name="${d.name}"
                        data-price="${d.price}"
                        onclick="editDrink(this)">
                    Sửa
                </button>

                <form action="${pageContext.request.contextPath}/manager/drinks/delete" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${d.id}">
                    <button type="submit" class="btn btn-delete">Xóa</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<div class="modal" id="modal">
    <div class="modal-content">

        <h3 id="title">Form</h3>

        <form id="form" method="post" enctype="multipart/form-data">

            <input type="hidden" name="id" id="id">

            <input name="name" id="name" placeholder="Tên" value="${oldName}" class="${not empty errorName ? 'error' : ''}">
            <c:if test="${not empty errorName}">
                <div style="color:red; font-size:13px;">
                        ${errorName}
                </div>
            </c:if>
            <select name="categoryId">
                <c:forEach items="${categories}" var="c">
                    <option value="${c.id}"
                        ${c.id == oldCategory ? 'selected' : ''}>
                            ${c.name}
                    </option>
                </c:forEach>
            </select>
            <input name="price" id="price" placeholder="Giá" value="${oldPrice}" class="${not empty errorPrice ? 'error' : ''}">
            <c:if test="${not empty errorPrice}">
                <div style="color:red; font-size:13px;">
                        ${errorPrice}
                </div>
            </c:if>
            <input type="file" name="image" id="image">

            <button type="submit" class="btn btn-add">Lưu</button>
            <button type="button" onclick="closeModal()">Hủy</button>

        </form>
    </div>
</div>

<script>
    function openModal() {
        console.log("CLICK ADD");
        document.getElementById("modal").style.display = "flex";

        document.getElementById("form").action =
            "${pageContext.request.contextPath}/manager/drinks/add";

        // reset form
        document.getElementById("id").value = "";
        document.getElementById("name").value = "";
        document.getElementById("price").value = "";
    }

    function editDrink(btn) {
        document.getElementById("modal").style.display = "flex";

        document.getElementById("form").action =
            "${pageContext.request.contextPath}/manager/drinks/edit";

        document.getElementById("id").value = btn.dataset.id;
        document.getElementById("name").value = btn.dataset.name;
        document.getElementById("price").value = btn.dataset.price;
    }

    function closeModal() {
        document.getElementById("modal").style.display = "none";
    }
</script>
<script>
    window.onload = function () {
        const open = "${openModal}";
        if (open === "true") {
            document.getElementById("modal").style.display = "flex";

            document.getElementById("form").action =
                "${pageContext.request.contextPath}/manager/drinks/add";
        }
    }
</script>
</body>
</html>