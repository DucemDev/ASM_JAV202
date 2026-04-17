<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="py-4 px-8 flex items-center justify-between shadow-md backdrop-blur-xl border-b"
     style="
        background:linear-gradient(135deg, rgba(221,218,168,0.85), rgba(255,255,255,0.7));
        border-color:#99A558;
     ">

    <!-- TITLE -->
    <div class="text-xl font-bold tracking-wide flex items-center gap-3"
         style="color:#27301B;">

        <!-- DOT -->
        <div class="w-3 h-3 rounded-full animate-pulse"
             style="background:#909632;"></div>

        <c:choose>
            <c:when test="${sessionScope.user != null && sessionScope.user.role == 2}">
                ADMIN DASHBOARD
            </c:when>

            <c:when test="${sessionScope.user != null && sessionScope.user.role == 1}">
                STAFF DASHBOARD
            </c:when>

            <c:otherwise>
                ĐẶT HÀNG
            </c:otherwise>
        </c:choose>

    </div>

    <!-- USER INFO -->
    <div class="flex items-center gap-4">

        <!-- AVATAR -->
        <div class="w-11 h-11 rounded-full flex items-center justify-center shadow-lg border"
             style="
                background:linear-gradient(135deg,#DDDAA8,#f0f2d4);
                border-color:#99A558;
             ">

            <svg class="w-5 h-5"
                 style="color:#41521E"
                 fill="none" stroke="currentColor" stroke-width="2"
                 viewBox="0 0 24 24">
                <path d="M12 15a4 4 0 100-8 4 4 0 000 8z"/>
                <path d="M4 21v-1a7 7 0 0114 0v1"/>
            </svg>

        </div>

        <!-- INFO -->
        <div class="text-right">

            <!-- NAME -->
            <div class="font-semibold text-base"
                 style="color:#27301B;">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        ${sessionScope.user.fullname}
                    </c:when>
                    <c:otherwise>
                        Guest
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- ROLE -->
            <div class="text-xs flex items-center justify-end gap-2"
                 style="color:#41521E;">

                <!-- STATUS DOT -->
                <div class="w-2 h-2 rounded-full"
                     style="background:#909632;"></div>

                <c:choose>
                    <c:when test="${sessionScope.user != null && sessionScope.user.role == 2}">
                        Admin
                    </c:when>

                    <c:when test="${sessionScope.user != null && sessionScope.user.role == 1}">
                        Staff
                    </c:when>

                    <c:when test="${sessionScope.user != null && sessionScope.user.role == 0}">
                        Customer
                    </c:when>

                    <c:otherwise>
                        Khách hàng
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

    </div>

</div>
