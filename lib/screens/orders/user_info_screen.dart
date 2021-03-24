import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:octo_image/octo_image.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoScreen extends StatelessWidget {
  final int profileId = Get.arguments['profileId'] ?? 0;
  final String avatar = Get.arguments['avatar'] ?? '';
  final String name = Get.arguments['name'] ?? 'Indisponível';
  final String address = Get.arguments['address'] ?? 'Indisponível';
  final String phone = Get.arguments['phone'] ?? 'Indisponível';
  final String email = Get.arguments['email'] ?? 'Indisponível';
  final String register = Get.arguments['register'] ?? 'Indisponível';

  void _launch(url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do utilizador'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: OctoImage(
                    width: 170,
                    height: 170,
                    image: CachedNetworkImageProvider(avatar),
                    placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                    errorBuilder: OctoError.icon(color: Colors.grey[400]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Center(
                  child: Text(
                    'DETALHES',
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ListTile(
                title: Text('Endereço'),
                subtitle: Text(address),
                trailing: Icon(Icons.location_on),
                onTap: () => MapsLauncher.launchQuery(address),
              ),
              Divider(),
              ListTile(
                title: Text('Contacto telefónico'),
                subtitle: Text(phone),
                trailing: Icon(Icons.phone),
                onTap: () => _launch('tel:$phone'),
              ),
              Divider(),
              ListTile(
                  title: Text('Email'),
                  subtitle: Text(email),
                  trailing: Icon(Icons.mail),
                  onTap: () => _launch(
                        Uri(
                          scheme: 'mailto',
                          path: email,
                          queryParameters: {'subject': 'Contacto de ProcuraOnline'},
                        ).toString(),
                      )),
              Divider(),
              ListTile(
                title: Text('Registrado desde'),
                subtitle: Text(register),
                trailing: Icon(Icons.calendar_today),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
