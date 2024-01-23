import 'package:entregaudium/model/responsedata.dart';
import 'package:entregaudium/utils/colors.dart';
import 'package:entregaudium/viewmodel/userdetails/userdetails_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/*
* Foi criada uma nova tela para mostrar os detalhes do usuário na aplicação.
* */
class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late final viewModel;
  ResponseData? response;


  @override
  Widget build(BuildContext context) {
    viewModel  = Provider.of<UserDetailsViewModel>(context);

    return Scaffold(
      body: FutureBuilder(
        future: viewModel.fetchData(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Container();
          }else if(snapshot.hasError || !snapshot.hasData){
            return Container();
          }else{
            //Assim que lido, o dado é armazenado para que seja consumido.
            response = viewModel.apiResponse.response;
            return body();
          }
        },
      ),
    );
  }


  /*
  * O body se preocupa com a estrutura geral da tela, que está primariamente
  * dividida em duas partes:
  * -> Parte de cima com a foto, o nome e a profissão do usuário
  * -> Parte de baixo com a descrição e feedbacks do usuário
  *
  * A foto do usuário, conforme determinado, é estática e se posiciona
  * conforme a altura da foto, sem causar dismorfias.
  *
  * A foto é sobreposta por um pequeno container com transparência conforme
  * determinado na descrição do aplicativo.
  * */
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
          Text("${response!= null? response!.nome : "Nome do usuário"}",style: TextStyle(fontFamily: 'OpenSans', fontSize: 24, color: white)),
          Text("${response!= null? response!.cargo: "Cargo do usuário"}",style: TextStyle(fontFamily: 'OpenSans',fontSize: 16, color: employerColor, fontWeight: FontWeight.w300))
        ],
      ),
    );
  }


  /*
  * As informações e ícones devem ser responsivos, obedecendo às dimensões
  * do aplicativo que está o executando.
  * */
  Widget infoUser(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: darkBlue
      ),
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${response != null? response!.descricao : "Texto do usuário."}", style: TextStyle(color: descriptionColor, fontSize: 15),),
          Expanded(child: Container()),
          statistics()
        ],
      ),
    );
  }

  Widget statistics(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(child: cart()),
          Container(color: splitter,height: 60, width: 1,),
          Expanded(child: value()),
          Container(color: splitter,height: 60, width: 1,),
          Expanded(child: stars())
        ],
      ),
    );
  }

  Widget cart(){
    return Column(
      children: [
        Image.asset('assets/images/drawable-mdpi/ic_entregas.png'),
        Text("${viewModel.totalDeliveries?? 0}", style: TextStyle(fontSize: 22,color: white),),
        Text("Entregas", style: TextStyle(fontSize: 13,color: white),)
      ],
    );
  }

  Widget value(){
    return Column(
      children: [
        Image.asset('assets/images/drawable-mdpi/ic_saldo.png'),
        Text("R\$ ${viewModel.value.toStringAsFixed(2)}", style: TextStyle(fontSize: 22,color: white),),
        Text("Saldo", style: TextStyle(fontSize: 13,color: white),)
      ],
    );
  }

  Widget stars(){
    return Column(
      children: [
        Image.asset('assets/images/drawable-mdpi/ic_nota.png'),
        Text("${viewModel.feedback?? 0}", style: TextStyle(fontSize: 22,color: white),),
        Text("Nota", style: TextStyle(fontSize: 13,color: white),)
      ],
    );
  }
}
