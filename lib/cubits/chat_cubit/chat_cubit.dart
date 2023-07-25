import 'package:chat_app/cubits/chat_cubit/chat_state.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';

class ChatCubit extends Cubit<ChatState>{
  ChatCubit():super(ChatInitial());
  CollectionReference message =
          FirebaseFirestore.instance.collection(kMessagesController);

  void sendMessage({required String data,required var email}){
    message.add(
        {
          kMessages:data,
          kCreatedAt:DateTime.now(),
          'id':email,
        }
    );

  }


  void getMessage(){
    message.orderBy(kCreatedAt,descending: true).snapshots().listen((event) {
      List<Message>messagesData=[];
      for(var doc in event.docs)
        {
          messagesData.add(Message.fromjson(doc));
        }
      emit(ChatSuccess(messages: messagesData));
    });
  }

}