import 'dart:io';

import 'package:file_picker/file_picker.dart';

class VEFilePicker {

  getFilePath()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
     if(result != null){
       print('file name : ${result.files.first.name}');
       return result.files.first.path;
     }
  }

  Future<File> moveFile() async {
   File sourceFile ='/data/user/0/com.example.video_editor/cache/file_picker/output2.mp4' as File;
   String newPath = '/storage/emulated/0/Download';
  try {
    // prefer using rename as it is probably faster
    return await sourceFile.rename(newPath);
  } on FileSystemException catch (e) {
    // if rename fails, copy the source file and then delete it
    final newFile = await sourceFile.copy(newPath);
    await sourceFile.delete();
    return newFile;
  }
}
}