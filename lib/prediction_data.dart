class PredictionData {

  String name;
  double confidence;

  PredictionData({
    required this.name,
    required this.confidence,
  });

  factory PredictionData.fromMap(Map<String, dynamic> json) => PredictionData(
    name: json["class"],
    confidence: json["confidence"],
  );
}