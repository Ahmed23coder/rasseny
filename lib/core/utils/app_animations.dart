import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────
// PRESS SCALE ANIMATION
// ─────────────────────────────────────────────────────────────────

/// Wraps any widget with a scale-on-press effect.
///
/// ```dart
/// PressScaleAnimation(
///   onTap: () {},
///   child: MyButton(),
/// )
/// ```
class PressScaleAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleOnPress;
  final Duration duration;

  const PressScaleAnimation({
    super.key,
    required this.child,
    this.onTap,
    this.scaleOnPress = 0.95,
    this.duration = const Duration(milliseconds: 120),
  });

  @override
  State<PressScaleAnimation> createState() => _PressScaleAnimationState();
}

class _PressScaleAnimationState extends State<PressScaleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _scale = Tween(
      begin: 1.0,
      end: widget.scaleOnPress,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _down(TapDownDetails _) => _ctrl.forward();
  void _up(TapUpDetails _) {
    _ctrl.reverse();
    widget.onTap?.call();
  }

  void _cancel() => _ctrl.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _down,
      onTapUp: _up,
      onTapCancel: _cancel,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// PAGE ENTRANCE ANIMATION  (fade + slide-up)
// ─────────────────────────────────────────────────────────────────

class PageEntranceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double slideOffset;

  const PageEntranceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.slideOffset = 30.0,
  });

  @override
  State<PageEntranceAnimation> createState() => _PageEntranceAnimationState();
}

class _PageEntranceAnimationState extends State<PageEntranceAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(
      begin: Offset(0, widget.slideOffset),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    if (widget.delay == Duration.zero) {
      _ctrl.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) => Opacity(
        opacity: _fade.value,
        child: Transform.translate(offset: _slide.value, child: child),
      ),
      child: widget.child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// STAGGERED LIST ANIMATION
// ─────────────────────────────────────────────────────────────────

/// Animates a list of children with sequential entrance delays.
class StaggeredListAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration itemDelay;
  final Duration itemDuration;
  final double slideOffset;
  final CrossAxisAlignment crossAxisAlignment;

  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 60),
    this.itemDuration = const Duration(milliseconds: 400),
    this.slideOffset = 20.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: List.generate(children.length, (i) {
        return PageEntranceAnimation(
          delay: itemDelay * i,
          duration: itemDuration,
          slideOffset: slideOffset,
          child: children[i],
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// PULSE ANIMATION (Continuous breathing effect)
// ─────────────────────────────────────────────────────────────────

class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scaleLowerBound;
  final double scaleUpperBound;

  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.scaleLowerBound = 0.95,
    this.scaleUpperBound = 1.05,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _scale = Tween(
      begin: widget.scaleLowerBound,
      end: widget.scaleUpperBound,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}
