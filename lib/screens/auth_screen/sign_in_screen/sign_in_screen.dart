import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_gaminng_app/routes/app_routes.dart';
import 'package:number_gaminng_app/routes/app_routes_key.dart';
import 'package:number_gaminng_app/screens/auth_screen/sign_in_screen/provider/sign_in_provider.dart';
import 'package:number_gaminng_app/services/storage/storage_services.dart';
import 'package:number_gaminng_app/utils/app_log.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  late GlobalKey<FormState> formKey;
  bool isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  Future<void> checkLoginFunction() async {
    try {
      // Disabled validation for UI preview mode
      AppRoutes.instance.go(AppRoutesKey.instance.homeScreen);
    } catch (e) {
      errorLog("checkLoginFunction", e);
    }
  }

  Future<void> continueAsGuest() async {
    try {
      await StorageServices.instance.setAppRoll("GUEST");
      AppRoutes.instance.pushNamed(AppRoutesKey.instance.homeScreen);
    } catch (e) {
      errorLog("checkLoginFunction", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Navigation Bar (Back Arrow)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        AppRoutes.instance.pop();
                      } else {
                        AppRoutes.instance.go(AppRoutesKey.instance.onBoardScreen);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF0F172A),
                      size: 22,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),

                const SizedBox(height: 24),

                // Title: Welcome Back
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins',
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 6),

                // Subtitle
                const Text(
                  "Sign in to continue",
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 32),

                // Email Input Field
                _StyledInputField(
                  controller: emailTextEditingController,
                  icon: Icons.mail_outline_rounded,
                  title: "Email",
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                // Password Input Field
                _StyledInputField(
                  controller: passwordTextEditingController,
                  icon: Icons.lock_outline_rounded,
                  title: "Password",
                  hintText: "Enter your password",
                  obscureText: isPasswordObscured,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF94A3B8),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordObscured = !isPasswordObscured;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      AppRoutes.instance.pushNamed(AppRoutesKey.instance.forgotScreen);
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Color(0xFF4F46E5),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Primary Sign In Button
                Consumer(
                  builder: (context, ref, child) {
                    final isLoading = ref.watch(signInProvider);

                    return SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : checkLoginFunction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F46E5),
                          elevation: 4,
                          shadowColor: const Color(0xFF4F46E5).withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // OR Divider
                Row(
                  children: const [
                    Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                  ],
                ),

                const SizedBox(height: 24),

                // Continue with Google Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      AppRoutes.instance.go(AppRoutesKey.instance.homeScreen);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _GoogleLogoIcon(),
                        SizedBox(width: 12),
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Browse as Guest Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: continueAsGuest,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Browse as Guest",
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Bottom Link: Don't have an account? Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppRoutes.instance.pushNamed(AppRoutesKey.instance.signUpScreen);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFF4F46E5),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Styled Input Field Widget
class _StyledInputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String title;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const _StyledInputField({
    required this.controller,
    required this.icon,
    required this.title,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Icon Badge
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4F46E5),
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          // Field Title + TextFormField
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 4, bottom: 2),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),

          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}

/// Google Logo Custom Icon
class _GoogleLogoIcon extends StatelessWidget {
  const _GoogleLogoIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      child: const Text(
        "G",
        style: TextStyle(
          color: Color(0xFF4285F4),
          fontSize: 20,
          fontWeight: FontWeight.w900,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
