import 'dart:convert';
import 'package:http/http.dart' as http;

import '/music/audioModel.dart';

Future<List<Audio>> fetchAudio() async {
  final response = await http
      .get(Uri.parse('https://cutaudio.co/version-test/api/1.1/obj/clip'));

  print('==================== response');
  print(response);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    List<Audio> _listAudio = [];

    var data = jsonDecode(response.body)["response"]["results"];

    for (var audio in data) {
      print('================ audio');
      print(audio);
      _listAudio.add(Audio.fromJson(audio));
    }

    return _listAudio;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Audio');
  }
}
