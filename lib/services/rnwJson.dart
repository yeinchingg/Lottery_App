import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class RnWJson {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localTempFile async {
    final path = await _localPath;
    return File('$path/temp.json');
  }

  Future<File> get _localResultFile async {
    final path = await _localPath;
    return File('$path/result.json');
  }

  Future<File> writeJsonToFile(List data, String name) async {
    final file = (name == 'temp')
      ? await _localTempFile
      : await _localResultFile;
    final jsonString = jsonEncode(data);
    return file.writeAsString(jsonString);
  }

  Future<List?> readJsonFromFile(String name) async {
    try {
      final file = (name == 'temp')
        ? await _localTempFile
        : await _localResultFile;
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List data = jsonDecode(jsonString);
        return data;
      } else {
        print('JSON 檔案不存在。');
        return [];
      }
    } catch (e) {
      print('讀取檔案時發生錯誤: $e');
      return [];
    }
  }
}