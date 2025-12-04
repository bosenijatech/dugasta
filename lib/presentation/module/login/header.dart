import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.075),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFFFFB133))),
          ),
        ),
        Positioned(
          top: 170,
          left: -5,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.075),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFFFFB133))),
          ),
        ),
        Positioned(
          top: 190,
          left: 20,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.075),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFFFFB133))),
          ),
        ),
        Positioned(
            top: 100,
            left: 20,
            child: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Quicksand',
                    fontSize: 48,
                    color: Colors.white))),
      ],
    );
  }
}
