<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    document.addEventListener("DOMContentLoaded", function() {
        const btn = document.getElementById("btnGoogleLogin");
        if(btn) {
            btn.addEventListener("click", function() {
                // Hiển thị popup đăng nhập Google
                signInWithPopup(auth, provider).then((result) => {
                    const user = result.user;
                    console.log("Đăng nhập thành công, email:", user.email);

                    // 3. TẠO FORM ẨN ĐỂ SUBMIT VỀ SERVLET
                    const form = document.createElement('form');
                    form.method = 'POST';

                    /* SỬA LỖI TẠI ĐÂY: Dùng đường dẫn tương đối 'logining'.
                       Nó sẽ tự động nối vào Context Path (ví dụ: /JAV202_Nhom01_ASM/logining)
                       mà không cần tính toán chuỗi 'cp' phức tạp dễ gây lỗi.
                    */
                    form.action = 'logining';

                    // Input chứa Email
                    const emailInput = document.createElement('input');
                    emailInput.type = 'hidden';
                    emailInput.name = 'emailIp';
                    emailInput.value = user.email;

                    // Input đánh dấu đây là đăng nhập bằng Google
                    const googleFlag = document.createElement('input');
                    googleFlag.type = 'hidden';
                    googleFlag.name = 'googleLogin';
                    googleFlag.value = 'true';

                    form.appendChild(emailInput);
                    form.appendChild(googleFlag);
                    document.body.appendChild(form);

                    // 4. GỬI DỮ LIỆU ĐI
                    form.submit();

                }).catch((error) => {
                    console.error("Firebase Error:", error.code);
                    alert("Lỗi đăng nhập Google: " + error.message);
                });
            });
        }
    });
</script>

<button class="google-btn" type="button" id="btnGoogleLogin">
    <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google" style="width: 20px; margin-right: 10px;">
    Đăng nhập với Google
</button>