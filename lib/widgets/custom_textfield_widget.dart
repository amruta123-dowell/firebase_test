import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final TextInputType? textType;

  const CustomTextFieldWidget(
      {super.key, required this.controller, this.title, this.textType});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 247, 247),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              controller: controller,
              keyboardType: textType,
              cursorColor: const Color.fromARGB(255, 213, 212, 212),
              decoration: const InputDecoration(
                  fillColor: Colors.amber,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 7)),
            ),
          ),
        ],
      ],
    );
  }
}
