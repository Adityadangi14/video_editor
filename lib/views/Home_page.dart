import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/cubit/cubit/video_editior_cubit.dart';
import 'package:video_editor/ffmpg/ffmpg_functions.dart';
import 'package:video_editor/file_picker/file_picker.dart';

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
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<VideoEditiorCubit, VideoEditorState>(
        builder: (context, state) {
         var data = BlocProvider.of<VideoEditiorCubit>(context);
         if(data.state.filePath != null){
           textController?.text = data.state.filePath!;
         }
         
          return Column(children: [
            TextField(
              controller: textController,
              
            ),
            ElevatedButton(onPressed: () {
              data.pickFilePath();
              
            }, child: Text('Add File')),
            Text("Filters"),
            ElevatedButton(onPressed: () {
              ffmpeg.applyMono(textController!.text);
            }, child: Text("Mono")),

            ElevatedButton(onPressed: (){
              picker.moveFile();
            }, child: Text('Move File'))
          ]);
        },
      ),
    );
  }
}
