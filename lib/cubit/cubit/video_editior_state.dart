part of 'video_editior_cubit.dart';



class VideoEditorState {

  String?  filePath;
  bool? processing;

  VideoEditorState({required this.filePath, required this.processing});

  VideoEditorState copyWith({
    String? filePath,
    bool? processing
  }){
    return VideoEditorState(
      filePath : filePath ?? this.filePath,
      processing: processing ?? this.processing
    );

  }


}
