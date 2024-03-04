import 'package:flutter/material.dart';

class CustomSkeleton extends StatefulWidget {
  final double height;
  final double width;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  const CustomSkeleton({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  @override
  State<CustomSkeleton> createState() => _CustomSkeletonState();
}

class _CustomSkeletonState extends State<CustomSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 1500,
      ),
      vsync: this,
    );

    gradientPosition = Tween<double>(begin: -3, end: 50).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      } else if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        shape: widget.shape,
        borderRadius: widget.borderRadius,
        gradient: LinearGradient(
          begin: Alignment(
            gradientPosition.value,
            0,
          ),
          end: const Alignment(-10, 0),
          colors: const [
            Colors.black12,
            Colors.black12,
            Colors.black26,
            Colors.black12,
            Colors.black12,
          ],
        ),
      ),
    );
  }
}
