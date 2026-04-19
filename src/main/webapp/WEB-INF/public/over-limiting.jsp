<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PolyCafe - Đang pha chế...</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Coffee Drip Animation */
        @keyframes drop {
            0% { transform: translateY(0) scaleX(1); opacity: 0; }
            10% { opacity: 1; }
            80% { transform: translateY(100px) scaleX(0.8); opacity: 1; }
            100% { transform: translateY(110px) scaleX(1.5); opacity: 0; }
        }

        @keyframes fill {
            0% { height: 0%; }
            100% { height: 70%; }
        }

        @keyframes steam-wave {
            0% { stroke-dashoffset: 0; opacity: 0; transform: translateY(0); }
            50% { opacity: 0.8; }
            100% { stroke-dashoffset: 100; opacity: 0; transform: translateY(-20px); }
        }

        .coffee-drop {
            animation: drop 1.5s infinite cubic-bezier(0.5, 0, 0.75, 0);
        }

        .liquid-fill {
            animation: fill 10s infinite alternate ease-in-out;
        }

        .steam-path {
            stroke-dasharray: 20;
            animation: steam-wave 3s infinite linear;
        }

        .glass-panel {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.07);
        }

        @keyframes float-slow {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(10px, -15px) rotate(5deg); }
            66% { transform: translate(-10px, 10px) rotate(-5deg); }
        }
    </style>
</head>

<body class="min-h-screen relative flex items-center justify-center overflow-hidden"
      style="background: #fdfbf7;">

    <!-- BACKGROUND ELEMENTS -->
    <div class="absolute inset-0 z-0">
        <div class="absolute top-[15%] left-[15%] w-64 h-64 bg-[#cfd5a5]/20 rounded-full blur-3xl"></div>
        <div class="absolute bottom-[10%] right-[10%] w-96 h-96 bg-[#909632]/10 rounded-full blur-3xl"></div>
    </div>

    <!-- FLOATING DECOR -->
    <div class="absolute inset-0 pointer-events-none opacity-20">
        <svg class="absolute top-20 left-40 w-12 h-12 animate-[float-slow_6s_infinite]" viewBox="0 0 24 24" fill="#27301B">
            <path d="M18.3,5.6c-0.5-0.8-1.3-1.4-2.2-1.8c-1-0.4-2-0.5-3.1-0.2c-0.8,0.2-1.5,0.7-2.1,1.2c-0.6-0.6-1.3-1-2.1-1.2C7.7,3.3,6.7,3.4,5.7,3.8C4.8,4.2,4,4.8,3.5,5.6C2.9,6.5,2.7,7.5,2.7,8.5c0,2.1,1,4.1,2.8,5.4l5.3,4.4c0.3,0.2,0.7,0.4,1.1,0.4c0.4,0,0.8-0.1,1.1-0.4l5.3-4.4c1.8-1.3,2.8-3.3,2.8-5.4C21.2,7.5,20.9,6.5,18.3,5.6z"/>
        </svg>
        <svg class="absolute bottom-40 right-40 w-16 h-16 animate-[float-slow_8s_infinite_reverse]" viewBox="0 0 24 24" fill="#41521E">
            <path d="M20,10c0-4.4-3.6-8-8-8S4,5.6,4,10c0,2.2,1.8,4,4,4h8C18.2,14,20,12.2,20,10z M9,12c-0.6,0-1-0.4-1-1s0.4-1,1-1s1,0.4,1,1S9.6,12,9,12z M15,12c-0.6,0-1-0.4-1-1s0.4-1,1-1s1,0.4,1,1S15.6,12,15,12z"/>
        </svg>
    </div>

    <!-- MAIN CONTAINER -->
    <div class="relative z-10 w-full max-w-xl mx-auto px-6">
        
        <div class="glass-panel rounded-[3rem] p-12 text-center overflow-hidden relative">
            
            <!-- BREWING ILLUSTRATION -->
            <div class="w-48 h-64 mx-auto mb-8 relative">
                <svg viewBox="0 0 200 250" class="w-full h-full">
                    <!-- FILTER / DRIPPER -->
                    <path d="M50 40 L150 40 L120 100 L80 100 Z" fill="#27301B" />
                    <rect x="75" y="30" width="50" height="5" rx="2" fill="#41521E" />
                    
                    <!-- THE DROP -->
                    <circle cx="100" cy="110" r="4" fill="#6F4E37" class="coffee-drop" />
                    
                    <!-- CARAFE (BÌNH ĐỰNG) -->
                    <path d="M70 120 C 50 120, 40 140, 40 160 C 40 210, 60 230, 100 230 C 140 230, 160 210, 160 160 C 160 140, 150 120, 130 120 Z" 
                          fill="none" stroke="#27301B" stroke-width="4" />
                    
                    <!-- COFFEE LIQUID IN CARAFE -->
                    <mask id="carafeMask">
                        <path d="M70 120 C 50 120, 40 140, 40 160 C 40 210, 60 230, 100 230 C 140 230, 160 210, 160 160 C 160 140, 150 120, 130 120 Z" fill="white" />
                    </mask>
                    <g mask="url(#carafeMask)">
                        <rect x="0" y="160" width="200" height="100" fill="#6F4E37" class="liquid-fill" opacity="0.9" />
                    </g>

                    <!-- STEAM -->
                    <g fill="none" stroke="#cfd5a5" stroke-width="3" stroke-linecap="round">
                        <path class="steam-path" d="M80 20 Q 85 10 80 0" style="animation-delay: 0s;" />
                        <path class="steam-path" d="M100 25 Q 105 15 100 5" style="animation-delay: 0.5s;" />
                        <path class="steam-path" d="M120 20 Q 125 10 120 0" style="animation-delay: 1s;" />
                    </g>
                </svg>
            </div>

            <!-- CONTENT -->
            <div class="relative z-10">
                <h1 class="text-4xl font-black text-[#27301B] mb-6 leading-tight">
                    Đang chiết xuất <br><span class="text-[#909632]">tinh hoa...</span>
                </h1>
                
                <p class="text-gray-600 text-lg mb-10 max-w-sm mx-auto leading-relaxed">
                    Hệ thống đang xử lý yêu cầu của bạn theo phong cách Slow Bar. Vui lòng thư giãn trong giây lát!
                </p>

                <!-- PROGRESS BAR (VISUAL ONLY) -->
                <div class="w-48 h-1.5 bg-gray-200 mx-auto rounded-full mb-10 overflow-hidden">
                    <div class="h-full bg-[#27301B] rounded-full animate-[fill_2s_infinite_linear]"></div>
                </div>

                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/home"
                       class="px-10 py-4 bg-[#27301B] text-white rounded-2xl font-bold shadow-xl hover:bg-[#41521E] transform hover:-translate-y-1 transition-all duration-300">
                        Thử lại
                    </a>
                    
                    <button onclick="window.location.reload()"
                       class="px-10 py-4 bg-white text-[#27301B] border-2 border-[#27301B]/10 rounded-2xl font-bold hover:bg-gray-50 transition-all duration-300">
                        Làm mới
                    </button>
                </div>
            </div>

            <!-- DECORATIVE CORNER -->
            <div class="absolute top-0 right-0 -mt-8 -mr-8 w-32 h-32 bg-[#cfd5a5]/30 rounded-full blur-2xl"></div>
        </div>

        <!-- FOOTER INFO -->
        <p class="mt-8 text-center text-sm font-bold text-[#27301B]/40 uppercase tracking-[0.2em]">
            PolyCafe • Security Protocol
        </p>
    </div>

    <!-- NOISE TEXTURE -->
    <div class="absolute inset-0 z-0 opacity-[0.03] pointer-events-none bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')]"></div>

</body>
</html>
