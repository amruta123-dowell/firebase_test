import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController tecController;
  final String? errorText;
  final bool? obsecure;
  final bool? enableSuffixIcon;
  final void Function(String)? onClickDate;
  const TextFieldWidget({
    super.key,
    required this.tecController,
    required this.title,
    this.errorText,
    this.obsecure = false,
    this.enableSuffixIcon = false,
    this.onClickDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              children: const [
                TextSpan(text: ' *', style: TextStyle(color: Colors.red))
              ]),
        ),
        const SizedBox(height: 12),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.purple,
              )),
          child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              obscureText: obsecure ?? false,
              controller: tecController,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  fillColor: Colors.grey,
                  labelText: null,
                  hintText: null,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  border: InputBorder.none,
                  suffixIcon: enableSuffixIcon == true
                      ? GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                              tecController.text = formattedDate;
                              if (onClickDate != null) {
                                onClickDate!(formattedDate);
                              }
                            }
                          },
                          child: Icon(Icons.calendar_today),
                        )
                      : SizedBox.shrink())),
        ),
        const SizedBox(
          height: 6,
        ),
        if (errorText?.isNotEmpty ?? false)
          Text(
            errorText!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          )
      ],
    );
  }
}
