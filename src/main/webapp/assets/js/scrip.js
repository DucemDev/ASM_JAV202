(function () {
    "use strict";

    const $$ = (s) => [...document.querySelectorAll(s)];

    /* =========================
       SIDEBAR (MƯỢT + KHÔNG GIẬT)
    ========================= */
    function toggleSidebar() {
        document.body.classList.toggle("sidebar-collapsed");

        localStorage.setItem(
            "sidebar",
            document.body.classList.contains("sidebar-collapsed") ? "1" : "0"
        );
    }

    function initSidebar() {
        if (localStorage.getItem("sidebar") === "1") {
            document.body.classList.add("sidebar-collapsed");
        }

        $$("[data-action='toggle-sidebar']").forEach(btn => {
            btn.addEventListener("click", toggleSidebar);
        });
    }

    /* =========================
       AJAX FORM (KHÔNG RELOAD)
    ========================= */
    function initAjaxForm() {
        $$("[data-ajax]").forEach(form => {
            form.addEventListener("submit", function (e) {
                e.preventDefault();

                const formData = new FormData(form);

                fetch(form.action, {
                    method: form.method || "POST",
                    body: formData
                })
                .then(res => res.text())
                .then(() => {
                    console.log("Submit thành công (AJAX)");
                    location.reload(); // hoặc update UI sau
                })
                .catch(err => console.error(err));
            });
        });
    }

    /* =========================
       INIT
    ========================= */
    document.addEventListener("DOMContentLoaded", () => {
        initSidebar();
        initAjaxForm();
    });

})();