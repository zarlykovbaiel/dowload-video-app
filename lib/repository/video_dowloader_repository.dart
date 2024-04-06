import 'package:download_video/models/video_download_model.dart';
import 'package:download_video/models/video_quality_model.dart';
import 'package:extractor/extractor.dart';

class VideoDownloaderRepository {
  Future<VideoDownloadModel?> getAviableVideos(String url) async {
    try {
      final response = await Extractor.getDirectLink(link: url);

      if (response != null) {
        return VideoDownloadModel.fromJson(
          {
            "title": response.title,
            "source": response.links?.first.href,
            "thumbail": response.thumbnail,
            "videos": [
              VideoQualityModel(
                  url: response.links?.first.href, quality: "720"),
            ]
          },
        );
      } else {
        return null;
      }
    } on Exception catch (e) {
      print("Exeption occure $e");
      return null;
    }
  }
}
