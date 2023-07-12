import 'package:chat_app/components/chat_buble.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({super.key});
  static String id='ChatScreen';
   final  _controller = ScrollController();
  TextEditingController control = TextEditingController();
  CollectionReference message = FirebaseFirestore.instance.collection(kMessagesController);
  @override
  Widget build(BuildContext context) {
    var email =ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData)
          {
            List<Message>messagesData=[];
            for(int i=0;i<snapshot.data!.docs.length;i++)
              {
                messagesData.add(Message.fromjson(snapshot.data!.docs[i]));
              }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(kImage,height: 70,),
                    const Text('Chat'),
                  ],
                ),
              ),

              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesData.length,
                      itemBuilder: (context, index) {
                      return messagesData[index].id==email ? ChatBuble(message: messagesData[index],
                      ) : ChatBubleForAfriend(message: messagesData[index]);
                    },),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller:control ,
                      onSubmitted: (data){
                        message.add(
                            {
                              kMessages:data,
                              kCreatedAt:DateTime.now(),
                              'id':email,
                            }
                        );
                        control.clear();
                        _controller.animateTo(
                            0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn
                        );
                      },
                      decoration: InputDecoration(
                          hintText: 'Message',
                          suffixIcon: const Icon(Icons.send,
                            color:kPrimaryColor,
                          ),
                          contentPadding: const EdgeInsets.all(22),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:const  BorderSide(
                              color: kPrimaryColor,
                            ),
                          )
                      ),
                    ),
                  )
                ],

              ),

            );
          }
        else
          {
            return const Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Loading',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 33),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffFED7F8),
                        radius: 75*1.5,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffFDB7F2) ,
                          radius:( 75/2)*1.5,
                          child: CircleAvatar(
                            backgroundColor:Color(0xffF900D1) ,
                            radius: 10*1.5,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }


    },
    );
  }
}
