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

    // Floating bobbing animation for splash logo
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Subtle pulsing animation for "Get Ready..." text
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Continuous rotation for loading ring
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Auto navigate to OnBoard screen after 3.5 seconds
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F0842), // Deep purple navy top
              Color(0xFF1E1169), // Rich indigo middle
              Color(0xFF120A45), // Dark violet bottom
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background ambient shapes & glow
            const _BackgroundGlow(),

            // Background sparkles
            const _SparklesLayer(),

            // Main Content Area
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Floating Splash Logo Section
                  AnimatedBuilder(
                    animation: _floatingController,
                    builder: (context, child) {
                      final double offset = math.sin(_floatingController.value * math.pi * 2) * 8.0;
                      return Transform.translate(
                        offset: Offset(0, offset),
                        child: child,
                      );
                    },
                    child: SizedBox(
                      height: size.height * 0.42,
                      width: size.width * 0.85,
                      child: Image.asset(
                        AppAssertsIconsPath.instance.splashLogo,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => _CentralGameGraphic(screenSize: size),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title Text Section
                  const _GameTitleSection(),

                  const SizedBox(height: 12),

                  // Subtitle Tagline
                  const Text(
                    "Think  •  Guess  •  Win",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Bottom Loading Ring and "Get Ready..."
                  _BottomLoadingWidget(
                    rotationController: _rotationController,
                    pulseController: _pulseController,
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Ambient Glows and Fluid Background Shapes
class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top Left Purple Fluid Arc
        Positioned(
          top: -60,
          left: -60,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF5D2EE8).withOpacity(0.25),
            ),
          ),
        ),

        // Central Radial Glow behind Target
        Positioned(
          top: MediaQuery.of(context).size.height * 0.22,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8C32FF).withOpacity(0.35),
                  blurRadius: 100,
                  spreadRadius: 40,
                ),
              ],
            ),
          ),
        ),

        // Bottom Left Curved Fluid Shape
        Positioned(
          bottom: -40,
          left: -50,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4319AC).withOpacity(0.3),
            ),
          ),
        ),

        // Bottom Right Glowing Dot
        Positioned(
          bottom: 100,
          right: 30,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF38B6FF).withOpacity(0.4),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF38B6FF).withOpacity(0.6),
                  blurRadius: 16,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Floating Sparkles/Dots around the graphic
class _SparklesLayer extends StatelessWidget {
  const _SparklesLayer();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Positioned(top: 140, left: 60, child: _SparkleDot(size: 6, color: Color(0xFF00E5FF))),
        Positioned(top: 180, right: 70, child: _SparkleDot(size: 8, color: Color(0xFFFF4081))),
        Positioned(top: 290, left: 40, child: _SparkleDot(size: 5, color: Color(0xFFFFD700))),
        Positioned(top: 340, right: 50, child: _SparkleDot(size: 7, color: Color(0xFF00FF87))),
      ],
    );
  }
}

class _SparkleDot extends StatelessWidget {
  final double size;
  final Color color;

  const _SparkleDot({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            blurRadius: size * 1.5,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

/// Central Target Board with Dart Arrow & Floating Number Cards (Fallback)
class _CentralGameGraphic extends StatelessWidget {
  final Size screenSize;

  const _CentralGameGraphic({required this.screenSize});

  @override
  Widget build(BuildContext context) {
    final double graphicSize = math.min(screenSize.width * 0.72, 280.0);

    return SizedBox(
      width: graphicSize + 60,
      height: graphicSize + 60,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 25,
            child: Container(
              width: graphicSize * 0.8,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(graphicSize * 0.8, 40)),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2C106B).withOpacity(0.9),
                    const Color(0xFF0D083A).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          CustomPaint(
            size: Size(graphicSize, graphicSize),
            painter: TargetAndDartPainter(),
          ),
        ],
      ),
    );
  }
}

/// Custom Painter for Target Board and Golden Arrow/Dart
class TargetAndDartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final shadowPaint = Paint()
      ..color = const Color(0xFF6B22F0).withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(center, radius - 10, shadowPaint);

    final List<Map<String, dynamic>> rings = [
      {'r': radius - 12, 'c': const Color(0xFF3B1E8C)},
      {'r': radius - 26, 'c': const Color(0xFFECEBFF)},
      {'r': radius - 44, 'c': const Color(0xFF7A22F0)},
      {'r': radius - 62, 'c': const Color(0xFFFFFFFF)},
      {'r': radius - 78, 'c': const Color(0xFFEE2B8C)},
      {'r': radius - 90, 'c': const Color(0xFFFF4899)},
    ];

    for (var ring in rings) {
      final paint = Paint()
        ..color = ring['c'] as Color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, ring['r'] as double, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Title Text Section
class _GameTitleSection extends StatelessWidget {
  const _GameTitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Color(0xFFFF52A8),
              Color(0xFFB052FF),
              Color(0xFF38B6FF),
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
            color: Color(0xFFFFC837),
            fontFamily: 'Poppins',
            height: 1.1,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

/// Bottom Circular Progress Ring & "Get Ready..." Text
class _BottomLoadingWidget extends StatelessWidget {
  final AnimationController rotationController;
  final AnimationController pulseController;

  const _BottomLoadingWidget({
    required this.rotationController,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: rotationController,
          child: Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E5FF).withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CustomPaint(
              painter: GradientCircularProgressPainter(),
            ),
          ),
        ),

        const SizedBox(height: 16),

        AnimatedBuilder(
          animation: pulseController,
          builder: (context, child) {
            return Opacity(
              opacity: 0.6 + (pulseController.value * 0.4),
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
      ],
    );
  }
}

/// Custom Gradient Circular Progress Ring Painter
class GradientCircularProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = -math.pi / 2;
    const sweepAngle = math.pi * 1.5;

    final paint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF00E5FF),
          Color(0xFF7F00FF),
          Color(0xFFFF007F),
          Color(0xFF00E5FF),
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
