import 'package:go_router/go_router.dart';
import 'package:shortfreq/features/auth/presentation/auth_navigator.dart';
import 'package:shortfreq/features/auth/presentation/login/login_screen.dart';
import 'package:shortfreq/features/auth/presentation/signup/otp_verification_screen.dart';
import 'package:shortfreq/features/auth/presentation/signup/signup_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthNavigator(),
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen()
    ),

    GoRoute(
      path: '/signup',
      builder: (context, state) => SignupScreen()
    ),

    GoRoute(
      path: '/verify-otp',
      builder: (context, state) => OtpVerificationScreen(),
    ),
  ]
);