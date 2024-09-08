import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

sealed class InventoryHelper {
  static Future<File> urlToFile(String imageUrl) async {
    // Get the image data from the URL
    var response = await http.get(Uri.parse(imageUrl));

    // Get the temporary directory of the device
    var documentDirectory = await getApplicationDocumentsDirectory();

    // Create a file in the temporary directory
    File file = File(
        '${documentDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png');

    // Write the image data to the file
    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }
}
