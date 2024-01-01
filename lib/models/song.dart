class SongModel {
  final String SanatciAdi;
  final String SanatciFotoUrl;
  final String SarkiAdi;
  final String SarkiUrl;
  final String UserId;

  SongModel(
    
      {required this.SanatciAdi,
      required this.UserId, 
      required this.SanatciFotoUrl,
      required this.SarkiAdi,
      required this.SarkiUrl});

  Map<String, dynamic> toJson() {
    return {
      'SanatciAdi': SanatciAdi,
      'SanatciFotoUrl': SanatciFotoUrl,
      'SarkiAdi': SarkiAdi,
      'SarkiUrl': SarkiUrl,
      'UserId':UserId,
    };
  }
}
