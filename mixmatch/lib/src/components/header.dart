import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/styles.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key, required this.title, required this.icons});
  final String title;
  final List<String> icons;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.only(left: 100.0, right: 100.0, top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                // navigate to profile page
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.headphones,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: widget.icons[0],
              )),
          DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.headerText),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
              )),
          ElevatedButton(
              onPressed: () {
                // navigate to settings page
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.settings,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: widget.icons[1],
              )),
        ],
      ),
    );
  }
}
//   Widget _build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(),
//       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//               width: 28,
//               height: 28,
//               decoration: const BoxDecoration(
//                 color: Color.fromRGBO(255, 255, 255, 1),
//               ),
//               child: Stack(children: <Widget>[
//                 Positioned(
//                   top: 2.799999952316284,
//                   left: 2.799999952316284,
//                   child: SvgPicture.asset('assets/images/vector.svg',
//                       semanticsLabel: 'vector'),
//                 ),
//               ])),
//           const SizedBox(width: 105),
//           const Text(
//             'For You',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Color.fromRGBO(49, 49, 49, 1),
//                 fontFamily: 'Inter',
//                 fontSize: 28,
//                 fontWeight: FontWeight.normal,
//                 height: 1),
//           ),
//           const SizedBox(width: 105),
//           Container(
//               width: 29,
//               height: 32,
//               decoration: const BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: Color.fromRGBO(0, 0, 0, 0.25),
//                       offset: Offset(0, 4),
//                       blurRadius: 4)
//                 ],
//                 color: Color.fromRGBO(255, 255, 255, 1),
//               ),
//               child: Stack(children: <Widget>[
//                 Positioned(
//                     top: 5.333333492279053,
//                     left: 3.625,
//                     child: SizedBox(
//                         width: 21.75,
//                         height: 21.33333396911621,
//                         child: Stack(children: <Widget>[
//                           Positioned(
//                             top: -1.5894572413799324e-7,
//                             left: 2.4166667461395264,
//                             child: SvgPicture.asset('assets/images/vector.svg',
//                                 semanticsLabel: 'vector'),
//                           ),
//                           Positioned(
//                             top: 10.666666030883789,
//                             left: 0,
//                             child: SvgPicture.asset('assets/images/vector.svg',
//                                 semanticsLabel: 'vector'),
//                           ),
//                           Positioned(
//                             top: 3.999999761581421,
//                             left: 8.458333015441895,
//                             child: SvgPicture.asset('assets/images/vector.svg',
//                                 semanticsLabel: 'vector'),
//                           ),
//                           Positioned(
//                             top: 12,
//                             left: 16.91666603088379,
//                             child: SvgPicture.asset('assets/images/vector.svg',
//                                 semanticsLabel: 'vector'),
//                           ),
//                         ]))),
//               ])),
//         ],
//       ),
//     );
//   }
// }