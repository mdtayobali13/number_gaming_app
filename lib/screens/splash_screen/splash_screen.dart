import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:number_gaminng_app/constant/app_asserts_icons_path.dart';
import 'package:number_gaminng_app/routes/app_routes.dart';
import 'package:number_gaminng_app/routes/app_routes_key.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _floatingController;
  late final AnimationController _pulseController;
  late final AnimationController _rotationController;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _navigationTimer = Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        AppRoutes.instance.goNamed(AppRoutesKey.instance.onBoardScreen);
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _floatingController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Sleek Ambient Glows
          Positioned(
            top: size.height * 0.18,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.25),
                    blurRadius: 120,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Floating Splash Logo
                AnimatedBuilder(
                  animation: _floatingController,
                  builder: (context, child) {
                    final double offset = math.sin(_floatingController.value * math.pi * 2) * 8.0;
                    return Transform.translate(
                      offset: Offset(0, offset),
                      child: child,
                    );
                  },
                  child: Container(
                    height: size.height * 0.42,
                    width: size.width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4F46E5).withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      AppAssertsIconsPath.instance.splashLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Premium Multi-color Title
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Number",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFFEC4899),
                          Color(0xFFA855F7),
                          Color(0xFF3B82F6),
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        "Guessing",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          height: 1.1,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const Text(
                      "Game",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFBBF24),
                        fontFamily: 'Poppins',
                        height: 1.1,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Tagline
                const Text(
                  "Think  •  Guess  •  Win",
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    fontFamily: 'Poppins',
                  ),
                ),

                const Spacer(flex: 3),

                // Bottom Loader
                RotationTransition(
                  turns: _rotationController,
                  child: Container(
                    width: 44,
                    height: 44,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF38B6FF).withOpacity(0.3),
                          blurRadius: 14,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: _GradientProgressPainter(),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: 0.6 + (_pulseController.value * 0.4),
                      child: child,
                    );
                  },
                  child: const Text(
                    "Get Ready...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      letterSpacing: 0.8,
                    ),
                  ),
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = -math.pi / 2;
    const sweepAngle = math.pi * 1.5;

    final paint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF38B6FF),
          Color(0xFF8B5CF6),
          Color(0xFFEC4899),
          Color(0xFF38B6FF),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
