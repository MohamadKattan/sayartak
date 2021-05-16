// import 'package:flutter/material.dart';
// import 'package:sayartak/all_screens/main_screen.dart';
// import 'package:sayartak/widget/customDrawer.dart';
// import 'package:foldable_sidebar/foldable_sidebar.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   FSBStatus drawerStatus;
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(AppLocalizations.of(context).title),
//           centerTitle: false,
//           backgroundColor: Colors.black,
//           leading: IconButton(
//             color: Colors.redAccent[700],
//             icon: Icon(
//               Icons.menu,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               setState(() {
//                 drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
//                     ? FSBStatus.FSB_CLOSE
//                     : FSBStatus.FSB_OPEN;
//               });
//             },
//           ),
//         ),
//         body: FoldableSidebarBuilder(
//           drawerBackgroundColor: Colors.grey[700],
//           status: drawerStatus,
//           screenContents: HomeScreen(),
//           drawer: CustomDrawer(
//             closeDrawer: () {
//               setState(() {
//                 drawerStatus = FSBStatus.FSB_CLOSE;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
