import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
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

    // Floating bobbing animation for central graphics
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

                  // Floating Graphic Section (Target + Arrow + Floating Cards)
                  AnimatedBuilder(
                    animation: _floatingController,
                    builder: (context, child) {
                      final double offset = math.sin(_floatingController.value * math.pi * 2) * 8.0;
                      return Transform.translate(
                        offset: Offset(0, offset),
                        child: child,
                      );
                    },
                    child: _CentralGameGraphic(screenSize: size),
                  ),

                  const SizedBox(height: 32),

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

/// Central Target Board with Dart Arrow & Floating Number Cards
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
          // 3D Ellipse Platform / Shadow under target
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

          // Target Board + Dart Arrow Custom Painter
          CustomPaint(
            size: Size(graphicSize, graphicSize),
            painter: TargetAndDartPainter(),
          ),

          // Floating Number Card: "7" (Top-Left, Cyan/Blue)
          Positioned(
            top: 10,
            left: 15,
            child: Transform.rotate(
              angle: -0.22,
              child: const _NumberCardWidget(
                number: "7",
                gradientColors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
                borderColor: Color(0xFF7DE2FF),
              ),
            ),
          ),

          // Floating Number Card: "3" (Bottom-Left, Vivid Green)
          Positioned(
            bottom: 35,
            left: 0,
            child: Transform.rotate(
              angle: 0.15,
              child: const _NumberCardWidget(
                number: "3",
                gradientColors: [Color(0xFF23D5AB), Color(0xFF23A6D5)],
                borderColor: Color(0xFF88FFD2),
              ),
            ),
          ),

          // Floating Number Card: "9" (Right, Purple/Magenta)
          Positioned(
            top: 75,
            right: 0,
            child: Transform.rotate(
              angle: 0.20,
              child: const _NumberCardWidget(
                number: "9",
                gradientColors: [Color(0xFFE100FF), Color(0xFF7F00FF)],
                borderColor: Color(0xFFF18BFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 3D Number Card Component
class _NumberCardWidget extends StatelessWidget {
  final String number;
  final List<Color> gradientColors;
  final Color borderColor;

  const _NumberCardWidget({
    required this.number,
    required this.gradientColors,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        border: Border.all(color: borderColor.withOpacity(0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            fontFamily: 'Poppins',
            shadows: [
              Shadow(
                color: Colors.black38,
                offset: Offset(1, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
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

    // 1. Target Outer Shadow
    final shadowPaint = Paint()
      ..color = const Color(0xFF6B22F0).withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(center, radius - 10, shadowPaint);

    // 2. Concentric Target Rings
    final List<Map<String, dynamic>> rings = [
      {'r': radius - 12, 'c': const Color(0xFF3B1E8C)}, // Outer Deep Violet Ring
      {'r': radius - 26, 'c': const Color(0xFFECEBFF)}, // White Ring
      {'r': radius - 44, 'c': const Color(0xFF7A22F0)}, // Vivid Purple Ring
      {'r': radius - 62, 'c': const Color(0xFFFFFFFF)}, // Inner White Ring
      {'r': radius - 78, 'c': const Color(0xFFEE2B8C)}, // Pink Bullseye Outer
      {'r': radius - 90, 'c': const Color(0xFFFF4899)}, // Bullseye Center
    ];

    for (var ring in rings) {
      final paint = Paint()
        ..color = ring['c'] as Color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, ring['r'] as double, paint);
    }

    // Target Inner Specular Highlight / Glow
    final bullseyeGlow = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx - 4, center.dy - 4), 6, bullseyeGlow);

    // 3. Golden Arrow / Dart Piercing Bullseye Center
    _drawGoldenDart(canvas, center);
  }

  void _drawGoldenDart(Canvas canvas, Offset targetCenter) {
    canvas.save();

    // Rotate and position the dart at an isometric 45-degree angle
    canvas.translate(targetCenter.dx, targetCenter.dy);
    canvas.rotate(-math.pi / 4);

    // Shaft of the Dart
    final shaftPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFD700), Color(0xFFFF9100), Color(0xFFFF6D00)],
      ).createShader(const Rect.fromLTWH(0, 0, 90, 8))
      ..style = PaintingStyle.fill;

    final shaftPath = Path()
      ..moveTo(0, -3)
      ..lineTo(85, -5)
      ..lineTo(85, 5)
      ..lineTo(0, 3)
      ..close();
    canvas.drawPath(shaftPath, shaftPaint);

    // Dart Tip (Point in bullseye)
    final tipPaint = Paint()..color = const Color(0xFFFFE57F);
    final tipPath = Path()
      ..moveTo(0, -3)
      ..lineTo(-12, 0)
      ..lineTo(0, 3)
      ..close();
    canvas.drawPath(tipPath, tipPaint);

    // Golden Wings / Fletching of Dart
    final wingPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFEA00), Color(0xFFFFAB00)],
      ).createShader(const Rect.fromLTWH(65, -28, 40, 56));

    // Upper Wing
    final upperWing = Path()
      ..moveTo(60, -4)
      ..lineTo(95, -28)
      ..lineTo(80, -4)
      ..close();
    canvas.drawPath(upperWing, wingPaint);

    // Lower Wing
    final lowerWing = Path()
      ..moveTo(60, 4)
      ..lineTo(95, 28)
      ..lineTo(80, 4)
      ..close();
    canvas.drawPath(lowerWing, wingPaint);

    // Wing Accent Lines
    final wingAccent = Paint()
      ..color = const Color(0xFFFF6D00)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawLine(const Offset(65, -5), const Offset(90, -22), wingAccent);
    canvas.drawLine(const Offset(65, 5), const Offset(90, 22), wingAccent);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Title Text Section with Multi-color & Gradient Text
class _GameTitleSection extends StatelessWidget {
  const _GameTitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // "Number"
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

        // "Guessing" with Gradient Mask
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFFFF52A8), // Bright Pink
              Color(0xFFB052FF), // Purple
              Color(0xFF38B6FF), // Cyan Blue
            ],
          ).createShader(bounds),
          child: const Text(
            "Guessing",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: Colors.white, // Required for ShaderMask
              fontFamily: 'Poppins',
              height: 1.1,
              letterSpacing: 0.5,
            ),
          ),
        ),

        // "Game"
        const Text(
          "Game",
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFC837), // Vibrant Golden Yellow
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
        // Glowing Rotating Ring Indicator
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

        // Pulsing "Get Ready..." Text
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
