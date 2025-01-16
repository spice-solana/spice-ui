import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:url_launcher/url_launcher.dart';

class Toastification {
  static soon(BuildContext context, String title, {int? duration}) => showToastWidget(
    context: context,
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

  static processing(BuildContext context, String title, {int? duration}) => showToastWidget(
      handleTouch: true,
      context: context,
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
              const SizedBox(height: 25.0, width: 25.0, child: CircularProgressIndicator(strokeWidth: 1.0, color: Color(0xFF80EEFB))),
              const SizedBox(width: 16.0),
              Text(title.cutText(), style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color, 
                fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily, 
                fontSize: 12.0)),
            ],
          ),
        ),
      ),
      position: const ToastPosition(align: Alignment.bottomRight),
      duration: Duration(seconds: duration ?? 60),
      dismissOtherToast: true
      );

    static success(BuildContext context, String title, {int? duration}) => showToastWidget(
      handleTouch: true,
      context: context,
      Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 16.0),
        child: CustomInkWell(
          onTap: () async => await launchUrl(Uri.parse("https://explorer.solana.com/tx/$title?cluster=devnet")),
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
                const Icon(Icons.check_circle_outline_rounded, color: Colors.greenAccent),
                const SizedBox(width: 16.0),
                Text(title.cutText(), style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color, 
                  fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily, 
                  fontSize: 12.0)),
              ],
            ),
          ),
        ),
      ),
      position: const ToastPosition(align: Alignment.bottomRight),
      duration: Duration(seconds: duration ?? 5),
      dismissOtherToast: true
      );
}
