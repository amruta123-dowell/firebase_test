import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropdownWidget<T> extends StatelessWidget {
  final double? height;
  final double? width;
  final T? selectedItem;
  final List<T> itemList;
  final String? title;
  final Function(T?) onSelectedItem;
  const DropdownWidget(
      {super.key,
      this.height,
      this.width,
      this.selectedItem,
      required this.itemList,
      this.title,
      required this.onSelectedItem});

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
          )
        ],
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 248, 247, 247),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              value: selectedItem,
              isDense: true,
              isExpanded: true,
              hint: selectedItem != null
                  ? Text(_itemDisplay(selectedItem))
                  : null,
              items: itemList.map((item) {
                return DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      _itemDisplay(item),
                      style: const TextStyle(color: Colors.black),
                    ));
              }).toList(),
              onChanged: (value) {
                onSelectedItem(value);
                // print(value);
              },
              underline: const Divider(
                color: Colors.pink,
                height: 2,
              ),
              dropdownStyleData: DropdownStyleData(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 248, 247, 247))),
            ),
          ),
        ),
      ],
    );
  }
}

String _itemDisplay(item) {
  switch (item.runtimeType) {
    case const (String):
      return item.toString();

    default:
      return item.toString();
  }
}
