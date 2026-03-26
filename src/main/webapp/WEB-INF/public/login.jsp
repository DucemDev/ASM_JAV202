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

/* 🔥 BACKGROUND GRID + LOANG 3 MÀU */
body{
margin:0;
font-family:'Segoe UI', sans-serif;
height:100vh;
display:flex;
justify-content:center;
align-items:center;
position:relative;
overflow:hidden;
background:#f6efe7;
}

/* 🔥 BACKGROUND */
body::before{
content:'';
position:fixed;
inset:0;
z-index:0;

background:

/* 🔥 GRID (để lên đầu để rõ) */
linear-gradient(to right, rgba(180,180,180,0.25) 1px, transparent 1px),
linear-gradient(to bottom, rgba(180,180,180,0.25) 1px, transparent 1px),

/* 🔥 NÂU */
radial-gradient(ellipse 80% 60% at 70% 20%, rgba(139,94,60,0.6), transparent 70%),

/* 🔥 BE */
radial-gradient(ellipse 70% 60% at 20% 80%, rgba(230,211,195,0.8), transparent 70%),

/* 🔥 TRẮNG */
radial-gradient(ellipse 60% 50% at 60% 65%, rgba(255,255,255,0.9), transparent 70%),

/* 🔥 BE PHỤ */
radial-gradient(ellipse 65% 40% at 50% 60%, rgba(245,230,215,0.5), transparent 70%),

/* 🔥 NỀN */
linear-gradient(180deg, #f6efe7 0%, #e6d3c3 100%);

background-size:
48px 48px,
48px 48px,
100% 100%,
100% 100%,
100% 100%,
100% 100%,
100% 100%;
}

/* CARD */

.container{
position:relative;
z-index:1;

width:900px;
height:90%;
background:rgba(255,255,255,0.9);
backdrop-filter: blur(10px);

border-radius:20px;
display:flex;
overflow:hidden;
box-shadow:0 15px 40px rgba(0,0,0,0.15);
}

/* LEFT */

.left{
width:45%;
position:relative;
overflow:hidden;
}

/* IMAGE */
.slide-img{
width:100%;
height:100%;
object-fit:cover;
position:absolute;
top:0;
left:0;
}

/* OVERLAY */
.left::before{
content:'';
position:absolute;
inset:0;
background:linear-gradient(
    to top,
    rgba(0,0,0,0.6),
    rgba(0,0,0,0.2)
);
z-index:1;
}

/* TEXT */
.welcome{
position:absolute;
bottom:40px;
left:25px;
color:white;
z-index:2;
}

.welcome h2{
margin:0;
font-size:24px;
font-weight:600;
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

.right h1{
margin-bottom:10px;
color:#333;
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
transition:0.2s;
}

.input-box input:focus{
outline:none;
background:#eee;
}

/* BUTTON */

.login-btn{
width:100%;
padding:14px;
border:none;
border-radius:20px;
background:#8b5e3c;
color:white;
font-size:16px;
cursor:pointer;
}

.login-btn:hover{
background:#6f4e37;
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

/* GOOGLE */

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

.error{
color:red;
margin-bottom:10px;
}

</style>

</head>

<body>

<div class="container">

<!-- LEFT SLIDE -->
<div class="left">

<img id="slide"
class="slide-img"
src="${pageContext.request.contextPath}/assets/image/slide1.jpg">

<div class="welcome">
<h2>Chào mừng đến PolyCafe ☕</h2>
<p>Thưởng thức cà phê theo cách của bạn</p>
</div>

</div>

<!-- RIGHT -->
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

<p class="error">${message}</p>

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
anhhldts02418@gmail.com - 123 (Admin)<br>
thangtv@poly.com - 123 (User)
</p>
</div>

</div>

</div>

<!-- SLIDE JS -->
<script>
let images = [
"${pageContext.request.contextPath}/assets/image/slide1.jpg",
"${pageContext.request.contextPath}/assets/image/slide2.jpg",
"${pageContext.request.contextPath}/assets/image/slide3.jpg"
];

let index = 0;

setInterval(() => {
index = (index + 1) % images.length;
document.getElementById("slide").src = images[index];
},3000);
</script>

</body>
</html>