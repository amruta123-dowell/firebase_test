import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// class BottomNavbarWidget extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onSelectedBottomItem;
//   const BottomNavbarWidget(
//       {super.key,
//       required this.selectedIndex,
//       required this.onSelectedBottomItem});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//         currentIndex: selectedIndex,
//         onTap: (value) {
//           onSelectedBottomItem(value);
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               ImageConstant.homeIcon,
//               height: 20,
//             ),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//               icon: Container(
//                 child: SvgPicture.asset(
//                   ImageConstant.budgetIcon,
//                   height: 24,
//                   width: 24,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               label: "Budget"),
//           BottomNavigationBarItem(
//               icon: SvgPicture.asset(ImageConstant.profileIcon),
//               label: "Profile")
//         ]);
//   }
// }
