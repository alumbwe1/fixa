import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/utils/helpers.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fade;

  final TextEditingController _emailController = TextEditingController(
    text: 'alumbwe@example.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'fixa12345',
  );
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fade = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24),
                _buildLogo(),
                const SizedBox(height: 28),
                Text(
                  'Welcome back',
                  textAlign: TextAlign.center,
                  style: appStyle(30, AppColors.textPrimary, FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  AppStrings.tagline,
                  textAlign: TextAlign.center,
                  style: appStyle(14, AppColors.textSecondary, FontWeight.w400),
                ),
                const SizedBox(height: 36),
                CustomTextField(
                  label: AppStrings.email,
                  hint: 'you@example.com',
                  icon: IconlyLight.message,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  label: AppStrings.password,
                  hint: 'Enter your password',
                  icon: IconlyLight.lock,
                  obscureText: _obscure,
                  controller: _passwordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Helpers.showSnack(
                      context,
                      'Password reset link sent (prototype)',
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      textStyle: appStyle(
                        12,
                        AppColors.primary,
                        FontWeight.w500,
                      ),
                    ),
                    child: const Text(AppStrings.forgotPassword),
                  ),
                ),
                const SizedBox(height: 8),
                PrimaryButton(label: AppStrings.signIn, onPressed: _signIn),
                const SizedBox(height: 18),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or',
                        style: appStyle(
                          12,
                          AppColors.textSecondary,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 18),
                _GoogleButton(
                  onPressed: () => Helpers.showSnack(
                    context,
                    'Google Sign-In is mocked in this prototype',
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: appStyle(
                        13,
                        AppColors.textSecondary,
                        FontWeight.w400,
                      ),
                      children: <InlineSpan>[
                        const TextSpan(text: "Don't have an account? "),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () => Helpers.showSnack(
                              context,
                              'Sign-up is coming soon',
                            ),
                            child: Text(
                              AppStrings.signUp,
                              style: appStyle(
                                13,
                                AppColors.primary,
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    AppStrings.poweredBy,
                    style: appStyle(
                      11,
                      AppColors.textSecondary,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/fixa.png',
            height: 150,
            width: 150,
            fit: BoxFit.contain,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stack) {
                  return const Icon(
                    Icons.build_rounded,
                    color: AppColors.primary,
                    size: 48,
                  );
                },
          ),
        ),
      ],
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          backgroundColor: AppColors.surface,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/svgs/google.svg',
              width: 20,
              height: 20,
              placeholderBuilder: (BuildContext context) => const Icon(
                Icons.g_mobiledata_rounded,
                size: 22,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              AppStrings.continueWithGoogle,
              style: appStyle(15, AppColors.textPrimary, FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
