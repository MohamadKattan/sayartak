import 'package:flutter/material.dart';
import 'package:sayartak/confige.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TowTruckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).towtruck),
        centerTitle: false,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircleAvatar(backgroundColor: Colors.white,radius: 40,child: Image.asset("images/fix1.png")),
                Text("${AppLocalizations.of(context).title}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                Text(AppLocalizations.of(context).revolutions,style: TextStyle(color: Colors.grey))
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            Column(
              children: [
                Text(AppLocalizations.of(context).road),
                SizedBox(height: 15),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CircleAvatar(radius: 25,backgroundColor: Colors.white,child: Image.asset("images/Untitled3.png")),
                  ),
                  Text(AppLocalizations.of(context).rescue,style: TextStyle(fontSize: 18),)

                ]),
                SizedBox(height: 15),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CircleAvatar(radius: 25,backgroundColor: Colors.white,child: Image.asset("images/Untitled2.png")),
                  ),
                  Text(AppLocalizations.of(context).fix,style: TextStyle(fontSize: 18.0),),

                ]),
                SizedBox(height: 15),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CircleAvatar(backgroundColor: Colors.white,radius:25 ,child: Image.asset("images/Untitled1.png")),
                  ),
                  Text(AppLocalizations.of(context).battery,style: TextStyle(fontSize: 18.0),),

                ]),
              ],
            ),
            Divider(),
            SizedBox(height: 50),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()=>launchCall(),
                child: Container(
                  height: MediaQuery.of(context).size.height*9/100,
                  width:  MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        spreadRadius: 0.8,
                        offset: Offset(0.7,0.7)
                      ),
                    ],
                  ),
                  child: Center(child: Text(AppLocalizations.of(context).callus,style: TextStyle(color: Colors.white,fontSize: 18),)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  launchCall() async {
    final url = 'tel://+90000000000';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
