import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/stream_information.dart';

class FfmpegFunctions {

  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg(); 

  Future applyMono (String filePath) async {
    print('filepath $filePath');

    String filePath1 = validFfmpegPath(filePath);
    String outputPath ='/data/user/0/com.example.video_editor/cache/file_picker/output2.mp4'; 
    
    return await  _flutterFFmpeg.execute(" -i $filePath1 -vf hue=s=0 -sc_threshold 1000000000 $outputPath").
    then((value){
      print('result: $value');
    });
  }

  validFfmpegPath(String path){
 String path1 = path.replaceAll(" ","_");
  
  return path1;
  }
}