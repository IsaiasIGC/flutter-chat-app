import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/pages/pages.dart';


class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
   );
  }

  Future checkLoginState( BuildContext context) async {

    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if ( autenticado ) {
      // todo
      // Navigator.pushReplacementNamed(context, 'usuarios');
      if ( context.mounted ) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: ( _, __, ___ ) => const UsuariosPage(),
            transitionDuration: const Duration(milliseconds: 0)
          ));
      }
    } else {
      if ( context.mounted ) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: ( _, __, ___ ) => const LoginPage(),
            transitionDuration: const Duration(milliseconds: 0)
          ));
      }
    }

  }

}