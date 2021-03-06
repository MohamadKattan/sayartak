import 'package:flutter/cupertino.dart';
import 'package:sayartak/model/new_gallery.dart';
import 'package:sayartak/model/sale_car_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CallService {
  static launchCall(BuildContext context, SaleCar saleCar) async {
    final url = 'tel://${saleCar.phone}';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  static launchMessage(BuildContext context, SaleCar saleCar) async {
    final url = 'sms://${saleCar.phone}';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  static launchCallGallery(
    BuildContext context,
    Gallery gallery,
  ) async {
    final url = 'tel://${gallery.phone}';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  static launchLocationGallery(
    BuildContext context,
    Gallery gallery,
  ) async {
    final url = 'http://www.google.com/maps/place/${gallery.location}';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
