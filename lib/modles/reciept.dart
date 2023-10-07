
class Recipt {

  final title;
  final totalprice;
  final totalWeight;
  final text;
  final int id;
  String note;
  bool isExpanded;
  final String wwwe;

  static final columns = [
    "id",
    "title",
    "totalprice",
    "totalWeight",
    "text",
    "note", 
    "wwwe"
  ];
  Recipt(
      {this.title,
      this.wwwe,
      this.totalWeight,
      this.totalprice,
      this.text,
      this.note,
      this.id, 
      this.isExpanded = false, 
      });

  factory Recipt.fromMap(Map<String, dynamic> data) {
    return Recipt(
      id: data["id"],
      text: data["text"],
      title: data["title"],
      totalWeight: data["totalWeight"],
      totalprice: data["totalprice"],
      note: data["note"], 
      wwwe: data["wwwe"]
    );
  }

  Map<String, dynamic> toMap()=>{
      "id" : id, 
      "text" : text,
      "title" : title,
      "totalWeight" : totalWeight, 
      "totalprice" : totalprice,
      "note" : note,
      "wwwe" : wwwe,
  };



  
}
