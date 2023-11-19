import 'package:flutter/material.dart';

class CustomBottonWidget extends StatelessWidget {
  const CustomBottonWidget({super.key, required this.title, required this.width, required this.color, required this.callback});
  final String title;
  final double width;
  final Color color;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  SizedBox(
        width: width,
        height: size.height * 0.06,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:color),
            onPressed: callback,
            child: Text(
              title,
              style:const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700)
            )),
    
    );
  }
}
