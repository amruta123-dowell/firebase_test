import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final TextEditingController? textController;
  final String? description;
  final Function onClickCancel;
  final Function onClickAccept;
  final String? acceptButtonText;
  final Color? cancelButtonColor;
  final Color? proceedButtonColor;
  final dynamic cancelTextStyle;
  final dynamic proceedTextStyle;
  final Widget? descriptionWidget;
  final String? errorTextField;
  const CustomDialog({
    super.key,
    this.textController,
    this.title,
    this.description,
    required this.onClickCancel,
    required this.onClickAccept,
    this.acceptButtonText,
    this.cancelButtonColor,
    this.proceedButtonColor,
    this.cancelTextStyle,
    this.proceedTextStyle,
    this.descriptionWidget,
    this.errorTextField,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                margin: EdgeInsets.only(bottom: 16),
                // height: feedbackAcceptOrDisputeMsg == null ? 300 : 212,
                padding: EdgeInsets.symmetric(horizontal: 12),

                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      title ?? "Edit task",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          if (descriptionWidget != null) ...[
                            const SizedBox(height: 20),
                            descriptionWidget!,
                          ],
                          if (description != null) ...[
                            const SizedBox(height: 20),
                            Text(
                              description!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            )
                          ] else if (description == null &&
                              descriptionWidget == null) ...[
                            const SizedBox(height: 8),
                            DialogTextField(
                              tecController: textController,
                            ),
                            if (errorTextField != null &&
                                errorTextField?.isNotEmpty == true) ...[
                              Text(errorTextField!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                            ]
                          ]
                        ],
                      ),
                    ),
                    if ((description != null &&
                            description?.isNotEmpty == true) ||
                        descriptionWidget != null)
                      SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            onClickCancel();
                          },
                          child: CustomSubmitCancelButton(
                              title: "cancel",
                              buttonColor:
                                  const Color.fromARGB(255, 210, 178, 211),
                              textStyle: cancelTextStyle ??
                                  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                        )),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            onClickAccept();
                          },
                          child: CustomSubmitCancelButton(
                              buttonColor:
                                  const Color.fromARGB(255, 120, 11, 6),
                              title: acceptButtonText ?? "Proceed",
                              textStyle: proceedTextStyle ??
                                  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ])));
  }
}

class DialogTextField extends StatelessWidget {
  final TextEditingController? tecController;
  const DialogTextField({super.key, this.tecController});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: TextFormField(
          maxLines: 5,
          controller: tecController,
          decoration: InputDecoration(
              hintText: "type_here",
              hintStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none),
        ));
  }
}

class CustomSubmitCancelButton extends StatelessWidget {
  final Color? buttonColor;
  final TextStyle? textStyle;
  final String? title;
  const CustomSubmitCancelButton(
      {super.key, this.buttonColor, this.textStyle, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: buttonColor ?? const Color.fromARGB(255, 210, 17, 197),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title ?? '',
        style: textStyle ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
      ),
    );
  }
}
