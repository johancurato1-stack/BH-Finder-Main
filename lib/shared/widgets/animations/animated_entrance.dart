import 'dart:async';

import 'package:flutter/material.dart';

//============================================================================
//! ANIMATED ENTRANCE
//============================================================================
//
// A reusable entrance animation used throughout the application.
//
// Features:
// • Fade
// • Slide (Custom Direction)
// • Slight Scale
// • Automatic stagger timing
//
// Example:
//
// AnimatedEntrance(
//   order: 0,
//   child: Header(),
// )
//
// AnimatedEntrance(
//   order: 1,
//   beginOffset: const Offset(-0.25, 0),
//   child: PropertyCard(),
// )
//
//============================================================================

class AnimatedEntrance extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AnimatedEntrance({
    super.key,
    required this.child,
    required this.order,
    this.duration = const Duration(milliseconds: 500),
    this.beginOffset = const Offset(0, .12),
  });

  //============================================================================
  //! ANIMATION
  //============================================================================

  static const int stagger = 80;

  final int order;

  final Duration duration;

  final Offset beginOffset;

  //============================================================================
  //! CHILD
  //============================================================================

  final Widget child;

  @override
  State<AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<AnimatedEntrance>
    with SingleTickerProviderStateMixin {
  //============================================================================
  //! CONTROLLER
  //============================================================================

  late final AnimationController _controller;

  late final Animation<double> _opacityAnimation;

  late final Animation<double> _scaleAnimation;

  late final Animation<Offset> _slideAnimation;

  Timer? _timer;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(curve);

    _scaleAnimation = Tween<double>(begin: .97, end: 1).animate(curve);

    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(curve);

    _timer = Timer(
      Duration(milliseconds: widget.order * AnimatedEntrance.stagger),
      () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();

    super.dispose();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,

      child: SlideTransition(
        position: _slideAnimation,

        child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
      ),
    );
  }
}
