///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2019-08-22 17:49
///
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RippleBackdropAnimatePage extends StatefulWidget {
  const RippleBackdropAnimatePage({
    Key? key,
    required this.child,
    this.childFade = false,
    this.duration = 300,
    this.blurRadius = 15.0,
    this.bottomButton,
    this.bottomHeight = kBottomNavigationBarHeight,
    this.bottomButtonRotate = true,
    this.bottomButtonRotateDegree = 45.0,
  }) : super(key: key);

  /// Child for page.
  final Widget child;

  /// When enabled, [child] will fade in and out with the animation.
  ///
  /// Defaults to `false`.
  final bool childFade;

  /// Animation's duration, including [Navigator.push] and [Navigator.pop].
  final int duration;

  /// Blur radius for the [BackdropFilter].
  final double blurRadius;

  /// The [Widget] for bottom of the page.
  final Widget? bottomButton;

  /// The height which [bottomButton] will occupy.
  ///
  /// Defaults to [kBottomNavigationBarHeight].
  final double bottomHeight;

  /// When enabled, [bottomButton] will rotate with the animation.
  ///
  /// Defaults to `true`.
  final bool bottomButtonRotate;

  /// The degree that [bottomButton] will rotate.
  ///
  /// Defaults to `45.0`.
  final double bottomButtonRotateDegree;

  @override
  _RippleBackdropAnimatePageState createState() =>
      _RippleBackdropAnimatePageState();
}

class _RippleBackdropAnimatePageState extends State<RippleBackdropAnimatePage>
    with TickerProviderStateMixin {
  /// Boolean to prevent duplicate pop.
  bool _popping = false;

  /// Animation.
  int get _animateDuration => widget.duration;

  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: _animateDuration),
    vsync: this,
  );
  late final Animation<double> _animation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback(
      (_) => backDropFilterAnimate(context, true),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double pythagoreanTheorem(double short, double long) {
    return math.sqrt(math.pow(short, 2) + math.pow(long, 2));
  }

  Future<void> backDropFilterAnimate(BuildContext context, bool forward) async {
    if (!forward) {
      _controller.stop();
    }
    if (forward) {
      await _controller.forward();
    } else {
      await _controller.reverse();
    }
  }

  Future<bool> willPop() async {
    await backDropFilterAnimate(context, false);
    if (!_popping) {
      _popping = true;
      await Future<void>.delayed(Duration(milliseconds: _animateDuration), () {
        Navigator.of(context).pop();
      });
    }
    return false;
  }

  Widget popButton() {
    Widget button = SizedBox(
      width: widget.bottomHeight,
      height: widget.bottomHeight,
      child: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child:
              widget.bottomButton ?? const Icon(Icons.add, color: Colors.grey),
          onTap: willPop,
        ),
      ),
    );
    if (widget.bottomButtonRotate) {
      final double rotateDegree =
          widget.bottomButtonRotateDegree * (math.pi / 180) * 3;
      button = Transform.rotate(
        angle: _animation.value * rotateDegree,
        child: button,
      );
    }
    button = AnimatedBuilder(
      animation: _animation,
      builder: (_, Widget? child) {
        return Opacity(opacity: _animation.value, child: child);
      },
      child: button,
    );
    return button;
  }

  Widget wrapper(BuildContext context, {required Widget child}) {
    final MediaQueryData m = MediaQuery.of(context);
    final Size s = m.size;
    final double r =
        pythagoreanTheorem(s.width, s.height * 2 + m.padding.top) / 2;
    final double topOverflow = r - s.height;
    final double horizontalOverflow = r - s.width;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          left: -horizontalOverflow,
          right: -horizontalOverflow,
          top: -topOverflow,
          bottom: -r,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: willPop,
            child: Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (_, __) {
                  final double _size = _animation.value * r * 2;
                  return SizedBox(
                    width: _size,
                    height: _size,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(r * 2),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: widget.blurRadius,
                          sigmaY: widget.blurRadius,
                        ),
                        child: const Center(child: Text('　')),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: topOverflow + 10),
            width: s.width,
            height: s.height,
            constraints: BoxConstraints(
              maxWidth: s.width,
              maxHeight: s.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: () {
                    if (widget.childFade) {
                      return AnimatedBuilder(
                        animation: _animation,
                        builder: (_, Widget? c) =>
                            Opacity(opacity: _animation.value, child: c),
                        child: child,
                      );
                    }
                    return Opacity(opacity: 1.0, child: child);
                  }(),
                ),
                popButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: willPop,
        child: wrapper(
          context,
          child: widget.child,
        ),
      ),
    );
  }
}
