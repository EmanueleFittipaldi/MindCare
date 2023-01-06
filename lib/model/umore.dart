class Umore {
  final String text;
  final int score;
  final double comparative;
  final DateTime data;
  final String umoreID;
  final String type;
  Umore(
      {required this.text,
      required this.score,
      required this.comparative,
      required this.data,
      required this.umoreID,
      required this.type});

  Map<String, dynamic> toJson() => {
        'text': text,
        'score': score,
        'comparative': comparative,
        'data': data,
        'umoreID': umoreID,
        'type': type
      };

  static Umore fromJson(Map<String, dynamic> json) => Umore(
        text: json['text'],
        score: json['score'],
        comparative: json['comparative'],
        data: json['data'],
        umoreID: json['umoreID'],
        type: json['type'],
      );
}
