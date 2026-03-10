<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="sidebar"
class="h-screen bg-gray-900 text-white transition-all duration-300 w-60 flex flex-col">

<!-- BUTTON -->
<div class="flex justify-end p-3">
<button onclick="toggleSidebar()" class="text-xl">
☰
</button>
</div>

<!-- MENU -->
<nav class="flex flex-col p-4 space-y-2">

<a href="home"
class="hover:bg-gray-700 p-2 rounded flex items-center">

<span>🏠</span>
<span class="ml-3 menu-text">Trang chủ</span>

</a>

<a href="categories"
class="hover:bg-gray-700 p-2 rounded flex items-center">

<span>📂</span>
<span class="ml-3 menu-text">Danh mục</span>

</a>

<a href="drink"
class="hover:bg-gray-700 p-2 rounded flex items-center">

<span>🥤</span>
<span class="ml-3 menu-text">Đồ uống</span>

</a>

</nav>

</div>

<script>

let collapsed=false

function toggleSidebar(){

let sidebar=document.getElementById("sidebar")
let text=document.querySelectorAll(".menu-text")

collapsed=!collapsed

if(collapsed){

sidebar.classList.remove("w-60")
sidebar.classList.add("w-20")

text.forEach(t=>t.style.display="none")

}
else{

sidebar.classList.remove("w-20")
sidebar.classList.add("w-60")

text.forEach(t=>t.style.display="inline")

}

}

</script>