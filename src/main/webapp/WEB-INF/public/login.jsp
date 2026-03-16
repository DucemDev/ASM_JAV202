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

/* CARD */

.container{
width:900px;
height:90%;
background:white;
border-radius:20px;
display:flex;
overflow:hidden;
box-shadow:0 15px 40px rgba(0,0,0,0.15);
}

/* LEFT SIDE (SLIDESHOW) */

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
top:0;
left:0;
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

/* RIGHT SIDE */

.right{
width:55%;
padding:60px;
}

.right h1{
margin-bottom:10px;
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
border-radius:20px;
background:#f3f3f3;
font-size:14px;
}

/* BUTTON */

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

/* DIVIDER */

.divider{
display:flex;
align-items:center;
margin:25px 0;
}

.divider hr{
flex:1;
border:none;
height:1px;
background:#ddd;
}

.divider span{
margin:0 10px;
color:#777;
font-size:14px;
}

/* GOOGLE BUTTON */

.google-btn{
width:100%;
padding:12px;
border-radius:20px;
border:1px solid #ddd;
background:white;
font-size:15px;
cursor:pointer;
display:flex;
align-items:center;
justify-content:center;
gap:10px;
transition:0.2s;
}

.google-btn:hover{
background:#f5f5f5;
}

.google-btn img{
width:20px;
}

/* FOOTER */

.footer{
margin-top:15px;
font-size:14px;
text-align:center;
}

</style>

</head>

<body>

<div class="container">

<!-- LEFT SIDE SLIDESHOW -->

<div class="left">

<img src="${pageContext.request.contextPath}/assets/image/slide1.jpg">

<div class="welcome">
<h2>Chào mừng đến PolyCafe</h2>
<p>Ngon hơn với PolyCafe ☕</p>
</div>

</div>


<!-- RIGHT SIDE LOGIN -->

<div class="right">

<h1>Đăng nhập</h1>
<p class="subtitle">Vui lòng đăng nhập để vào hệ thống</p>

<form action="${pageContext.request.contextPath}/logining" method="post">

<div class="input-box">
<input type="text" name="emailIp" placeholder="Email">
</div>

<div class="input-box">
<input type="password" name="passwordIp" placeholder="Password">
</div>

	<p>${message}</p>

<button class="login-btn" type="submit">
Đăng nhập
</button>

</form>

<div class="divider">
<hr>
<span>Hoặc</span>
<hr>
</div>

<form action="${pageContext.request.contextPath}/login-google" method="get">

<button class="google-btn" type="submit">

<img src="https://developers.google.com/identity/images/g-logo.png">

Đăng nhập với Google

</button>

</form>

<div class="footer">
Hệ thống PolyCafe


<p>
anhhldts02418@gmail.com
	123	(Admin)
<hr>
thangtv@poly.com
	123	(User)
 </p>
</div>

</div>

</div>

<script>

let images = [

"${pageContext.request.contextPath}/images/slide1.jpg",
"${pageContext.request.contextPath}/images/slide2.jpg",
"${pageContext.request.contextPath}/images/slide3.jpg"

]

let index = 0

setInterval(() => {

index++

if(index >= images.length){
index = 0
}

document.getElementById("slide").src = images[index]

},4000)

</script>

</body>
</html>