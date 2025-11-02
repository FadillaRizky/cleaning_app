import 'package:flutter/material.dart';

class SafeMarqueeText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double maxWidth;
  final double velocity; // pixel per second
  final Duration pauseDuration; // jeda di ujung

  const SafeMarqueeText({
    super.key,
    required this.text,
    required this.maxWidth,
    this.style,
    this.velocity = 50,
    this.pauseDuration = const Duration(seconds: 1),
  });

  @override
  State<SafeMarqueeText> createState() => _SafeMarqueeTextState();
}

class _SafeMarqueeTextState extends State<SafeMarqueeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double textWidth = 0;
  bool needsScroll = false;
  static const double extraPadding = 5; // pastikan huruf terakhir terlihat

  @override
  void initState() {
    super.initState();
    // Controller hanya dibuat sekali
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation(double maxOffset) {
    final durationSeconds = maxOffset / widget.velocity;
    _controller.duration = Duration(milliseconds: (durationSeconds * 1000).toInt());

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(widget.pauseDuration); // jeda sebelum reset
        if (mounted) {
          _controller.reset();
          _controller.forward();
        }
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final containerWidth = constraints.maxWidth;

      // Hitung lebar teks
      final textPainter = TextPainter(
        text: TextSpan(text: widget.text, style: widget.style),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();

      textWidth = textPainter.width;
      needsScroll = textWidth > containerWidth;

      if (needsScroll && !_controller.isAnimating) {
        final maxOffset = (textWidth - containerWidth) + extraPadding;
        _startAnimation(maxOffset);
      }

      if (!needsScroll) {
        return Text(
          widget.text,
          style: widget.style,
          overflow: TextOverflow.ellipsis,
        );
      }

      return ClipRect(
        child: SizedBox(
          width: containerWidth,
          height: (widget.style?.fontSize ?? 14) * 1.5,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final maxOffset = (textWidth - containerWidth) + extraPadding;
              final offset = _controller.value * maxOffset;
              return Transform.translate(
                offset: Offset(-offset, 0),
                child: child,
              );
            },
            child: Text(
              widget.text,
              style: widget.style,
              softWrap: false,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      );
    });
  }
}
