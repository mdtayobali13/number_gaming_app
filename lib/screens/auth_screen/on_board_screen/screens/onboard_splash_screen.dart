import 'package:flutter/material.dart';
import 'package:number_gaminng_app/constant/app_asserts_icons_path.dart';
import 'package:number_gaminng_app/routes/app_routes.dart';
import 'package:number_gaminng_app/routes/app_routes_key.dart';

class OnboardSplashScreen extends StatelessWidget {
  const OnboardSplashScreen({super.key, required this.getStart});
  final void Function() getStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),

            // Top Onboarding Graphic Image
            Center(
              child: SizedBox(
                height: 190,
                child: Image.asset(
                  AppAssertsIconsPath.instance.onboarding,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    AppAssertsIconsPath.instance.splashLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Title
            const Text(
              "Number Guessing Game",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900,
                fontFamily: 'Poppins',
                letterSpacing: 0.2,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.0),
              child: Text(
                "Challenge your friends, test your skills and have fun!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  fontFamily: 'Poppins',
                ),
              ),
            ),

            const Spacer(flex: 2),

            // 3 Feature Icons Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _FeatureCardItem(
                    icon: Icons.person_rounded,
                    iconColor: Color(0xFF38B6FF),
                    backgroundColor: Color(0xFF1E293B),
                    title: "Play Solo",
                    subtitle: "(Online)",
                  ),
                  _FeatureCardItem(
                    icon: Icons.groups_rounded,
                    iconColor: Color(0xFFA855F7),
                    backgroundColor: Color(0xFF1E293B),
                    title: "Challenge",
                    subtitle: "Friends",
                  ),
                  _FeatureCardItem(
                    icon: Icons.emoji_events_rounded,
                    iconColor: Color(0xFFFBBF24),
                    backgroundColor: Color(0xFF1E293B),
                    title: "Track",
                    subtitle: "Scores",
                  ),
                ],
              ),
            ),

            const Spacer(flex: 2),

            // Buttons Section (Sign In & Sign Up)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  // Primary Filled Button: Sign In
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        AppRoutes.instance.go(AppRoutesKey.instance.signInScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        elevation: 4,
                        shadowColor: const Color(0xFF4F46E5).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Secondary Outlined Button: Sign Up
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () {
                        AppRoutes.instance.go(AppRoutesKey.instance.signUpScreen);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF4F46E5), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFF818CF8),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Bottom Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRoutes.instance.go(AppRoutesKey.instance.signInScreen);
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Color(0xFF818CF8),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// Feature Card Item
class _FeatureCardItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;

  const _FeatureCardItem({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: iconColor.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 34,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            height: 1.1,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            height: 1.1,
          ),
        ),
      ],
    );
  }
}
