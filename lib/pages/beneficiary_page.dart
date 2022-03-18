import 'package:benaficary/models/recopients_class.dart';
import 'package:benaficary/pages/recipients_page.dart';
import 'package:benaficary/services/hive_service.dart';
import 'package:benaficary/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeneficiaryPage extends StatefulWidget {
  const BeneficiaryPage({Key? key}) : super(key: key);

  static const String id ="benaficiary";

  @override
  _BeneficiaryPageState createState() => _BeneficiaryPageState();
}

class _BeneficiaryPageState extends State<BeneficiaryPage> {

  List <Recipients>recipients = [];

 bool isLoading = false;

 ///load
  void apiLoadList() async{
    setState(() {
      isLoading = true;
    });
    await Network.GET(Network.API_LIST, Network.paramsEmpty()).then((responce){

     if(responce !=null) {
       setState(() {
         recipients = Network.parseResponse(responce);
         DBService.store(recipients);
       });
     }else {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No date")));
     }
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    apiLoadList();
    print(recipients);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Beneficiary",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.chevron_left_sharp,size: 35,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(CupertinoIcons.search,size: 30,),
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 18,color: Colors.grey)
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Recipients",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 24,fontStyle: FontStyle.italic),),
              const SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recipients.length,
                  itemBuilder: (context,index){
                    return items(recipients[index],index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RecipientsPage.id);
        },
        child: const Icon(Icons.add,color: Colors.white,size: 35,),
      ),
    );
  }

  Widget items(Recipients recipient, int index) {
    return  Dismissible(
        key: const ValueKey(0),
    onDismissed: (_) async {
    recipients.remove(recipient);
    DBService.store(recipients);
    await Network.DEL(Network.API_DELETE + recipient.id.toString(), Network.paramsEmpty());
    },
      ////
      child:Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 30,
          foregroundImage: AssetImage("assets/images/img.jpg"),
        ),
        title:  Text(recipient.name),
        subtitle:  Text(recipient.phoneNumber),
        trailing: MaterialButton(
          onPressed: (){},
          color: Colors.blue,
          child: const Text("Sent",style: const TextStyle(color: Colors.white),),
          minWidth: 50,
          height: 25,
        ),
      ),
    ),
    );
  }
}
