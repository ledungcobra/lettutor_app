import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/models/category_list/category.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../../models/request/certificate_data.dart';
import 'selection_text_form_field.dart';

class FileSelector extends StatefulWidget {
  final String placeHolder;
  Function(CertificateData) onDone;

  FileSelector({super.key, required this.placeHolder, required this.onDone});

  @override
  State<FileSelector> createState() => _FileSelectorState();
}

class _FileSelectorState extends State<FileSelector> with HandleUIError {
  Rxn<XFile> file = Rxn();
  TextEditingController textController = TextEditingController();
  final certificateType = "".obs;

  @override
  Widget build(BuildContext context) {
    return SelectionTextFormField(
      placeHolder: 'Certificate',
      onSelect: (Category c) {
        if (c.key == null) return;
        certificateType.value = c.key!;
        handleOpenUploadDialog2();
      },
      deferSelect: true,
      categories: {
        'TOEIC': Category(id: "1", key: 'TOEIC', description: 'TOEIC'),
        'IELTS': Category(id: "2", key: 'IELTS', description: 'IELTS'),
        'TOEFL': Category(id: "3", key: 'TOEFL', description: 'TOEFL'),
        'The University Certificate': Category(
            id: "4",
            key: 'The University Certificate',
            description: 'The University Certificate'),
        'Other': Category(id: "4", key: 'Other', description: 'Other'),
      },
    );
  }

  handleOpenUploadDialog2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    File file = File(result.files.single.path!);
    final data = await file.readAsBytes();
    final certificate = CertificateData(
      certificateType.value,
      data,
      file.path.split(RegExp('/')).last,
      file,
    );
    widget.onDone(certificate);
  }
}
