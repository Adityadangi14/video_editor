part of 'video_editior_cubit.dart';



class VideoEditorState {

  String?  filePath;
  bool? processing;
  String? processedVideoFilePath;

  VideoEditorState({required this.filePath, required this.processing, required this.processedVideoFilePath});

  VideoEditorState copyWith({
    String? filePath,
    bool? processing,
    String? processedVideoFilePath,
  }){
    return VideoEditorState(
      filePath : filePath ?? this.filePath,
      processing: processing ?? this.processing,
      processedVideoFilePath: processedVideoFilePath ?? this.processedVideoFilePath

    );

  }


}
