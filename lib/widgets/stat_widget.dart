import 'package:flutter/material.dart';
import 'package:spice_ui/utils/extensions.dart';


class StatWidget extends StatelessWidget {
  final String title;
  final String data;
  final Widget? widget;
  const StatWidget({super.key, required this.title, required this.data, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.0,
        width: 280.0,
        //color: title == "Earned" ? Colors.greenAccent : null,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.5))),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(data.formatNumWithCommas(), style: const TextStyle(fontSize: 18.0)),
                
                widget != null ? Row(
                  children: [
                    const SizedBox(width: 8.0),
                    widget!
                  ],
                ) : const SizedBox()
              ],
            )
          ],
        ));
  }
}
