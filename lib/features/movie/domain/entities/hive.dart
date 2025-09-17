import 'package:hive_flutter/hive_flutter.dart';

class DownloadedMovie extends HiveObject {
  final String id;
  final String title;
  final List categories;
  final String? thumbnail;
  int? size;
  String status;
  final int messageId;
  final String seriesName;
  final int sourceChannel;
  final String filePath;
  int progress;
  String? taskId;
  String trx;

  DownloadedMovie({
    required this.id,
    required this.title,
    required this.categories,
    this.thumbnail,
    this.size,
    required this.messageId,
    required this.seriesName,
    required this.sourceChannel,
    required this.filePath,
    required this.progress,
    required this.status,
    this.taskId,
    required this.trx,
  });
}

class DownloadedMovieAdapter extends TypeAdapter<DownloadedMovie> {
  @override
  final int typeId = 0;

  @override
  DownloadedMovie read(BinaryReader reader) {
    return DownloadedMovie(
      id: reader.readString(),
      title: reader.readString(),
      categories: reader.readStringList(),
      thumbnail: reader.read(),
      size: reader.read(),
      messageId: reader.read(),
      sourceChannel: reader.read(),
      filePath: reader.readString(),
      seriesName: reader.readString(),
      progress: reader.read(),
      status: reader.readString(),
      taskId: reader.read(),
      trx: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedMovie obj) {
    // Ensure write order matches read order exactly
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeList(obj.categories);
    writer.write(obj.thumbnail);
    writer.write(obj.size);
    writer.write(obj.messageId);
    writer.write(obj.sourceChannel);
    writer.writeString(obj.filePath);
    writer.writeString(obj.seriesName);
    writer.write(obj.progress);
    writer.writeString(obj.status);
    writer.write(obj.taskId);
    writer.writeString(obj.trx);
  }
}
