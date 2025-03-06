import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:spice_ui/service/config.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:url_launcher/url_launcher.dart';

class Toastification {
  static error(String title, {int? duration}) => showToastWidget(
      Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 16.0),
        child: Container(
          height: 60.0,
          width: 314.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
              color: Colors.black),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.grey),
              const SizedBox(width: 16.0),
              Text(title, style: 
              const TextStyle(
                color: Colors.white, 
                fontFamily: "CPMono", 
                fontSize: 13.0)),
            ],
          ),
        ),
      ),
      position: const ToastPosition(align: Alignment.bottomRight),
      duration: Duration(seconds: duration ?? 5),
      dismissOtherToast: true
      );

  static processing(String title, {int? duration}) => showToastWidget(
      handleTouch: true,
      Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 16.0),
        child: Container(
          height: 60.0,
          width: 314.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
              color: Colors.black),
          child: Row(
            children: [
              const SizedBox(height: 25.0, width: 25.0, child: CircularProgressIndicator(strokeWidth: 1.0, color: Colors.grey)),
              const SizedBox(width: 16.0),
              Text(title, style: 
              const TextStyle(
                color: Colors.white, 
                fontFamily: "CPMono", 
                fontSize: 13.0)),
            ],
          ),
        ),
      ),
      position: const ToastPosition(align: Alignment.bottomRight),
      duration: Duration(seconds: duration ?? 60),
      dismissOtherToast: true
      );

    static success(String title, {int? duration}) => showToastWidget(
      handleTouch: true,
      Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 16.0),
        child: CustomInkWell(
          onTap: () async => await launchUrl(Uri.parse("https://explorer.solana.com/tx/$title?cluster=${SolanaConfig.cluster}")),
          child: Container(
            height: 60.0,
            width: 314.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.black),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline_rounded, color: Colors.greenAccent),
                const SizedBox(width: 16.0),
                Text(title.cutText(), 
                style: const TextStyle(
                  color: Colors.white, 
                  fontFamily: "CPMono", 
                  fontSize: 13.0)),
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
