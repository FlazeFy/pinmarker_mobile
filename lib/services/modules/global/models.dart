import 'dart:convert';

class ListTag {
  String tagName;

  ListTag({required this.tagName});

  factory ListTag.fromJson(Map<String, dynamic> json) {
    return ListTag(
      tagName: json['tag_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag_name': tagName,
    };
  }
}

// Model for GlobalListSearchModel
class GlobalListSearchModel {
  String id;
  String pinList;
  int total;
  String listName;
  String listDesc;
  List<ListTag> listTag; // Changed from String to List<ListTag>
  String createdAt;
  String createdBy;

  GlobalListSearchModel({
    required this.id,
    required this.pinList,
    required this.total,
    required this.listName,
    required this.listDesc,
    required this.listTag,
    required this.createdAt,
    required this.createdBy,
  });

  factory GlobalListSearchModel.fromJson(Map<String, dynamic> map) {
    return GlobalListSearchModel(
      id: map['id'],
      pinList: map['pin_list'],
      total: map['total'],
      listName: map['list_name'],
      listDesc: map['list_desc'],
      listTag: List<ListTag>.from(map['list_tag'].map(
          (tag) => ListTag.fromJson(tag))), // Map the list_tag to ListTag model
      createdAt: map['created_at'],
      createdBy: map['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin_list': pinList,
      'total': total,
      'list_name': listName,
      'list_desc': listDesc,
      'list_tag': listTag.map((tag) => tag.toJson()).toList(),
      'created_at': createdAt,
      'created_by': createdBy,
    };
  }
}

// Function to parse the JSON data
List<GlobalListSearchModel> globalListSearchModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<GlobalListSearchModel>.from(
      data['data'].map((item) => GlobalListSearchModel.fromJson(item)));
}
