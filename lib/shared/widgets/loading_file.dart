import 'dart:ui';

import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/core/extensions/responsive_extensions.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';

class CustomLoadingPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokeWidth;

  CustomLoadingPainter({
    required this.progress,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.strokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;

    // Background circle
    final backgroundPaint = Paint()
      ..color = secondaryColor.withOpacity(0.3)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    // Inner rotating dots
    for (int i = 0; i < 3; i++) {
      final angle = (progress * 2 * math.pi) + (i * 2 * math.pi / 3);
      final dotRadius = radius * 0.3;
      final dotCenter = Offset(
        center.dx + dotRadius * math.cos(angle),
        center.dy + dotRadius * math.sin(angle),
      );

      final dotPaint = Paint()
        ..color = primaryColor.withOpacity(0.7 - (i * 0.2))
        ..style = PaintingStyle.fill;

      canvas.drawCircle(dotCenter, 3.0 - (i * 0.5), dotPaint);
    }

    // Central pulsing circle
    final pulseRadius = 8.0 + (math.sin(progress * 4 * math.pi) * 3.0);
    final pulsePaint = Paint()
      ..color = primaryColor.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, pulseRadius, pulsePaint);
  }

  @override
  bool shouldRepaint(CustomLoadingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class AnimatedLoadingIndicator extends StatefulWidget {
  final double size;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokeWidth;
  final Duration duration;

  const AnimatedLoadingIndicator({
    Key? key,
    this.size = 60.0,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.strokeWidth = 4.0,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  State<AnimatedLoadingIndicator> createState() =>
      _AnimatedLoadingIndicatorState();
}

class _AnimatedLoadingIndicatorState extends State<AnimatedLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: CustomLoadingPainter(
            progress: _animation.value,
            primaryColor: widget.primaryColor,
            secondaryColor: widget.secondaryColor,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

class LoadingOverlayWidget<T extends ChangeNotifier> extends StatelessWidget {
  final Widget child;
  final T? provider;
  final bool Function(T)? isLoadingSelector;
  final String Function(T)? messageSelector;
  final bool? isLoading;
  final String? loadingMessage;
  final Color backgroundColor;
  final Color loadingColor;
  final double loadingSize;

  const LoadingOverlayWidget({
    super.key,
    required this.child,
    this.provider,
    this.isLoadingSelector,
    this.messageSelector,
    this.isLoading,
    this.loadingMessage,
    this.backgroundColor = AppColors.transparent,
    this.loadingColor = AppColors.primary,
    this.loadingSize = 90,
  });

  @override
  Widget build(BuildContext context) {
    if (provider != null) {
      return Consumer<T>(
        builder: (context, providerInstance, _) {
          final showLoading =
              isLoadingSelector?.call(providerInstance) ?? false;
          final message =
              messageSelector?.call(providerInstance) ?? 'Loading...';

          return _buildWithOverlay(context, showLoading, message);
        },
      );
    } else {
      return _buildWithOverlay(
        context,
        isLoading ?? false,
        loadingMessage ?? 'Loading...',
      );
    }
  }

  Widget _buildWithOverlay(
    BuildContext context,
    bool showLoading,
    String message,
  ) {
    return Stack(
      children: [
        child,
        if (showLoading)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.1),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20.0,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedLoadingIndicator(
                            size: loadingSize.w,
                            primaryColor: loadingColor,
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            message,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
