import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// FIXA branded loading indicator — a spinning wrench inside a
/// pulsing amber ring. Use everywhere instead of [CircularProgressIndicator].
enum FixaLoadingSize { small, medium, large }

class FixaLoadingIndicator extends StatefulWidget {
  const FixaLoadingIndicator({
    super.key,
    this.size = FixaLoadingSize.medium,
    this.color = AppColors.primary,
  });

  final FixaLoadingSize size;
  final Color color;

  double get _diameter {
    switch (size) {
      case FixaLoadingSize.small:
        return 24;
      case FixaLoadingSize.medium:
        return 48;
      case FixaLoadingSize.large:
        return 80;
    }
  }

  @override
  State<FixaLoadingIndicator> createState() => _FixaLoadingIndicatorState();
}

class _FixaLoadingIndicatorState extends State<FixaLoadingIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _spinController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _spinController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double diameter = widget._diameter;
    final double iconSize = diameter * 0.5;

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Pulsing amber ring
          AnimatedBuilder(
            animation: _pulseController,
            builder: (BuildContext context, Widget? child) {
              final double t = _pulseController.value;
              return Container(
                width: diameter * (0.85 + 0.15 * t),
                height: diameter * (0.85 + 0.15 * t),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 0.15 + 0.15 * (1 - t)),
                ),
              );
            },
          ),
          // Inner solid amber disc
          Container(
            width: diameter * 0.65,
            height: diameter * 0.65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withValues(alpha: 0.18),
            ),
          ),
          // Spinning wrench
          RotationTransition(
            turns: _spinController,
            child: Icon(
              Icons.build_rounded,
              size: iconSize,
              color: widget.color,
            ),
          ),
        ],
      ),
    );
  }
}
