import 'dart:convert';
import 'dart:js_interop';

import 'package:file_picker/file_picker.dart';
import 'package:web/web.dart' as web;

class FileService {
  /// Opens a file picker restricted to .txt files
  /// and returns the text content.
  Future<String?> pickTextFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final bytes = result.files.single.bytes;

    if (bytes == null) {
      return null;
    }

    return utf8.decode(bytes);
  }

  /// Downloads corrected text as a .txt file.
  void saveTextFile(String content, {String filename = 'corrected.txt'}) {
    final bytes = utf8.encode(content);

    final blob = web.Blob(
      [bytes.toJS].toJS,
      web.BlobPropertyBag(type: 'text/plain'),
    );

    final url = web.URL.createObjectURL(blob);

    final anchor = web.document.createElement('a') as web.HTMLAnchorElement;

    anchor
      ..href = url
      ..download = filename;

    anchor.click();

    web.URL.revokeObjectURL(url);
  }

  /// Extracts only the corrected text from the grammar-check response.
  String extractCorrectedText(String response) {
    const startMarker = 'Corrected:';
    const endMarker = 'Changes:';

    final startIndex = response.indexOf(startMarker);

    if (startIndex == -1) {
      return response.trim();
    }

    final contentStart = startIndex + startMarker.length;

    final endIndex = response.indexOf(endMarker, contentStart);

    final corrected = endIndex == -1
        ? response.substring(contentStart)
        : response.substring(contentStart, endIndex);

    return corrected.trim();
  }
}
