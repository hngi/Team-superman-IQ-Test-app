class Score {
  int id;
  String name;
  int mark;

  Score({this.id, this.mark, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mark': mark
    };
  }

  factory Score.fromMap(Map<String, dynamic> doc) => new Score(
    id: doc['id'],
    name: doc['name'],
    mark: doc['mark']
  );


  @override
    String toString() {
      return 'Note{id: $id, name: $name, mark: $mark}';
    }
}