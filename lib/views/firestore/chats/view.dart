import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsView extends StatefulWidget {

  final String email;
  const ChatsView({super.key, required this.email});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

final msgController=TextEditingController(text: "");

/*Stream collectionStream = FirebaseFirestore.instance.collection('messages').snapshots();
Stream documentStream = FirebaseFirestore.instance.collection('messages').doc('ABC123').snapshots();*/

Stream<QuerySnapshot> _msgsStream = FirebaseFirestore.instance.collection('messages').orderBy('date').snapshots();
CollectionReference msgs = FirebaseFirestore.instance.collection('messages');
final  _listviewcontroller = ScrollController();

class _ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("chats"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 26),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _msgsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if(snapshot.hasData){
            return Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _listviewcontroller,
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>  _item(snapshot.data!.docs[index]),
                  ),
                ),
                _sendButton(),
              ],
            );
          }else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString(),style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
          }else{
            return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,strokeWidth: 8,));
          }
        },

      ),
    );
  }

  Widget _item(QueryDocumentSnapshot<Object?> doc) {
    if(doc['email'] == widget.email)
    return senderBox(doc['msg']);
    else
      return notSenderBox(doc['msg']);
  }

  Widget senderBox(String msg){
    return Container(
      alignment: AlignmentDirectional.topStart,
      margin: EdgeInsetsDirectional.all(8),
      padding: EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(20),topEnd: Radius.circular(20),bottomStart: Radius.circular(20)),
        color: Theme.of(context).primaryColor
      ),
      child: Text(msg,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
    );
  }

  Widget notSenderBox(String msg){
    return Container(
      alignment: AlignmentDirectional.topEnd,
      margin: EdgeInsetsDirectional.all(8),
      padding: EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(20),topEnd: Radius.circular(20),bottomStart: Radius.circular(20)),
          color: Colors.green
      ),
      child: Text(msg,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
    );
  }

  Widget _sendButton() {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 16,vertical: 8),
        child: TextField(
          controller: msgController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            hintText: "type here message",
            suffix: IconButton(
              onPressed: () {
                addmsg();
              },
              icon: Icon(Icons.send,color: Theme.of(context).primaryColor,),
            )
          ),
        ),
      ),
    );
  }

 void addmsg() {
    // Call the user's CollectionReference to add a new user
    /* return msgs
        .add({
      'msg': msgController.text, // John Doe
      'email': widget.email, // Stokes and Sons
      'date': DateTime.now() // 42
    }
    )
        .then((value) {
      print("Message Sent");
      msgController.clear();
      _listviewcontroller.animateTo(_listviewcontroller.position.maxScrollExtent, curve: Curves.bounceIn, duration:  Duration(seconds: 1),);
    })
        .catchError((error) {
      print("Failed to send message: $error");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$error",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight:
            FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.red,));
    });*/

    try {
      msgs
          .add({
        'msg': msgController.text, // John Doe
        'email': widget.email, // Stokes and Sons
        'date': DateTime.now() // 42
      }
      );
      print("Message Sent");
      msgController.clear();
      _listviewcontroller.animateTo(
        _listviewcontroller.position.maxScrollExtent, curve: Curves.bounceIn,
        duration: Duration(seconds: 2),);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$e",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight:
            FontWeight.bold),),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,));
    }
  }

}
