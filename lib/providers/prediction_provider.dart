import 'dart:convert';

import 'package:http/http.dart';
import 'package:lookalike/prediction_data.dart';
import 'package:riverpod/riverpod.dart';

class PredictionProvider extends StateNotifier<PredictionData?> {

  PredictionProvider() : super(null);

  void uploadImage(final image) async {

    const endpoint = 'https://lookalike.herokuapp.com/predict_api';

    final uri = Uri.parse(endpoint);

    final stream = ByteStream(image.openRead());

    final length = await image.length();

    final request = MultipartRequest('POST', uri);

    request.fields[''] = 'Static title';

    final multipart = MultipartFile(
      '',
      stream,
      length,
      filename: '',
    );

    request.files.add(multipart);

    final streamedResponse = await request.send();

    final response = await Response.fromStream(streamedResponse);

    final result = jsonDecode(response.body) as Map<String, dynamic>;

    state = PredictionData.fromMap(result);
  }

  PredictionData? get value => state;

  set setPredictionData(PredictionData? val) {
    state = val;
  }
}

final predictionProvider = StateNotifierProvider<PredictionProvider, PredictionData?>(
      (ref) => PredictionProvider(),
);