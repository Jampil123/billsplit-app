import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInLogo;
  late Animation<double> _fadeInText;
  late Animation<double> _progressWidth;

  double _progressValue = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeInLogo = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    _fadeInText = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _progressWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    // Start animation
    _animationController.forward();

    // Simulate progress bar
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_progressValue < 1.0) {
        setState(() {
          _progressValue += 0.01;
        });
      } else {
        timer.cancel();
        // Navigate to home screen after splash
        Future.delayed(const Duration(milliseconds: 500), () {
          _navigateToHome();
        });
      }
    });
  }

  void _navigateToHome() {
    // Replace with your actual home screen
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF), // surface color
      body: Stack(
        children: [
          // Decorative Background Elements
          _buildBackgroundEffects(),

          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  FadeTransition(
                    opacity: _fadeInLogo,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback if logo not found
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF006C49,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.receipt_long,
                              size: 60,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Tagline
                  FadeTransition(
                    opacity: _fadeInText,
                    child: Column(
                      children: [
                        Text(
                          'Easy Hati, Easy Bayad.',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF545F73), // secondary color
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Progress Bar
                        Container(
                          width: 128,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCE9FF), // surface-container
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: AnimatedBuilder(
                            animation: _progressWidth,
                            builder: (context, child) {
                              return FractionallySizedBox(
                                widthFactor: _progressValue,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF10B981,
                                    ), // primary-container
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Footer
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeInText,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 14,
                        color: Color(0xFF6C7A71),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Secure FinTech Solutions',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6C7A71), // outline color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundEffects() {
    return Stack(
      children: [
        // Top right blur
        Positioned(
          top: -MediaQuery.of(context).size.height * 0.1,
          right: -MediaQuery.of(context).size.width * 0.1,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: const Color(0xFF006C49).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        // Bottom left blur
        Positioned(
          bottom: -MediaQuery.of(context).size.height * 0.1,
          left: -MediaQuery.of(context).size.width * 0.1,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: const Color(0xFFD5E0F8).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
