
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
			height:100vh;
			display:flex;
			justify-content:center;
			align-items:center;
			background: linear-gradient(135deg,#e6d3c3,#f6efe7);
		}

		/* CARD */
		.container{
			width:900px;
			height:90%;
			background:rgba(255,255,255,0.95);
			backdrop-filter: blur(10px);
			border-radius:20px;
			display:flex;
			overflow:hidden;
			box-shadow:0 20px 50px rgba(0,0,0,0.15);
		}

		/* LEFT */
		.left{
			width:45%;
			position:relative;
		}

		.slide-img{
			width:100%;
			height:100%;
			object-fit:cover;
			position:absolute;
		}

		/* overlay đẹp hơn */
		.left::before{
			content:'';
			position:absolute;
			inset:0;
			background:linear-gradient(to top, rgba(0,0,0,0.6), transparent);
			z-index:1;
		}

		.welcome{
			position:absolute;
			bottom:30px;
			left:25px;
			color:white;
			z-index:2;
		}

		.welcome h2{
			margin:0;
			font-size:24px;
		}

		.welcome p{
			margin-top:5px;
			font-size:14px;
			opacity:0.9;
		}

		/* RIGHT */
		.right{
			width:55%;
			padding:60px;
		}

		.subtitle{
			color:#777;
			margin-bottom:30px;
		}

		/* INPUT */
		.input-box{
			margin-bottom:20px;
		}

		.input-box input{
			width:100%;
			padding:14px;
			border:none;
			border-radius:12px;
			background:#f5f5f5;
			font-size:14px;
			transition:0.2s;
		}

		.input-box input:focus{
			outline:none;
			background:#eee;
			box-shadow:0 0 0 2px #d7b899;
		}

		/* LOGIN BUTTON */
		.login-btn{
			width:100%;
			padding:14px;
			border:none;
			border-radius:12px;
			background:linear-gradient(135deg,#8b5e3c,#6f4e37);
			color:white;
			font-size:16px;
			cursor:pointer;
			transition:0.3s;
			box-shadow:0 5px 15px rgba(0,0,0,0.15);
		}

		.login-btn:hover{
			transform:translateY(-2px);
			box-shadow:0 8px 20px rgba(0,0,0,0.2);
		}

		/* DIVIDER */
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
			font-size:13px;
		}

		/* GOOGLE BUTTON */
		.google-btn{
			width:100%;
			padding:12px;
			border-radius:12px;
			border:1px solid #ddd;
			background:white;
			font-size:15px;
			cursor:pointer;
			display:flex;
			align-items:center;
			justify-content:center;
			gap:10px;
			transition:0.2s;
			box-shadow:0 3px 10px rgba(0,0,0,0.05);
		}

		.google-btn:hover{
			background:#f9f9f9;
			transform:translateY(-1px);
		}

		.google-btn img{
			width:20px;
			height:20px;
		}

		/* LINK */
		a{
			color:#6f4e37;
			text-decoration:none;
			font-size:13px;
		}

		a:hover{
			text-decoration:underline;
		}

		/* ERROR */
		.error{
			color:red;
			font-size:13px;
			margin-bottom:10px;
		}

		/* FOOTER */
		.footer{
			margin-top:15px;
			font-size:13px;
			text-align:center;
			color:#555;
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
				truongmk@gmail.com | 123 (Admin)<br>
				ngoctm@gmail.com | 123 (nhân viên)<br>
				thangtv@poly.com | 123 (khách hàng)

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