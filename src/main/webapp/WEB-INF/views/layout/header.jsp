<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="h-16 bg-gray-900 text-white flex items-center justify-between px-8 shadow">

    <!-- TITLE -->
    <div class="text-xl font-bold">

        <c:choose>
            <c:when test="${sessionScope.user.role}">
                Thông tin Admin
            </c:when>

            <c:otherwise>
                Thông tin User
            </c:otherwise>
        </c:choose>

    </div>


    <!-- USER INFO -->
    <div class="flex items-center gap-3">

        <div class="w-10 h-10 rounded-full bg-gray-600 flex items-center justify-center">
            👤
        </div>

        <div>

            <div class="font-semibold">
                ${sessionScope.user.fullname}
            </div>

            <div class="text-sm text-gray-400">

                <c:choose>
                    <c:when test="${sessionScope.user.role}">
                        Admin
                    </c:when>

                    <c:otherwise>
                        Staff
                    </c:otherwise>
                </c:choose>

            </div>

        </div>

    </div>

</div>