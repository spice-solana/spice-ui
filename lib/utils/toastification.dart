import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Toastification {
  static soon(BuildContext context, String title, {int? duration}) => showToastWidget(
      Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 16.0),
        child: Container(
          height: 55.0,
          width: 314.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(color: Colors.grey.withOpacity(0.2))),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 16.0),
              Text(title, style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color, 
                fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily, 
                fontSize: 12.0)),
            ],
          ),
        ),
      ),
      position: const ToastPosition(align: Alignment.bottomRight),
      duration: Duration(seconds: duration ?? 3),
      );
}
