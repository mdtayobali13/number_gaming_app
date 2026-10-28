import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:number_gaminng_app/constant/app_colors.dart';
import 'package:number_gaminng_app/widgets/buttons/app_button.dart';

class OnboardSplashScreen extends StatelessWidget {
  const OnboardSplashScreen({super.key, required this.getStart});
  final void Function() getStart;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F0842),
            Color(0xFF1E1169),
            Color(0xFF120A45),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const Spacer(),

              // Game Header Graphic Container
              Container(
                width: size.width * 0.65,
                height: size.width * 0.65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8C32FF).withOpacity(0.3),
                      blurRadius: 60,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Target Custom Graphic
                    CustomPaint(
                      size: Size(size.width * 0.55, size.width * 0.55),
                      painter: _MiniTargetPainter(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Title: Number Guessing Game
              Column(
                children: [
                  const Text(
                    "WELCOME TO",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 6),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFFFF52A8),
                        Color(0xFFB052FF),
                        Color(0xFF38B6FF),
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      "Number Guessing",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const Text(
                    "Challenge",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFFC837),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Subtitle
              const Text(
                "Test your intuition and logic! Guess the mystery numbers, score high, and win reward badges.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                  fontFamily: 'Poppins',
                ),
              ),

              const Spacer(flex: 2),

              // Get Started Button
              AppButton(
                onTap: getStart,
                title: "Get Started",
                height: 54,
                backgroundColor: const Color(0xFF38B6FF),
                borderColor: const Color(0xFF7DE2FF),
                titleColor: Colors.white,
                loaderColor: AppColors.instance.white50,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniTargetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final List<Map<String, dynamic>> rings = [
      {'r': radius, 'c': const Color(0xFF3B1E8C)},
      {'r': radius * 0.8, 'c': const Color(0xFFECEBFF)},
      {'r': radius * 0.6, 'c': const Color(0xFF7A22F0)},
      {'r': radius * 0.4, 'c': const Color(0xFFFFFFFF)},
      {'r': radius * 0.22, 'c': const Color(0xFFFF4899)},
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
