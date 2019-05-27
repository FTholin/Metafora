class Item {
  String id;
  String style;         //  metaphore, ...
  String categorie;     // image, rap, texte
  String pathToPicture;
  String text;
  String help;

  Item({this.id, this.style, this.categorie, this.pathToPicture, this.text, this.help});

  bool isPicture() { return categorie == "image"; }

  bool operator ==(other) => other is Item && id == other.id;

  int get hashCode => id.hashCode;

  factory Item.fromJson(Map<String, dynamic> json) {
    return new Item(
        id: json['id'],
        style: json['style'],
        categorie: json['categorie'],
        pathToPicture: json['picture'],
        text: json['text'],
        help: json['help']
    );
  }
}