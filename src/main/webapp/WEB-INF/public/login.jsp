<%@ page contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"
		 isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PolyCafe Login</title>

	<style>
		body{
			margin:0;
			font-family:'Segoe UI', sans-serif;
			background: linear-gradient(135deg,#d7b899,#f3e5d4);
			height:100vh;
			display:flex;
			justify-content:center;
			align-items:center;
		}

		.container{
			width:900px;
			height:90%;
			background:white;
			border-radius:20px;
			display:flex;
			overflow:hidden;
			box-shadow:0 15px 40px rgba(0,0,0,0.15);
		}

		.left{
			width:45%;
			position:relative;
			overflow:hidden;
		}

		.slide-img{
			width:100%;
			height:100%;
			object-fit:cover;
			position:absolute;
		}

		.welcome{
			position:absolute;
			bottom:40px;
			left:20px;
			color:white;
			background:rgba(0,0,0,0.4);
			padding:15px;
			border-radius:10px;
		}

		.right{
			width:55%;
			padding:60px;
		}

		.subtitle{
			color:#777;
			margin-bottom:30px;
		}

		.input-box{
			margin-bottom:20px;
		}

		.input-box input{
			width:100%;
			padding:14px;
			border:none;
			border-radius:20px;
			background:#f3f3f3;
		}

		.login-btn{
			width:100%;
			padding:14px;
			border:none;
			border-radius:20px;
			background:#6f4e37;
			color:white;
			font-size:16px;
			cursor:pointer;
		}

		.login-btn:hover{
			background:#563b28;
		}

		.divider{
			display:flex;
			align-items:center;
			margin:25px 0;
		}

		.divider hr{
			flex:1;
			height:1px;
			background:#ddd;
			border:none;
		}

		.divider span{
			margin:0 10px;
			color:#777;
		}

		.footer{
			margin-top:15px;
			font-size:14px;
			text-align:center;
		}
	</style>
</head>

<body>

<div class="container">

	<!-- LEFT -->
	<div class="left">
		<img id="slide" src="<c:url value='/assets/image/slide1.jpg'/>" class="slide-img">
		<div class="welcome">
			<h2>Chào mừng đến PolyCafe</h2>
			<p>Ngon hơn với PolyCafe ☕</p>
		</div>
	</div>

	<!-- RIGHT -->
	<div class="right">
		<h1>Đăng nhập</h1>
		<p class="subtitle">Vui lòng đăng nhập để vào hệ thống</p>

		<!-- LOGIN FORM -->
		<form action="<c:url value='/logining'/>" method="post">
			<div class="input-box">
				<input type="text" name="emailIp" placeholder="Email" required>
			</div>

			<div class="input-box">
				<input type="password" name="passwordIp" placeholder="Password" required>
			</div>

			<c:if test="${not empty message}">
				<p style="color:red; font-size:13px;">${message}</p>
			</c:if>

			<div style="text-align:right; margin-bottom:10px;">
				<a href="<c:url value='/forgotpassword'/>">Quên mật khẩu?</a>
			</div>

			<button class="login-btn" type="submit">Đăng nhập</button>
		</form>

		<!-- DIVIDER -->
		<div class="divider">
			<hr><span>Hoặc</span><hr>
		</div>

		<!-- GOOGLE LOGIN -->
		<jsp:include page="login-google.jsp" />

		<!-- FOOTER -->
		<div class="footer">
			Hệ thống PolyCafe
			<p>
				anhhldts02418@gmail.com | 123 (Admin)<br>
				thangtv@poly.com | 123 (User)
			</p>
		</div>
	</div>
</div>

<script>
	const ctx = "${pageContext.request.contextPath}";

	let images = [
		ctx + "/assets/image/slide1.jpg",
		ctx + "/assets/image/slide2.jpg",
		ctx + "/assets/image/slide3.jpg"
	];

	let index = 0;
	const slideImg = document.getElementById("slide");

	setInterval(() => {
		index++;
		if(index >= images.length) index = 0;

		slideImg.style.opacity = "0.7";
		setTimeout(() => {
			slideImg.src = images[index];
			slideImg.style.opacity = "1";
		}, 200);
	}, 4000);
</script>

</body>
</html>