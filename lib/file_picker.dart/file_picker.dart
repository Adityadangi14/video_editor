import 'dart:io';

import 'package:file_picker/file_picker.dart';

class VEFilePicker {

  getFilePath()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
     if(result != null){
       return result.files.first.path;
     }
  }


}
