import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/service/locale_notficition.dart';
import 'package:sayartak/widget/custom_text_failed.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();
class AdminTypeNotification extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final TextEditingController _controllerBody = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final String notId = uuid.v1();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false,backgroundColor: Colors.black,title:Text("AdminTypeNotification")),
      key: _globalKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: customTextField(
                  textInputType: TextInputType.text,
                  labelText: "New Title",
                  maxLength: 15,
                  maxLines: 2,
                  minLines: 1,
                  controller: _controllerTitle),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: customTextField(
                  textInputType: TextInputType.text,
                  labelText: "New notification body",
                  maxLength: 60,
                  maxLines: 2,
                  minLines: 1,
                  controller: _controllerBody),
            ),
            Center(
              child: Consumer<LocaleNotifications>(
                builder: (context, model, _) => TextButton(
                  onPressed: () => model.firstNotifications(_controllerBody,_controllerTitle).then((val) =>setToFireStore()),
                  child: Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width * 80 / 100,
                    height: MediaQuery.of(context).size.height * 10 / 100,
                    child: Center(
                        child: Text(
                          "Push",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Future<void>  setToFireStore()async {
 try{
   await adminNotificationReference.doc(notId).set({
     "title":_controllerTitle.text,
     "body":_controllerBody.text,
     "timestamp":DateTime.now(),
   });
   clear();
 }catch(ex){print(ex.toString());}


}
  clear() {
    _controllerTitle.clear();
    _controllerBody.clear();
  }
}
