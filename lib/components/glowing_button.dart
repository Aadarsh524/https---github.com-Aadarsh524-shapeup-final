import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  final Color color1;
  final Color color2;
  final String buttonTitle;
  final VoidCallback onTap;
  const GlowingButton(
      {Key? key,
      required this.color1,
      required this.color2,
      required this.onTap,
      required this.buttonTitle})
      : super(key: key);

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  var glowing = true;
  var scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
          transform: Matrix4.identity()..scale(scale),
          duration: const Duration(milliseconds: 200),
          height: 48,
          width: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                colors: [
                  widget.color1,
                  widget.color2,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color1.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 16,
                  offset: const Offset(-8, 0),
                ),
                BoxShadow(
                  color: widget.color2.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 16,
                  offset: const Offset(8, 0),
                ),
                BoxShadow(
                  color: widget.color1.withOpacity(0.2),
                  spreadRadius: 16,
                  blurRadius: 32,
                  offset: const Offset(-8, 0),
                ),
                BoxShadow(
                  color: widget.color2.withOpacity(0.2),
                  spreadRadius: 16,
                  blurRadius: 32,
                  offset: const Offset(8, 0),
                )
              ]),
          child: Center(
            child: Text(
              widget.buttonTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}
