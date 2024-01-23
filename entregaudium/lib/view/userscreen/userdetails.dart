import 'package:entregaudium/utils/colors.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body(){
    return Column(
      children: [
        Expanded(child: Stack(
          children: [
            Positioned(child: Image.asset('assets/images/img_entregador.png',fit: BoxFit.fitHeight,),left: 0, right: 0, bottom: 0, top: 0,),
            Positioned(child: nameLyric(), left: 0, right: 0,bottom: 0,)
          ],
        )),
        Expanded(child: infoUser())
      ],
    );
  }

  Widget nameLyric(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: transparentColor
      ),
      padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Augusto Prado",style: TextStyle(fontFamily: 'OpenSans', fontSize: 24, color: white)),
          Text("Coletor",style: TextStyle(fontFamily: 'OpenSans',fontSize: 16, color: employerColor, fontWeight: FontWeight.w300))
        ],
      ),
    );
  }

  Widget infoUser(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: darkBlue
      ),
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 20),
      child: Column(
        children: [
          Text("Texto do usuário"),
          Expanded(child: Container()),

        ],
      ),
    );
  }

  Widget statistics(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
        ],
      ),
    );
  }

  Widget cart(){
    return Column(
      children: [

      ],
    );
  }
}
