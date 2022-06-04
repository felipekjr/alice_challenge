import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Widget child;
  const ListItem({ Key? key, required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: .5)
        )
      ),
      child: child,
    );
  }
}