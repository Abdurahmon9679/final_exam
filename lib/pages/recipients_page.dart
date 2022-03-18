import 'package:benaficary/models/recopients_class.dart';
import 'package:benaficary/pages/beneficiary_page.dart';
import 'package:benaficary/services/hive_service.dart';
import 'package:benaficary/services/http_service.dart';
import 'package:flutter/material.dart';

class RecipientsPage extends StatefulWidget {
  const RecipientsPage({Key? key}) : super(key: key);

  static const String id = '/RecipientsPage';

  @override
  _RecipientsPageState createState() => _RecipientsPageState();
}

class _RecipientsPageState extends State<RecipientsPage> {

  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();



 void addRecipient() async{
    String name = nameController.text.trim().toString();
    String relationship = relationshipController.text.trim().toString();
    String phoneNumber = phoneNumberController.text.trim().toString();

    if(name.isEmpty||relationship.isEmpty||phoneNumber.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields must filled")));
      return;
    }

    setState(() {
      isLoading = true;
    });
    Recipients recipient = Recipients(
      name:name,
      relationship: relationship,
      phoneNumber: phoneNumber, id: ''
    );
    List <Recipients> recipients = DBService.load();
    recipients.add(recipient);
    DBService.store(recipients);
    await Network.POST(Network.API_CREATE, Network.paramsCreate(recipient));
    Navigator.pushReplacementNamed(context, BeneficiaryPage.id);



 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Add recipients",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),):Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
             Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    alignment: Alignment.bottomRight,
                    width: 100,
                    height: 100,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt,color: Colors.white,size: 18,),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ///textFields

                  ///name
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      label: const Text("Names"),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  ///relationship
                  TextField(
                    controller: relationshipController,
                    decoration: InputDecoration(
                      label: const Text("Relationship"),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  ///phoneNumber
                  TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      label: const Text("Phone Number"),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ///save button
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  onPressed: (){
                    addRecipient();
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  shape: const StadiumBorder(),
                  child: const Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
