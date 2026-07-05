class Endpoints {
  static const base = 'http://10.10.10.3:5000/api';

  /// Authentication
  static const String register = '/auth/register/';
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh_token/';

  /// OTP
  static const String sendOtp = '/otp/send_otp/';
  static const String verifyOtp = '/otp/verify_otp/';
  static const String resendOtp = '/otp/resend_otp/';
}
