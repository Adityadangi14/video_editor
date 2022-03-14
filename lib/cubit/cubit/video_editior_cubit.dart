import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/file_picker/file_picker.dart';


part 'video_editior_state.dart';

class VideoEditiorCubit extends Cubit<VideoEditorState> {
  VideoEditiorCubit() : super(VideoEditorState(filePath: null, processing: null));

  pickFilePath()async{
    VEFilePicker filepath = VEFilePicker();

   String result = await filepath.getFilePath();

   emit(state.copyWith(filePath: result));

  }
}
