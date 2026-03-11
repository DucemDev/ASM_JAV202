<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Trang chủ</title>

    <!-- TailwindCSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <style>

        /* ảnh nghiêng sang trái khoảng 10 độ */

        .slanted {
            clip-path: polygon(8% 0, 100% 0, 100% 100%, 0% 100%);
        }

    </style>

</head>

<body class="h-screen flex">

    <!-- SIDEBAR -->
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp" />



    <!-- MAIN CONTENT -->
    <div class="flex flex-1">

        <!-- LOGIN -->
        <div class="w-[35%] flex items-center justify-center bg-white">

            <!-- LOGIN UI -->
            <jsp:include page="/WEB-INF/views/login.jsp" />

        </div>



        <!-- IMAGE -->
        <div class="w-[65%] slanted relative">

            <img
                id="slide"
                src="https://images.unsplash.com/photo-1501785888041-af3ef285b470"
                class="w-full h-full object-cover"
            />

        </div>

    </div>



    <script>

        let images = [

            "https://images.unsplash.com/photo-1501785888041-af3ef285b470",

            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",

            "https://images.unsplash.com/photo-1493558103817-58b2924bce98"

        ]

        let index = 0

        setInterval(() => {

            index++

            if (index >= images.length) {
                index = 0
            }

            document.getElementById("slide").src = images[index]

        }, 4000)

    </script>

</body>

</html>