import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

/// Simple intro screen: the "Grammix" title fades and scales in,
/// a thin accent underline draws itself, then the app hands off
/// to the chat screen with a soft fade + rise transition.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _titleFade;
  late final Animation<double> _titleScale;
  late final Animation<double> _underline;
  late final Animation<double> _taglineFade;

  Timer? _navTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _titleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );

    _titleScale = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _underline = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.8, curve: Curves.easeOutCubic),
    );

    _taglineFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    _controller.forward();
    _navTimer = Timer(const Duration(milliseconds: 2100), _goToChat);
  }

  void _goToChat() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 550),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ChatScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fade = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          final slide = Tween<Offset>(
            begin: const Offset(0, 0.03),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: _titleFade.value,
                  child: Transform.scale(
                    scale: _titleScale.value,
                    child: const Text(
                      'Grammix',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                ClipRect(
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: _underline.value,
                    child: const SizedBox(
                      width: 120,
                      height: 2,
                      child: ColoredBox(color: AppColors.accent),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Opacity(
                  opacity: _taglineFade.value,
                  child: const Text(
                    'grammar, made clear',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
