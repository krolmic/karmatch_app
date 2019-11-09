import 'package:meta/meta.dart';

class Car {
   Car({
    this.hersteller,
    this.kilometer,
     this.farbe,
     this.antriebsart,
     this.modell,
     this.preis,
     this.erstzulassung,
     this.leistung,
  });

  String hersteller;
  String farbe;
  String antriebsart;
  String modell;
  double preis;
  int erstzulassung;
  int leistung;
  int kilometer;
}
