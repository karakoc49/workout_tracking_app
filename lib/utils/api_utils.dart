// api_utils.dart
import 'package:http/http.dart' as http;

String apiBaseUrl = "http://10.0.2.2:8000/api";
// String apiBaseUrl = "http://192.168.1.158:8000/api";
// String apiBaseUrl = "http://localhost:8000/api";

Future<bool> checkHostAvailability(String host) async {
  try {
    final response = await http.get(Uri.parse(host));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<void> updateApiBaseUrl() async {
  const localHost = "http://10.0.2.2:8000/api";
  const alternativeHost = "http://192.168.1.158:8000/api";

  final isLocalHostAvailable = await checkHostAvailability(localHost);
  if (isLocalHostAvailable) {
    apiBaseUrl = localHost;
  } else {
    apiBaseUrl = alternativeHost;
  }
}
