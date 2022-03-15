import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:video_player/video_player.dart';

import '../../file_picker.dart/file_picker.dart';


part 'video_editior_state.dart';

class VideoEditiorCubit extends Cubit<VideoEditorState> {
  VideoEditiorCubit() : super(VideoEditorState(filePath: null, processing: null,processedVideoFilePath: null));


  pickFilePath()async{
    VEFilePicker filepath = VEFilePicker();

   String result = await filepath.getFilePath();

   emit(state.copyWith(filePath: result));

  }

  videoPlayerController( [filePath]) async{
    print('function ran');
     await Future<void>.delayed(const Duration(milliseconds:50));
    emit(state.copyWith());
    print('state :${state.processedVideoFilePath}');
    
  }
}
