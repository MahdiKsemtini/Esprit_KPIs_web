class Branche{
  
  final String id;
  final int count;

  const Branche({
    required this.id,
    required this.count
  });

  factory Branche.fromJson(Map<String, dynamic> json) {
    return Branche(
      id: json['_id'],
      count: json['count']
    );
  }


}