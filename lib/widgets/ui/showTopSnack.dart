import 'package:flutter/material.dart';

class TapBounceContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  TapBounceContainer({
    required this.child,
    this.onTap,
  });

  @override
  _TapBounceContainerState createState() => _TapBounceContainerState();
}

class _TapBounceContainerState extends State<TapBounceContainer>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  final animationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
      lowerBound: 0.0,
      upperBound: 0.04,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onPanEnd: _onPanEnd,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) async {
    await _closeSnackBar();
  }

  void _onPanEnd(DragEndDetails details) async {
    await _closeSnackBar();
  }

  Future _closeSnackBar() async {
    _controller.reverse();
    await Future.delayed(animationDuration);
    widget.onTap?.call();
  }
}

void showTopSnackBar(
  BuildContext context,
  Widget child, {
  Duration showOutAnimationDuration = const Duration(milliseconds: 1200),
  Duration hideOutAnimationDuration = const Duration(milliseconds: 550),
  Duration displayDuration = const Duration(milliseconds: 3000),
  double additionalTopPadding = 16.0,
  VoidCallback? onTap,
  OverlayState? overlayState,
}) async {
  overlayState ??= Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) {
      return TopSnackBar(
        child: child,
        onDismissed: () => overlayEntry.remove(),
        showOutAnimationDuration: showOutAnimationDuration,
        hideOutAnimationDuration: hideOutAnimationDuration,
        displayDuration: displayDuration,
        additionalTopPadding: additionalTopPadding,
        onTap: onTap,
      );
    },
  );

  overlayState?.insert(overlayEntry);
}

/// Widget that controls all animations
class TopSnackBar extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final showOutAnimationDuration;
  final hideOutAnimationDuration;
  final displayDuration;
  final additionalTopPadding;
  final VoidCallback? onTap;

  TopSnackBar({
    Key? key,
    required this.child,
    required this.onDismissed,
    required this.showOutAnimationDuration,
    required this.hideOutAnimationDuration,
    required this.displayDuration,
    required this.additionalTopPadding,
    this.onTap,
  }) : super(key: key);

  @override
  _TopSnackBarState createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<TopSnackBar>
    with SingleTickerProviderStateMixin {
  late Animation offsetAnimation;
  late AnimationController animationController;
  double? topPosition;

  @override
  void initState() {
    topPosition = widget.additionalTopPadding;
    _setupAndStartAnimation();
    super.initState();
  }

  void _setupAndStartAnimation() async {
    animationController = AnimationController(
      vsync: this,
      duration: widget.showOutAnimationDuration,
      reverseDuration: widget.hideOutAnimationDuration,
    );

    Tween<Offset> offsetTween = Tween<Offset>(
      begin: Offset(0.0, -1.0),
      end: Offset(0.0, 0.0),
    );

    offsetAnimation = offsetTween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.linearToEaseOut,
      ),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(widget.displayDuration);
          animationController.reverse();
          if (mounted) {
            setState(() {
              topPosition = 0;
            });
          }
        }

        if (status == AnimationStatus.dismissed) {
          widget.onDismissed.call();
        }
      });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget.hideOutAnimationDuration * 1.5,
      curve: Curves.linearToEaseOut,
      top: topPosition,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: offsetAnimation as Animation<Offset>,
        child: SafeArea(
          child: TapBounceContainer(
            onTap: () {
              widget.onTap?.call();
              animationController.reverse();
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
