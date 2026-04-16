<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script type="module">
    import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
    import { getAuth, signInWithPopup, GoogleAuthProvider } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";

    const firebaseConfig = {
        apiKey: "AIzaSyCYUyUpQgYGduAbsqG_sUEqamM_0e_yG3k",
        authDomain: "asmjav202.firebaseapp.com",
        projectId: "asmjav202",
        storageBucket: "asmjav202.firebasestorage.app",
        messagingSenderId: "174597779752",
        appId: "1:174597779752:web:77664b87a736b8b3b9201d",
        measurementId: "G-JF5CK5QYXB"
    };

   const app = initializeApp(firebaseConfig);
       const auth = getAuth(app);
       const provider = new GoogleAuthProvider();

       document.addEventListener("DOMContentLoaded", function () {
           const btn = document.getElementById("btnGoogleLogin");
           if (!btn) return;

           btn.addEventListener("click", function () {
               signInWithPopup(auth, provider)
                   .then((result) => {
                       const user = result.user;

                       const form = document.createElement("form");
                       form.method = "POST";
                       form.action = "<c:url value='/login-google'/>";

                       const emailInput = document.createElement("input");
                       emailInput.type = "hidden";
                       emailInput.name = "emailIp";
                       emailInput.value = user.email;

                       form.appendChild(emailInput);
                       document.body.appendChild(form);
                       form.submit();
                   })
                   .catch((error) => {
                       console.error("Lỗi Firebase:", error.code, error.message);
                       alert("Đăng nhập Google thất bại. Vui lòng thử lại.");
                   });
           });
       });
   </script>

   <button class="google-btn" type="button" id="btnGoogleLogin">
       <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google">
       Đăng nhập với Google
   </button>