
class User {
  String name;
  String email;
  String phone;
  List parks;

  User(this.name, this.email, this.phone, this.parks);
}

class Regular extends User {
  Reservation reservation;

  Regular(String name, String email, String phone, List parks, this.reservation): super(name,email,phone,parks);
}

class Proprietary extends User {

  Proprietary(String name, String email, String phone, List parks): super(name,email,phone,parks);
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