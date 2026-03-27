/// Centralized UI string constants for the Rasseny application.
abstract final class AppStrings {
  static const String appName = 'RASSENY';
  static const String appSubtitle = 'THE ARCHITECTURAL NEWSROOM';
  static const String logoPath = 'assets/images/logo.svg';

  // ── Onboarding ──
  static const String next = 'NEXT';
  static const String skip = 'SKIP';
  static const String getStarted = 'GET STARTED';

  // ── Auth – Login ──
  static const String welcomeBack = 'Welcome Back';
  static const String loginSubtitle =
      'Please enter your credentials to access\nyour library.';
  static const String emailLabel = 'EMAIL';
  static const String passwordLabel = 'PASSWORD';
  static const String emailHint = 'curator@rasseny.com';
  static const String passwordHint = '••••••••';
  static const String loginButton = 'Login';
  static const String forgotPassword = 'Forgot Password?';
  static const String orContinueWith = 'Or continue with';
  static const String github = 'GITHUB';
  static const String newHere = 'New here? ';
  static const String createAccount = 'Create Account';

  // ── Auth – Sign Up ──
  static const String brandName = 'Rasseny';
  static const String obsidianCurator = 'The Obsidian Curator';
  static const String createYourAccount = 'Create your account';
  static const String fullNameLabel = 'FULL NAME';
  static const String fullNameHint = 'Archibald Sterling';
  static const String phoneNumberLabel = 'PHONE NUMBER';
  static const String phoneNumberHint = '12 345 6789';
  static const String genderLabel = 'GENDER';
  static const String confirmPasswordLabel = 'CONFIRM PASSWORD';
  static const String beginJourney = 'Begin Journey';
  static const String alreadyMember = 'Already a member? ';
  static const String signIn = 'Sign in';
  static const String whyVerify = 'Why verify your email?';
  static const String whyVerifyBody =
      'Verification is not a hurdle, but a foundation. '
      'We use this step to anchor your data security and '
      'ensure your curated collection remains exclusively yours.';
  static const String securityStrength = 'SECURITY STRENGTH';

  // ── Auth – OTP ──
  static const String secureYourAnchor = 'Secure your\nAnchor';
  static const String otpSubtitle =
      'We sent a code to your email. Please\n'
      'enter the four-digit verification pin to\nproceed.';
  static const String verifyIdentity = 'VERIFY IDENTITY';
  static const String resendCodeIn = 'Resend Code in ';
  static const String didntReceive = "Didn't receive the email?";
  static const String tryAnotherWay = 'Try another way';

  // ── Auth – Forgot Password ──
  static const String lostYourHarbor = 'Lost your harbor?';
  static const String forgotSubtitle =
      'Enter your email to receive a\nreset code.';
  static const String registryEmail = 'REGISTRY EMAIL';
  static const String emailPlaceholder = 'email@example.com';
  static const String sendResetLink = 'SEND RESET LINK';
  static const String returnToLogin = 'Return to Login';
  static const String contactSupport = 'Contact Support';

  // ── Auth – Reset Password ──
  static const String securityUpdate = 'Security Update';
  static const String setNewCredentials = 'Set New Credentials';
  static const String resetSubtitle =
      'Your security is our priority. Choose\n'
      'a password that reflects the depth\nof your account.';
  static const String newPasswordLabel = 'NEW PASSWORD';
  static const String confirmResetPasswordLabel = 'CONFIRM NEW PASSWORD';
  static const String confirmNewPassword = 'CONFIRM NEW\nPASSWORD';
  static const String securityLevel = 'SECURITY LEVEL';
  static const String returnToPortal = 'RETURN TO IDENTITY PORTAL';

  // ── Auth – Success ──
  static const String authVerified = 'AUTHENTICATION VERIFIED';
  static const String connectionAnchored = 'Connection\nAnchored.';
  static const String successSubtitle =
      'Welcome to Rasseny. Your\ncurated perspective is now ready\nfor exploration.';
  static const String securedEncryption = 'Secured with High-End\nEncryption';

  // ── Auth – Error ──
  static const String invalidEmail = 'Invalid Email Format';
  static const String invalidCredentials = 'Invalid credentials';
}
