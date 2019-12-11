
class User {
  String name;
  String email;
  String phone;

  User(this.name, this.email, this.phone);
}

class Regular extends User {
  List favorites;
  Reservation reservation;

  Regular(String name, String email, String phone, this.favorites, this.reservation): super(name,email,phone);
}

class Proprietary extends User {
  String contact;
  List<Park> parks;

  Proprietary(String name, String email, String phone, this.contact, this.parks): super(name,email,phone);
}

class Park {
  String name; // park name
  String location; // park location
  int max; // total parking lots
  int current; // current free lots
  Map types; // types of lots (organized as { type:quantity })
  Map priceTable; // the price table for different times (organized as
                  // {
                  //   days (ex: Seg-Sex): {
                  //     time (ex: 09:00-17:00) : price
                  // }
  String ownerName; // name of the owner
  String ownerContact; // contact of owner

  Park(this.name,this.location,this.max,this.current,this.types,this.priceTable,this.ownerName,this.ownerContact);
}

class Reservation {
  double lat; // latitude
  double lon; // longitude
  DateTime startDate;
  DateTime endDate;

  Reservation(this.lat,this.lon,this.startDate,this.endDate);
}