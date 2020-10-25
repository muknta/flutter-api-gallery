import 'utils/config.dart';

// final prefs = await SharedPreferences.getInstance();

String addAccessPartOfUrl(String url) {
	return '${url}/?client_id=${unsplashToken}';
}
