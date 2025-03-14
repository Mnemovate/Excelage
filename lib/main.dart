import 'package:excelmanage/widgets/contact_card.dart';
import 'package:excelmanage/widgets/dashed_border_upload.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border, BorderStyle;
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const FilePickerScreen());
}

class FilePickerScreen extends StatefulWidget {
  const FilePickerScreen({super.key});

  @override
  State<FilePickerScreen> createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  String? _fileName;
  List<List<String>> excelData = [];

  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      setState(() {
        _fileName = result.files.single.name;
      });
      if (filePath != null) {
        readExcelFile(filePath);
      }
    }
  }

  void readExcelFile(String path) {
    var file = File(path);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<List<String>> data = [];
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        data.add(row.map((cell) => cell?.value.toString() ?? '').toList());
      }
    }

    setState(() {
      excelData = data;
    });
  }

  bool isValidRow(List<String> row) {
    final noPattern = RegExp(r'^\d+$');
    final genderPattern = RegExp(r'^[PW]$');
    final namePattern = RegExp(r'^[a-zA-Z\s]+$');
    final phonePattern = RegExp(r'^\d+$');
    final datePattern = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}$',
    );

    if (row.length != 5) return false;
    if (row[2].length > 50) return false;
    if (row[3].length > 20) return false;

    return noPattern.hasMatch(row[0]) &&
        genderPattern.hasMatch(row[1]) &&
        namePattern.hasMatch(row[2]) &&
        phonePattern.hasMatch(row[3]) &&
        datePattern.hasMatch(row[4]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0XFFE1E6E4),
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Excelage',
              style: GoogleFonts.dmSans(
                color: Color(0XFFFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0XFF346854),
          toolbarHeight: 70,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload Excel',
                            style: GoogleFonts.dmSans(
                              color: Color(0XFF150B3D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add your Excel to manage',
                            style: GoogleFonts.dmSans(
                              color: Color(0XFF524B6B),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (excelData.isNotEmpty && _fileName != null) {
                            // Convert data to JSON
                            List<Map<String, dynamic>> jsonData = [];
                            for (int i = 1; i < excelData.length; i++) {
                              var row = excelData[i];
                              if (row.length >= 5) {
                                jsonData.add({
                                  'number': row[0],
                                  'gender': row[1],
                                  'name': row[2],
                                  'phone': row[3],
                                  'date': row[4],
                                });
                              }
                            }

                            // dapatkan file excel
                            // File file = File(_fileName!);
                        
                            Fluttertoast.showToast(
                              msg: "Excel file uploaded successfully!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Color(0XFF346854),
                              textColor: Color(0XFFFFFFFF),
                              fontSize: 14,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please upload an Excel file first",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Color(0XFF9C3642),
                              textColor: Color(0XFFFFFFFF),
                              fontSize: 14,
                            );
                          }
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color:
                                excelData.isNotEmpty
                                    ? Color(0XFF346854)
                                    : Color(0XFF524B6B),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/chevron-right.svg',
                              semanticsLabel: 'Next Icon',
                              color: Color(0XFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DashedBorderUpload(
                    fileName: _fileName ?? 'Upload Excel',
                    onTap: pickExcelFile,
                  ),
                ],
              ),
            ),
            if (excelData.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  itemCount: excelData.length > 1 ? excelData.length - 1 : 0,
                  itemBuilder: (context, index) {
                    var row = excelData[index + 1];
                    bool isValid = isValidRow(row);
                    return ContactCard(
                      number: row[0],
                      name: row[2],
                      gender: row[1],
                      phone: row[3],
                      date: row[4],
                      valid: isValid,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
