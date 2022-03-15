import 'dart:io';

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/stream_information.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_editor/cubit/cubit/video_editior_cubit.dart';

class FfmpegFunctions {

  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg(); 
  final VideoEditiorCubit videoEditiorCubit = VideoEditiorCubit();

  Future applyMono (String filePath) async {
    print('filepath $filePath');

    String filePath1 = validFfmpegPath(filePath);
    String outputPath ='/storage/emulated/0/Video_Editor/'+DateTime.now().microsecondsSinceEpoch.toString()+'.mp4' ;
    print('outputpath:$outputPath');

    String commandToExecute = '-i $filePath1 -vf hue=s=0 -sc_threshold 1000000000 $outputPath';
    
    if(await Permission.storage.request().isGranted){
       await  _flutterFFmpeg.execute(commandToExecute).
    then((value){
      print('result: $value');
      if(value==0){
        videoEditiorCubit.videoPlayerController(outputPath);
      }
    });
    }
    else{
      if(await Permission.storage.isPermanentlyDenied){
        openAppSettings();
      }
    }   
  }

  applyNoir(String filePath){

    String filePath1 = validFfmpegPath(filePath);
    String outputPath ='/storage/emulated/0/Video_Editor/'+DateTime.now()
    .microsecondsSinceEpoch.toString()+'.mp4' ;

    String commandToExecute = '-i $filePath1 -vf hue=s=0:b=-2 -sc_threshold 1000000000 $outputPath';

    _flutterFFmpeg.execute(commandToExecute).then((value) {
      if(value==0){
        videoEditiorCubit.videoPlayerController(outputPath);
      }
    });

    }

    applyVivid(String filePath){

    String filePath1 = validFfmpegPath(filePath);
    String outputPath ='/storage/emulated/0/Video_Editor/'+DateTime.now()
    .microsecondsSinceEpoch.toString()+'.mp4' ;

    String commandToExecute = '-i $filePath1 -vf hue=s=1,curves=increase_contrast -sc_threshold 1000000000 $outputPath';

    _flutterFFmpeg.execute(commandToExecute).then((value) {
      if(value==0){
        videoEditiorCubit.videoPlayerController(outputPath);
      }
    });  

    }

    applyDramaticWarm(String filePath){

    String filePath1 = validFfmpegPath(filePath);
    String outputPath ='/storage/emulated/0/Video_Editor/'+DateTime.now()
    .microsecondsSinceEpoch.toString()+'.mp4' ;

    String commandToExecute = '-i $filePath1 -vf hue=s=-1,curves=vintage -sc_threshold 1000000000 $outputPath';

    _flutterFFmpeg.execute(commandToExecute).then((value) {});

    }

  validFfmpegPath(String path){
 String path1 = path.replaceAll(" ","_");
  
  return path1;
  }

  

 
}



 