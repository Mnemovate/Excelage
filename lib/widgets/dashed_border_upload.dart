import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';

class DashedBorderUpload extends StatelessWidget {
  final String? fileName;
  final void Function()? onTap;

  const DashedBorderUpload({
    super.key,
    required this.fileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        dashPattern: [5, 5],
        color: Color(0XFF524B6B),
        strokeWidth: 2,
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0XFFFFFFFF),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/upload.svg',
                  width: 50,
                  color: Color(0XFF524B6B),
                ),
                const SizedBox(height: 12),
                Text(
                  fileName ?? 'Upload Excel',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0XFF524B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
