import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.number,
    required this.name,
    required this.gender,
    required this.valid,
    required this.phone,
    required this.date,
  });

  final String number;
  final String name;
  final String gender;
  final bool valid;
  final String phone;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30, top: number == '1' ? 30 : 0),
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0XFFE1E5EB),
        //     offset: Offset(0, 4),
        //     blurRadius: 62,
        //     spreadRadius: 0,
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: valid ? Color(0XFF346854) : Color(0XFF9C3642),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: GoogleFonts.dmSans(
                      color: Color(0XFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        color: Color(0XFF150B3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      gender,
                      style: GoogleFonts.dmSans(
                        color: Color(0XFF524B6B),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 28),
                child: SvgPicture.asset(
                  valid ? 'assets/images/check.svg' : 'assets/images/close.svg',
                  semanticsLabel: valid ? 'Valid Icon' : 'Invalid Icon',
                ),
              ),
            ],
          ),
          SizedBox(height: 22),
          Container(
            margin: EdgeInsets.only(left: 11),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/phone.svg',
                  semanticsLabel: 'Phone Icon',
                  color: valid ? Color(0XFF346854) : Color(0XFF9C3642),
                ),
                SizedBox(width: 22),
                SizedBox(
                  width: 220,
                  child: Text(
                    phone,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: Color(0XFF150B3D),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          Container(
            margin: EdgeInsets.only(left: 11),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/calendar.svg',
                  semanticsLabel: 'Calendar Icon',
                  color: valid ? Color(0XFF346854) : Color(0XFF9C3642),
                ),
                SizedBox(width: 22),
                Text(
                  date,
                  style: GoogleFonts.openSans(
                    color: Color(0XFF150B3D),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
