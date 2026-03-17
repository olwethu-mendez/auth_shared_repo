import 'package:flutter/material.dart';

class SidelinedHeader extends StatelessWidget {
  const SidelinedHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10,),
        Expanded(child: Divider(
          color:  Colors.grey,
          thickness: 2,
        )),
        SizedBox(width: 7,),
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 7,),
        Expanded(child: Divider(
          color:  Colors.grey,
          thickness: 2,)),
        SizedBox(width: 10,),
      ],
    );
  }
}
