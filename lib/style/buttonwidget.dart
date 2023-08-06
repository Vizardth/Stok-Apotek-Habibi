import 'package:apotek_habibi/style/color.dart';
import 'package:flutter/material.dart';

class ButtonText extends StatefulWidget {
  final String textbutton;
  final Color colorbutton;
  final Color colortext;
  final double sizetext;
  final Size sizebutton;
  final void Function() onpress;
  const ButtonText({super.key, required this.textbutton, required this.colorbutton, required this.colortext, required this.sizetext, required this.sizebutton, required this.onpress});

  @override
  State<ButtonText> createState() => _ButtonTextState();
}

class _ButtonTextState extends State<ButtonText> {
  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton(
      child: Text(widget.textbutton),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        textStyle: TextStyle(
            color: widget.colortext,
            fontSize: widget.sizetext,
            fontWeight: FontWeight.w600
        ),
        minimumSize: widget.sizebutton,
        backgroundColor: widget.colorbutton,
      ),
      onPressed: widget.onpress,
    );
  }
}

class ButtonIcon extends StatefulWidget {
  final IconData iconbutton;
  final Color colorbutton;
  final Color coloricon;
  final double sizebutton;
  final double sizeicon;
  final double radiusbutton;
  final void Function() ontap;
  const ButtonIcon({super.key, required this.iconbutton, required this.colorbutton, required this.sizebutton, required this.ontap, required this.coloricon, required this.sizeicon, required this.radiusbutton});

  @override
  State<ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<ButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        child: Icon(widget.iconbutton,color:widget.coloricon,size:widget.sizeicon,),
        width: widget.sizebutton,
        height: widget.sizebutton,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radiusbutton),
          color: widget.colorbutton,
        ),

      ),
    );
  }
}

