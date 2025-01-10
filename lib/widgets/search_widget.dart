import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      width: 500.0,
      child: TextField(
        // onTap: _openMenu,
        textCapitalization: TextCapitalization.words,
        cursorColor: Colors.grey.withOpacity(0.2),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          fillColor: Colors.transparent,
          hintText: "Search pool",
          isDense: true,
          hintStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).hintColor.withOpacity(0.5)),
          filled: true,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.command,
                  size: 12.0, color: Colors.grey.withOpacity(0.8)),
              const SizedBox(width: 4.0),
              Text('k',
                  style: TextStyle(
                      fontSize: 14.0, color: Colors.grey.withOpacity(0.8)))
            ],
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)),
        ),
      ),
    );
  }
}
