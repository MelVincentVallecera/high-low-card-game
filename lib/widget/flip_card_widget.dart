import 'package:flutter/material.dart';
import 'dart:math';

class FlipCardController {
  FlipCardWidgetState? _state;

  Future flipCard() async => _state?.flipCard();
}

class FlipCardWidget extends StatefulWidget {
  final FlipCardController controller;
  final Image front;
  final Image back;

  const FlipCardWidget({
    required this.controller,
    required this.front,
    required this.back,
    Key? key,
  }) : super(key: key);

  @override
  FlipCardWidgetState createState() => FlipCardWidgetState();
}

class FlipCardWidgetState extends State<FlipCardWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isBack = true;
  double anglePlus = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((__) {
      precacheImage(widget.front.image, context);
      precacheImage(widget.back.image, context);
    });

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    widget.controller._state = this;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  Future flipCard() async {
    if (controller.isAnimating) return;
    isBack = !isBack;

    await controller.forward(from: 0).then((value) => anglePlus = pi);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double angle = controller.value * -pi;
          if (isBack) angle += anglePlus;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isBackImage(angle.abs())
                ? widget.back
                : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: widget.front,
                  ),
          );
        },
      );
  bool isBackImage(double angle) {
    final degrees90 = pi / 2;
    final degrees270 = 3 * pi / 2;

    return angle <= degrees90 || angle >= degrees270;
  }
}
