<div class="w-[360px]">

    <!-- LOGIN FORM -->
    <div id="loginForm">

        <h1 class="text-4xl font-bold text-gray-800 mb-2">
            Hi Designer
        </h1>

        <p class="text-gray-500 mb-8">
            Welcome to UISOCIAL
        </p>

        <form>

            <input
                type="email"
                placeholder="Email"
                class="w-full border border-gray-300 rounded-lg p-3 mb-4"
            />

            <div class="relative">

                <input
                    type="password"
                    placeholder="Password"
                    class="w-full border border-gray-300 rounded-lg p-3"
                />

                <a
                    href="#"
                    class="text-sm text-red-400 absolute right-2 top-12"
                >
                    Forgot password ?
                </a>

            </div>

            <!-- OR -->
            <div class="flex items-center my-6">

                <div class="flex-1 border-t"></div>

                <span class="px-4 text-gray-400 text-sm">
                    or
                </span>

                <div class="flex-1 border-t"></div>

            </div>

            <button
                type="button"
                class="w-full border rounded-lg p-3 flex items-center justify-center gap-2 hover:bg-gray-50"
            >
                Login with Google

                <img
                    src="https://cdn-icons-png.flaticon.com/512/2991/2991148.png"
                    class="w-5"
                />

            </button>

            <button
                class="w-full bg-red-500 text-white py-3 rounded-full mt-4 hover:bg-red-600"
            >
                Login
            </button>

        </form>

        <p class="text-center text-gray-500 mt-4 text-sm">

            Don't have an account?

            <a
                onclick="showRegister()"
                class="text-red-500 cursor-pointer"
            >
                Sign up
            </a>

        </p>

    </div>



    <!-- REGISTER FORM -->
    <div id="registerForm" class="hidden">

        <h1 class="text-4xl font-bold text-gray-800 mb-2">
            Create Account
        </h1>

        <p class="text-gray-500 mb-8">
            Join UISOCIAL today
        </p>

        <form>

            <input
                type="text"
                placeholder="Full Name"
                class="w-full border border-gray-300 rounded-lg p-3 mb-4"
            />

            <input
                type="email"
                placeholder="Email"
                class="w-full border border-gray-300 rounded-lg p-3 mb-4"
            />

            <input
                type="password"
                placeholder="Password"
                class="w-full border border-gray-300 rounded-lg p-3 mb-4"
            />

            <input
                type="password"
                placeholder="Confirm Password"
                class="w-full border border-gray-300 rounded-lg p-3 mb-4"
            />

            <button
                class="w-full bg-red-500 text-white py-3 rounded-full hover:bg-red-600"
            >
                Register
            </button>

        </form>

        <p class="text-center text-gray-500 mt-4 text-sm">

            Already have an account?

            <a
                onclick="showLogin()"
                class="text-red-500 cursor-pointer"
            >
                Login
            </a>

        </p>

    </div>



    <!-- SOCIAL -->
    <div class="flex justify-center gap-6 mt-6 text-gray-500 text-lg">

        <a href="#">f</a>
        <a href="#">t</a>
        <a href="#">in</a>
        <a href="#">ig</a>

    </div>

</div>



<script>

function showRegister() {
    document.getElementById("loginForm").style.display = "none"
    document.getElementById("registerForm").style.display = "block"
}

function showLogin() {
    document.getElementById("loginForm").style.display = "block"
    document.getElementById("registerForm").style.display = "none"
}

</script>