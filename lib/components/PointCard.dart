import 'package:flutter/material.dart';
import '../Data/ColorsData.dart';

Center PoinCard(Size size, nama, kode, kg1, kg2, rp, p) {
  return Center(
    child: Stack(children: [
      Container(
        width: size.width,
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xFF0C356A),
          //borderRadius: BorderRadius.circular(10),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x28000000),
              blurRadius: 17,
              offset: Offset(0, 0),
              spreadRadius: 3,
            )
          ],
        ),
        child: Stack(
          children: [
            // Positioned(
            //   left: 225,
            //   top: 52,
            //   child: Container(
            //     width: 220,
            //     height: 220,
            //     decoration: ShapeDecoration(
            //       color: Color(0xFF0C356),
            //       shape: OvalBorder(),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   left: 254,
            //   top: 81,
            //   child: Container(
            //     width: 162,
            //     height: 162,
            //     decoration: ShapeDecoration(
            //       color: Color(0xFF2A9235),
            //       shape: OvalBorder(),
            //     ),
            //   ),
            // ),
            Positioned(left: 320, top: 95, child: p),
            // Positioned(
            //     left: 265,
            //     top: 25,
            //     child: Container(
            //       width: 80,
            //       height: 17,
            //       decoration: ShapeDecoration(
            //         color: Color(0xFFFFC107),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'Promo Card',
            //           style: TextStyle(
            //             color: Color(0xFF333333),
            //             fontSize: 11,
            //             fontFamily: 'Poppins',
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     )),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Opacity(
                    opacity: 0.60,
                    child: Text(
                      kode,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      kg1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Text(
                  //   'Sampah Terkumpul',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 11,
                  //     fontFamily: 'Poppins',
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 18, top: 155),
      //   child: Container(
      //     width: 336,
      //     height: 75,
      //     decoration: ShapeDecoration(
      //       color: Color(0xFFDCEAE7),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.only(left: 15, right: 15),
      //       child: Row(
      //         children: [
      //           Row(
      //             children: [
      //               // Image.asset(
      //               //   'assets/img/icons1.png',
      //               //   width: 36,
      //               //   height: 36,
      //               // ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 15, left: 25),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.end,
      //                   children: [
      //                     Text(
      //                       'Konversi Hari ini',
      //                       style: TextStyle(
      //                         color: Color(0xFF333333),
      //                         fontSize: 10,
      //                         fontFamily: 'Poppins',
      //                         fontWeight: FontWeight.w500,
      //                       ),
      //                     ),
      //                     Text(
      //                       kg2,
      //                       style: TextStyle(
      //                         color: Color(0xFF333333),
      //                         fontSize: 24,
      //                         fontFamily: 'Poppins',
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(left: 20, right: 20),
      //             child: Container(
      //               width: 1,
      //               height: 60,
      //               decoration: ShapeDecoration(
      //                 color: Color(0xFFDCEAE7),
      //                 shape: RoundedRectangleBorder(
      //                   side: BorderSide(
      //                     width: 0.50,
      //                     strokeAlign: BorderSide.strokeAlignCenter,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Row(
      //             children: [
      //               // Image.asset(
      //               //   'assets/img/rupiah.png',
      //               //   width: 36,
      //               //   height: 36,
      //               // ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 15, left: 18),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.end,
      //                   children: [
      //                     Text(
      //                       'Penghasilan',
      //                       textAlign: TextAlign.right,
      //                       style: TextStyle(
      //                         color: Color(0xFF333333),
      //                         fontSize: 10,
      //                         fontFamily: 'Poppins',
      //                         fontWeight: FontWeight.w500,
      //                       ),
      //                     ),
      //                     Text(
      //                       rp,
      //                       textAlign: TextAlign.right,
      //                       style: TextStyle(
      //                         color: Color(0xFF333333),
      //                         fontSize: 24,
      //                         fontFamily: 'Poppins',
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // )
    ]),
  );
}
