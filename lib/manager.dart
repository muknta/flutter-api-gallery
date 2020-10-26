import 'utils/config.dart';

// final prefs = await SharedPreferences.getInstance();
String getPhotosAPI() => 'https://api.unsplash.com/photos';
String photoDownload(String photoId) =>
	'https://unsplash.com/photos/${photoId}/download';

String addAccessPartOfUrl(String url) => '${url}/?client_id=${unsplashToken}';
