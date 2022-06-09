class Nbclassebyniveau{
  
  final int id;
  final int nbclasse;
  final int niveau;

  const Nbclassebyniveau({
    required this.id,
    required this.nbclasse,
    required this.niveau
  });

  factory Nbclassebyniveau.fromJson(Map<String, dynamic> json) {
    return Nbclassebyniveau(
      id: json['_id'],
      nbclasse: json['nbClasse'],
      niveau: json['niveau']
    );
  }


}