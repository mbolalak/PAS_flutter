class ProdukModel {
  String namaProduk;
  int harga;
  String description;
  
  String imageUrl; 
 int id;

  ProdukModel({
    required this.namaProduk, 
    required this.harga, 
    required this.description, 
    required this.imageUrl, 
    required this.id,
  });
}