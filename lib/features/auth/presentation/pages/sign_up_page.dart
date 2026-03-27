import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field_v2/country_picker_dialog.dart';
import 'package:intl_phone_field_v2/countries.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/size_config.dart';
import '../../logic/auth_bloc.dart';
import '../../logic/auth_event.dart';
import '../../logic/auth_state.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_strength_meter.dart';
import '../widgets/social_auth_row.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show OAuthProvider;

/// Sign-up screen (Figma Node 17-377).
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedGender = 'Male';
  Country _selectedCountry = countries.firstWhere((c) => c.code == 'EG');
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _password = '';
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure && state.previousState is Registering) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          setState(() => _errorMessage = state.message);
        } else if (state is AuthLoading) {
          // No-op, handled by builder for button state
        } else {
          setState(() => _errorMessage = null);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading && state.previousState is Registering;
        return Scaffold(
          backgroundColor: AppColors.scaffoldDark,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => context.read<AuthBloc>().add(const AuthGoBack()),
            ),
          ),
          body: Stack(
            children: [
              // Background blurs
              Positioned(
                top: 133,
                left: 20,
                child: Container(
                  width: 156,
                  height: 156,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.labelBlue.withValues(alpha: 0.05),
                  ),
                ),
              ),
              Positioned(
                bottom: 133,
                right: 20,
                child: Container(
                  width: 117,
                  height: 117,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGold.withValues(alpha: 0.05),
                  ),
                ),
              ),

              // Content
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 36,
                  ),
                  child: Column(
                    children: [
                      // Brand header
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 600),
                        child: Text(
                          AppStrings.brandName,
                          style: GoogleFonts.newsreader(
                            color: AppColors.silver,
                            fontSize: 48 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -2.4,
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.01), // 8
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 600),
                        child: Text(
                          AppStrings.obsidianCurator.toUpperCase(),
                          style: GoogleFonts.inter(
                            color: AppColors.silver.withValues(alpha: 0.6),
                            fontSize: 14 * SizeConfig.textMultiplier,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.06), // 48

                      // ── Registration Card ──
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          width: double.infinity,
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: AppColors.cardDark,
                            borderRadius: BorderRadius.circular(48),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 80,
                                offset: const Offset(0, 20),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.createYourAccount,
                                style: GoogleFonts.newsreader(
                                  color: AppColors.textPrimary,
                                  fontSize: 30 * SizeConfig.textMultiplier,
                                  letterSpacing: -0.75,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                              // Full Name
                              AuthTextField(
                                label: AppStrings.fullNameLabel,
                                hint: AppStrings.fullNameHint,
                                controller: _nameController,
                                errorText:
                                    _errorMessage != null &&
                                            _errorMessage!.toLowerCase().contains('name')
                                        ? _errorMessage
                                        : null,
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                              // Email
                              AuthTextField(
                                label: AppStrings.emailLabel,
                                hint: AppStrings.emailHint,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                errorText:
                                    _errorMessage != null &&
                                            _errorMessage!.toLowerCase().contains('email')
                                        ? _errorMessage
                                        : null,
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                              // Phone Number
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4, bottom: 8),
                                    child: Text(
                                      AppStrings.phoneNumberLabel,
                                      style: GoogleFonts.inter(
                                        color: _errorMessage != null &&
                                                _errorMessage!.toLowerCase().contains('phone')
                                            ? AppColors.errorText
                                            : AppColors.labelBlue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.inputFill,
                                      borderRadius: BorderRadius.circular(28),
                                      border: Border.all(
                                        color: _errorMessage != null &&
                                                _errorMessage!.toLowerCase().contains('phone')
                                            ? AppColors.error
                                            : AppColors.inputBorderBlue.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: _showCountryPicker,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 19,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  _selectedCountry.flag,
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '+${_selectedCountry.dialCode}',
                                                  style: GoogleFonts.inter(
                                                    color: AppColors.textPrimary,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: AppColors.silver,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: _phoneController,
                                            keyboardType: TextInputType.phone,
                                            style: GoogleFonts.inter(
                                              color: AppColors.textPrimary,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: AppStrings.phoneNumberHint,
                                              hintStyle: GoogleFonts.inter(
                                                color: AppColors.hintText.withValues(alpha: 0.4),
                                                fontSize: 16,
                                              ),
                                              border: InputBorder.none,
                                              counterText: '',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 25),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                              // Gender Selection
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.genderLabel,
                                    style: GoogleFonts.inter(
                                      color: AppColors.labelBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight * 0.015), // 12
                                  Row(
                                    children: [
                                      _buildGenderOption('Male'),
                                      const SizedBox(width: 12),
                                      _buildGenderOption('Female'),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                              // Password
                              AuthTextField(
                                label: AppStrings.passwordLabel,
                                hint: AppStrings.passwordHint,
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                onToggleObscure: () =>
                                    setState(() => _obscurePassword = !_obscurePassword),
                                onChanged: (v) => setState(() => _password = v),
                                errorText:
                                    _errorMessage != null &&
                                            _errorMessage!.toLowerCase().contains('password')
                                        ? _errorMessage
                                        : null,
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.015), // 12

                              // Password Strength Meter
                              PasswordStrengthMeter(password: _password),
                              SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                              // Confirm Password
                              AuthTextField(
                                label: AppStrings.confirmPasswordLabel,
                                hint: AppStrings.passwordHint,
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirmPassword,
                                onToggleObscure: () => setState(
                                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                                ),
                                errorText:
                                    _errorMessage != null &&
                                            _errorMessage!.toLowerCase().contains('confirm')
                                        ? _errorMessage
                                        : null,
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                              // Submit button
                              AuthButton(
                                label: AppStrings.beginJourney,
                                isPrimary: false,
                                isLoading: isLoading,
                                onPressed: isLoading ? null : () {
                                  if (_passwordController.text != _confirmPasswordController.text) {
                                    setState(() => _errorMessage = 'Passwords do not match');
                                    return;
                                  }
                                  context.read<AuthBloc>().add(SignUpSubmitted(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    fullName: _nameController.text,
                                  ));
                                },
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.05), // 40

                              // Divider
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.ghostBorder.withValues(alpha: 0.1),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      AppStrings.orContinueWith.toUpperCase(),
                                      style: GoogleFonts.inter(
                                        color: AppColors.hintText.withValues(alpha: 0.4),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.ghostBorder.withValues(alpha: 0.1),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                              // Social Auth Row
                              SocialAuthRow(
                                onApplePressed: () => context
                                    .read<AuthBloc>()
                                    .add(const SocialSignInPressed(OAuthProvider.apple)),
                                onGooglePressed: () => context
                                    .read<AuthBloc>()
                                    .add(const SocialSignInPressed(OAuthProvider.google)),
                                onFacebookPressed: () => context
                                    .read<AuthBloc>()
                                    .add(const SocialSignInPressed(OAuthProvider.facebook)),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                              // Already a member
                              FadeInUp(
                                delay: const Duration(milliseconds: 400),
                                duration: const Duration(milliseconds: 600),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () =>
                                        context.read<AuthBloc>().add(const ShowLoginEvent()),
                                    child: RichText(
                                      text: TextSpan(
                                        text: AppStrings.alreadyMember,
                                        style: GoogleFonts.inter(
                                          color: AppColors.silver.withValues(alpha: 0.6),
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: AppStrings.signIn,
                                            style: GoogleFonts.inter(
                                              color: AppColors.labelBlue,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                      // ── Why Verify Card ──
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: AppColors.navyButton,
                          borderRadius: BorderRadius.circular(48),
                        ),
                        child: Stack(
                          children: [
                            // Decorative blur
                            Positioned(
                              top: -48,
                              right: -48,
                              child: Container(
                                width: 192,
                                height: 192,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.labelBlue.withValues(alpha: 0.05),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Shield icon
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.inputBorderBlue.withValues(alpha: 0.2),
                                  ),
                                  child: const Icon(
                                    Icons.verified_user_outlined,
                                    color: AppColors.labelBlue,
                                    size: 25,
                                  ),
                                ),
                                const SizedBox(height: 24),

                                Text(
                                  AppStrings.whyVerify,
                                  style: GoogleFonts.newsreader(
                                    color: AppColors.textPrimary,
                                    fontSize: 24,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: -0.6,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: AppColors.silver.withValues(alpha: 0.8),
                                      fontSize: 16,
                                      height: 1.625,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Verification is not a hurdle, but a foundation. '
                                            'We use this step to ',
                                      ),
                                      TextSpan(
                                        text: 'anchor your data security',
                                        style: GoogleFonts.inter(
                                          color: AppColors.labelBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' and ensure your curated collection '
                                            'remains exclusively yours.',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Footer links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _footerLink('PRIVACY'),
                          const SizedBox(width: 32),
                          _footerLink('TERMS'),
                          const SizedBox(width: 32),
                          _footerLink('SECURITY'),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCountryPicker() {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setLocalState) => CountryPickerDialog(
          languageCode: 'en',
          style: PickerDialogStyle(
            backgroundColor: AppColors.scaffoldDark,
            countryCodeStyle: GoogleFonts.inter(
              color: AppColors.silver,
              fontSize: 14,
            ),
            countryNameStyle: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            listTileDivider: const SizedBox.shrink(),
            searchFieldPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            searchFieldInputDecoration: InputDecoration(
              hintText: 'Search Country',
              hintStyle: GoogleFonts.inter(
                color: AppColors.hintText.withValues(alpha: 0.5),
                fontSize: 16,
              ),
              filled: true,
              fillColor: AppColors.inputFill,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 16,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.silver,
                size: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: AppColors.inputBorderBlue.withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(
                  color: AppColors.labelBlue,
                  width: 1.5,
                ),
              ),
            ),
          ),
          filteredCountries: countries,
          searchText: 'Search country',
          countryList: countries,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            setState(() => _selectedCountry = country);
          },
        ),
      ),
    );
  }

  Widget _footerLink(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: AppColors.silver.withValues(alpha: 0.4),
        fontSize: 12,
        letterSpacing: 2.4,
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final isSelected = _selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = gender),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors.labelBlue.withValues(alpha: 0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isSelected
                      ? AppColors.labelBlue
                      : AppColors.subtleBorder.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: Text(
              gender,
              style: GoogleFonts.inter(
                color: isSelected ? AppColors.labelBlue : AppColors.silver,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
