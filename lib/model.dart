import 'dart:convert';

class UpstageModel {
  String date;
  String apiVersion;
  num confidence;
  String mimeType;
  String modelVersion;
  num numBilledPages;
  List<Page> pages;

  UpstageModel({
    required this.date,
    required this.apiVersion,
    required this.confidence,
    required this.mimeType,
    required this.modelVersion,
    required this.numBilledPages,
    required this.pages,
  });

  factory UpstageModel.fromJson(Map<String, dynamic> json) => UpstageModel(
        date: json["date"] ?? '',
        apiVersion: json["apiVersion"] ?? '',
        confidence: json["confidence"]?.toDouble() ?? 0,
        mimeType: json["mimeType"] ?? '',
        modelVersion: json["modelVersion"] ?? '',
        numBilledPages: json["numBilledPages"] ?? 0,
        pages:
            List<Page>.from(json["pages"].map((x) => Page.fromJson(x))) ?? [],
      );

  Map<String, dynamic> toJson() => {
        "apiVersion": apiVersion,
        "confidence": confidence,
        "mimeType": mimeType,
        "modelVersion": modelVersion,
        "numBilledPages": numBilledPages,
        "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
      };
}

class Page {
  num confidence;
  num height;
  num id;
  String text;
  num width;
  List<Word> words;

  Page({
    required this.confidence,
    required this.height,
    required this.id,
    required this.text,
    required this.width,
    required this.words,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        confidence: json["confidence"]?.toDouble() ?? 0,
        height: json["height"] ?? 0,
        id: json["id"] ?? 0,
        text: json["text"] ?? '',
        width: json["width"] ?? '',
        words:
            List<Word>.from(json["words"].map((x) => Word.fromJson(x))) ?? [],
      );

  Map<String, dynamic> toJson() => {
        "confidence": confidence,
        "height": height,
        "id": id,
        "text": text,
        "width": width,
        "words": List<dynamic>.from(words.map((x) => x.toJson())),
      };
}

/// 각 글자별 좌표값
class Word {
  BoundingBox boundingBox;
  num confidence;
  num id;
  String text;

  Word({
    required this.boundingBox,
    required this.confidence,
    required this.id,
    required this.text,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        boundingBox: BoundingBox.fromJson(json["boundingBox"]),
        confidence: json["confidence"]?.toDouble() ?? 0,
        id: json["id"] ?? 0,
        text: json["text"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "boundingBox": boundingBox.toJson(),
        "confidence": confidence,
        "id": id,
        "text": text,
      };
}

/// Text 위치 좌표 List
class BoundingBox {
  List<Vertex> vertices;

  BoundingBox({
    required this.vertices,
  });

  factory BoundingBox.fromJson(Map<String, dynamic> json) => BoundingBox(
        vertices:
            List<Vertex>.from(json["vertices"].map((x) => Vertex.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vertices": List<dynamic>.from(vertices.map((x) => x.toJson())),
      };
}

/// 인식된 Text 좌표
class Vertex {
  num x;
  num y;

  Vertex({
    required this.x,
    required this.y,
  });

  factory Vertex.fromJson(Map<String, dynamic> json) => Vertex(
        x: json["x"],
        y: json["y"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
