import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextExtension on String {
  Text style({
    double? fontSize,
    Color color = Colors.black,
    bool isBold = false,
  }) => Text(
    this,
    style: GoogleFonts.gabarito(
      fontSize: fontSize,
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}

extension WidgetExts on Widget {
  Widget centralize() => Center(child: this);
  Widget padX(double size) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: size), child: this);
     Widget padY(double size) =>
      Padding(padding: EdgeInsets.symmetric(vertical: size), child: this);
   Widget padAll(double size) =>
      Padding(padding: EdgeInsets.all(size), child: this);
}

extension NavExts on BuildContext {
  void push(Widget screen) =>
      Navigator.push(this, MaterialPageRoute(builder: (ctx) => screen));
  void pop() => Navigator.pop(this);
  void replace(Widget screen) =>  Navigator.pushReplacement(this, MaterialPageRoute(builder: (ctx) => screen));
}
