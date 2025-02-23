import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';


class TopMobBar extends StatefulWidget {
  const TopMobBar({super.key});

  @override
  State<TopMobBar> createState() => _TopMobBarState();
}

class _TopMobBarState extends State<TopMobBar> {

  bool hideNotification = false;

  @override
  Widget build(BuildContext context) {
    final AdapterCubit adapterCubit = context.read<AdapterCubit>();
    return Column(
      children: [
        // hideNotification ? const SizedBox() : Container(
        //   height: 35.0,
        //   width: MediaQuery.of(context).size.width,
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   alignment: Alignment.center,
        //   color: Colors.amber.shade200,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       const SizedBox(),
        //       TextUnderline(text: "✅ Launched at Solana Devnet. Getting ready to launch on the main network", onTap: () => js.context.callMethod('open', ["https://info.spice.so/roadmap"])),
        //       CustomInkWell(
        //         onTap: () {
        //           setState(() {
        //             hideNotification = true;
        //           });
        //         },
        //         child: const Icon(Icons.clear, size: 16.0, color: Colors.black)),
        //     ],
        //   ),
        // ),

        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).hintColor, width: 1.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/logos/spice_logo.svg',
                          height: 23.0, width: 23.0),
                BlocBuilder<AdapterCubit, AdapterStates>(
                    builder: (context, state) {
                  if (state is ConnectedAdapterState) {
                    return CustomInkWell(
                      onTap: () => adapterCubit.disconnect(),
                      child: Container(
                        height: 32.0,
                        width: 140.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(state.address.toString().cutText(),
                                style: const TextStyle(
                                    color: Colors.redAccent, fontSize: 14.0)),
                            const SizedBox(width: 8.0),
                            const Icon(Icons.power_settings_new, size: 18.0, color: Colors.redAccent)
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is UnconnectedAdapterState) {
                    return CustomInkWell(
                      onTap: () => adapterCubit.connect(),
                      child: Container(
                        height: 30.0,
                        width: 140.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Connect',
                                style: TextStyle(color: Colors.black)),
                            const SizedBox(width: 16.0),
                            SvgPicture.asset('assets/logos/phantom_logo.svg',
                                height: 15.0, width: 15.0),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
