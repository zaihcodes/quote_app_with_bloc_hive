import 'package:flutter/material.dart';

GestureDetector builtRandomButton(
    {required BuildContext context, required Function() func}) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(2, 2),
            // color: Colors.white.withOpacity(0.1),
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
          ),
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(-2, -2),
            // color: Colors.white.withOpacity(0.2),
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
          )
        ],
      ),
      child: const Center(
          child: Icon(
        Icons.refresh,
        color: Colors.white,
      )),
    ),
  );
}
