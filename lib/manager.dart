import 'utils/config.dart';


String addAccessPartOfUrl(String url) {
	return '${url}/?client_id=${unsplashToken}';
}
