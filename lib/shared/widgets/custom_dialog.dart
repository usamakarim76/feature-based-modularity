import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CustomDialog extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;
  final double blurIntensity;
  final List<BoxShadow>? shadows;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool barrierDismissible;
  final Color barrierColor;
  final double? width;
  final double? height;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isScrollable;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool showCloseButton;
  final Widget? closeButtonIcon;
  final Color? closeButtonColor;
  final double closeButtonSize;

  const CustomDialog({
    super.key,
    required this.child,
    this.borderRadius = 12.0,
    this.backgroundColor = Colors.white,
    this.blurIntensity = 10.0,
    this.shadows,
    this.padding = const EdgeInsets.all(20.0),
    this.margin = const EdgeInsets.all(20.0),
    this.barrierDismissible = true,
    this.barrierColor = Colors.transparent,
    this.width,
    this.height,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isScrollable = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.showCloseButton = true,
    this.closeButtonIcon,
    this.closeButtonColor,
    this.closeButtonSize = 24.0,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();

  // Static method to show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double borderRadius = 12.0,
    Color backgroundColor = Colors.white,
    double blurIntensity = 10.0,
    List<BoxShadow>? shadows,
    EdgeInsets? padding = const EdgeInsets.all(20.0),
    EdgeInsets? margin = const EdgeInsets.all(20.0),
    bool barrierDismissible = false,
    Color barrierColor = Colors.transparent,
    double? width,
    double? height,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    bool isScrollable = false,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
    bool showCloseButton = true,
    Widget? closeButtonIcon,
    Color? closeButtonColor,
    double closeButtonSize = 24.0,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) => CustomDialog(
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        blurIntensity: blurIntensity,
        shadows: shadows,
        padding: padding,
        margin: margin,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        width: width,
        height: height,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        isScrollable: isScrollable,
        animationDuration: animationDuration,
        animationCurve: animationCurve,
        showCloseButton: showCloseButton,
        closeButtonIcon: closeButtonIcon,
        closeButtonColor: closeButtonColor,
        closeButtonSize: closeButtonSize,
        child: child,
      ),
    );
  }
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          children: [
            // Blur background with tap handling
            Positioned.fill(
              child: GestureDetector(
                onTap: widget.barrierDismissible
                    ? () => Navigator.of(context).pop()
                    : null,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.blurIntensity,
                    sigmaY: widget.blurIntensity,
                  ),
                  child: Container(
                    color: AppColors.black.withValues(alpha: 0.1),
                  ),
                ),
              ),
            ),
            // Dialog content
            Center(
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: GestureDetector(
                    onTap:
                        () {}, // Prevent tap from going through to background
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      margin: widget.margin,
                      constraints: widget.width == null && widget.height == null
                          ? const BoxConstraints(
                              minWidth: 200,
                              maxWidth: 400,
                              minHeight: 100,
                            )
                          : null,
                      child: Material(
                        color: Colors.transparent,
                        child: IntrinsicHeight(
                          child: IntrinsicWidth(
                            child: Container(
                              decoration: BoxDecoration(
                                color: widget.backgroundColor,
                                borderRadius: BorderRadius.circular(
                                  widget.borderRadius,
                                ),
                                boxShadow: widget.shadows ?? _defaultShadows(),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  widget.borderRadius,
                                ),
                                child: Stack(
                                  children: [
                                    // Main content area
                                    Container(
                                      width: double.infinity,
                                      padding: widget.showCloseButton
                                          ? EdgeInsets.only(
                                              top:
                                                  (widget.padding?.top ?? 20) +
                                                  30,
                                              left: widget.padding?.left ?? 20,
                                              right:
                                                  widget.padding?.right ?? 20,
                                              bottom:
                                                  widget.padding?.bottom ?? 20,
                                            )
                                          : widget.padding,
                                      child: widget.isScrollable
                                          ? SingleChildScrollView(
                                              child: widget.child,
                                            )
                                          : widget.child,
                                    ),
                                    // Close button
                                    if (widget.showCloseButton)
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: AppColors.black.withValues(
                                                alpha: 0.1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child:
                                                widget.closeButtonIcon ??
                                                Icon(
                                                  Icons.close,
                                                  size: widget.closeButtonSize,
                                                  color:
                                                      widget.closeButtonColor ??
                                                      Colors.grey[600],
                                                ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<BoxShadow> _defaultShadows() {
    return [
      BoxShadow(
        color: AppColors.black.withValues(alpha: 0.1),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
      BoxShadow(
        color: AppColors.black.withValues(alpha: 0.05),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ];
  }
}

// Example usage widget
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Dialog Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showSimpleDialog(context),
              child: const Text('Show Simple Dialog'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showCustomDialog(context),
              child: const Text('Show Custom Styled Dialog'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showNoCloseButtonDialog(context),
              child: const Text('Show Dialog Without Close Button'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showScrollableDialog(context),
              child: const Text('Show Dialog Without Close Button'),
            ),
          ],
        ),
      ),
    );
  }

  void _showNoCloseButtonDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      showCloseButton: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock, size: 48, color: Colors.orange),
          const SizedBox(height: 16),
          const Text(
            'No Close Button',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'This dialog has no close button. You can still close it by tapping outside or using the buttons below.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close Dialog'),
          ),
        ],
      ),
    );
  }

  void _showSimpleDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info, size: 48, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'Simple Dialog',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'This is a simple dialog with default styling and a close button.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      backgroundColor: Colors.grey[900]!,
      borderRadius: 20,
      blurIntensity: 15,
      closeButtonColor: Colors.white,
      shadows: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          const Text(
            'Custom Styled Dialog',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'This dialog has custom colors, shadows, styling, and a custom close button.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Awesome!'),
            ),
          ),
        ],
      ),
    );
  }

  void _showScrollableDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      height: 400,
      isScrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Scrollable Dialog',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            20,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Item ${index + 1}: This is a scrollable content item.',
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
