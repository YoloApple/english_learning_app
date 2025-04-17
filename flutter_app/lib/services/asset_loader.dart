import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/listening_item.dart';

class AssetLoader {
  /// Đọc AssetManifest.json, lấy list file mp3, trả về List<ListeningItem>
  static Future<List<ListeningItem>> loadListeningItems() async {
    final manifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> map = json.decode(manifest);

    // lọc mp3 trong assets/audio/
    final audioPaths = map.keys
        .where((k) => k.startsWith('assets/audio/') && k.endsWith('.mp3'))
        .toList()
      ..sort();

    // chuyển thành model
    final items = <ListeningItem>[];
    for (var i = 0; i < audioPaths.length; i++) {
      items.add(ListeningItem.fromMap(i + 1, audioPaths[i]));
    }
    return items;
  }
}
