import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_gaminng_app/constant/app_asserts_image_path.dart';
import 'package:number_gaminng_app/constant/app_colors.dart';
import 'package:number_gaminng_app/routes/app_routes.dart';
import 'package:number_gaminng_app/routes/app_routes_key.dart';
import 'package:number_gaminng_app/screens/auth_screen/sign_in_screen/provider/sign_in_provider.dart';
import 'package:number_gaminng_app/services/storage/storage_services.dart';
import 'package:number_gaminng_app/utils/app_log.dart';
import 'package:number_gaminng_app/utils/app_size.dart';
import 'package:number_gaminng_app/utils/app_snack_bar.dart';
import 'package:number_gaminng_app/utils/gap.dart';
import 'package:number_gaminng_app/widgets/app_image/app_image.dart';
import 'package:number_gaminng_app/widgets/buttons/app_button.dart';
import 'package:number_gaminng_app/widgets/inputs/app_input_widget_tow.dart';
import 'package:number_gaminng_app/widgets/texts/app_text.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  late GlobalKey<FormState> formKey;

  Future<void> checkLoginFunction() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      final response = await ref
          .read(signInProvider.notifier)
          .signIn(emailTextEditingController.text.trim(), passwordTextEditingController.text.trim());
      if (response) {
        AppRoutes.instance.go(AppRoutesKey.instance.homeScreen);
      } else {
        AppSnackBar.instance.error("Invalid email and password");
      }
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

  void onInitialApp() {
    try {
      emailTextEditingController = .new();
      passwordTextEditingController = .new();
      formKey = .new();
    } catch (e) {
      errorLog("onInitialApp", e);
    }
  }

  @override
  void initState() {
    super.initState();
    onInitialApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: AppSize.size.width,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppSize.size.width * 0.8,
                    height: AppSize.size.height * 0.14,
                    child: Center(
                      child: AppImage(width: AppSize.size.width * 0.8, path: AppAssertsImagePath.instance.logo),
                    ),
                  ),

                  SizedBox(
                    width: AppSize.size.width * 0.8,
                    child: AppText(
                      text: "Welcome back! Please login to your account.",
                      textAlign: TextAlign.center,

                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      fontSize: AppSize.width(value: 18),
                    ),
                  ),
                  AppInputWidgetTwo(
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return "Enter your email";
                      }
                      return null;
                    },
                    title: "Email",
                    isEmail: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextEditingController,
                    textInputAction: TextInputAction.next,
                  ),
                  AppInputWidgetTwo(
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return "Enter your password";
                      }
                      if (value!.length < 6) {
                        return "Al least 6 character";
                      }
                      return null;
                    },
                    title: "Password",
                    isPassWord: true,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: passwordTextEditingController,
                    textInputAction: TextInputAction.done,
                  ),
                  Gap(height: 30),
                  Consumer(
                    builder: (context, ref, child) {
                      var provider = ref.watch(signInProvider);
                      return AppButton(
                        isLoading: provider,
                        onTap: checkLoginFunction,
                        title: "Login",
                        backgroundColor: AppColors.instance.success,
                        borderColor: AppColors.instance.success,
                        padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 10)),
                        margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20)),
                      );
                    },
                  ),
                  Gap(height: 30),
                  AppButton(
                    onTap: continueAsGuest,
                    title: "Browse as Guest",
                    backgroundColor: AppColors.instance.white50,
                    borderColor: AppColors.instance.dark500,
                    titleColor: AppColors.instance.dark500,
                    padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 10)),
                    margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20)),
                  ),
                  Gap(height: 30),
                  InkWell(
                    onTap: () {
                      AppRoutes.instance.pushNamed(AppRoutesKey.instance.forgotScreen);
                    },
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    child: AppText(text: "Forgot password?", fontWeight: FontWeight.w600, color: AppColors.instance.error),
                  ),
                  Gap(height: 10),
                  Wrap(
                    children: [
                      AppText(text: "Don't have an account?"),
                      Gap(width: 10),
                      InkWell(
                        onTap: () {
                          AppRoutes.instance.pushNamed(AppRoutesKey.instance.signUpScreen);
                        },
                        overlayColor: WidgetStatePropertyAll(Colors.transparent),
                        child: AppText(text: "Sign up", fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
