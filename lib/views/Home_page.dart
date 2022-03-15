import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/cubit/cubit/video_editior_cubit.dart';
import 'package:video_editor/ffmpg/ffmpg_functions.dart';

import 'dart:io';

import 'package:video_player/video_player.dart';

import '../file_picker.dart/file_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

  TextEditingController? textController =  TextEditingController();

  FfmpegFunctions ffmpeg = FfmpegFunctions();

  VEFilePicker picker = VEFilePicker();

  @override
  void initState() {
    FilePicker.platform.clearTemporaryFiles().then((value) {
      print('cache cleaned $value');
      createDirectory();

    });
    // TODO: implement initState
    super.initState();
  }

  var _controller;
 VideoPlayerController videoPlayer(String filePath){
   print('video player called: $filePath');
     _controller = VideoPlayerController.file(File(filePath))..initialize();
    _controller.play();
    _controller.setLooping(true);
    return _controller;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose;
    super.dispose();
  }


  void createDirectory() async{
    if(await  Directory('storage/emulated/0/Video_Editor').exists()){
      print('Drectory false');
      return;
    }

    else{
      await Directory('storage/emulated/0/Video_Editor').create().
      then((value) => print('Directory: $value '));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<VideoEditiorCubit, VideoEditorState>(
        builder: (context, state) {
         var data = BlocProvider.of<VideoEditiorCubit>(context);
         print('build');
         if(state.filePath != null){
           textController?.text = state.filePath!;
         }
         
          return Column(children: [
            TextField(
              controller: textController,
              
              ),
              ElevatedButton(onPressed: () {
                data.pickFilePath();
                
              }, child: const Text('Add File')),
              const Text("Filters"),
           GridView.count(
             crossAxisCount: 2,
             childAspectRatio: 7/2,
             mainAxisSpacing: 5,
             crossAxisSpacing: 5,
             shrinkWrap: true,
                   children: [
                     ElevatedButton(onPressed: (){
                       ffmpeg.applyMono(textController!.text).then((value){
                         var provider =BlocProvider.of<VideoEditiorCubit>(context);
                         provider.videoPlayerController();
                       });
                     }, 
                     child: Text("Mono"),),
                     ElevatedButton(onPressed: (){
                       ffmpeg.applyNoir(textController!.text);
                     }, child: Text('Noir')),
                     ElevatedButton(onPressed: (){
                       ffmpeg.applyVivid(textController!.text);
                     }, child: Text('Vivid')),
                     ElevatedButton(onPressed: (){
                       ffmpeg.applyDramaticWarm(textController!.text);
                     }, child: Text('Dramaitic Warm')),
                     
                   ],),

                   Container(
                     padding: EdgeInsets.all(15),
                     height: 300,
                   child: state.processedVideoFilePath==null ? Container() :   VideoPlayer(videoPlayer(state.processedVideoFilePath!)))

            
          ]);
        },
      ),
    );
  }
}
