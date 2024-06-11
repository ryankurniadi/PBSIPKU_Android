import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/AnggotaController.dart';
import '../../Controllers/LoadingController.dart';
import '../Widgets/NavBar.dart';


class AddAnggota extends StatelessWidget {
  AddAnggota({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: NavBar(title: "Add User"),
      body: GetBuilder<LoadingController>(
        builder: (loadC) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GetBuilder<AnggotaController>(builder: (userC) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Nama Lengkap"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Nama Wajib Di Isi";
                        }
                      },
                      onSaved: (value) {
                        userC.nama.value = value!;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "E-mail",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "E-mail Wajib Di Isi";
                        }
                        if (!EmailValidator.validate(value)) {
                          return "Format E-mail Tidak Valid";
                        }
                      },
                      onSaved: (value) {
                        userC.email.value = value!;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),const Row(
                      children: [
                        Text("Level Pemain"),
                      ],
                    ),
                    DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem(
                          value: "Level A",
                          child: Text("Level A"),
                        ),
                        DropdownMenuItem(
                          value: "Level B",
                          child: Text("Level B"),
                        ),
                        DropdownMenuItem(
                          value: "Level C",
                          child: Text("Level C"),
                        ),
                        DropdownMenuItem(
                          value: "Level D",
                          child: Text("Level D"),
                        )
                      ],
                      value: "Level D",
                      onChanged: (value) {
                        userC.skill.value = value!;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        userC.addAnggota();
                      }
                    }, child: const Text("Tambah Anggota")),
                  ],
                ),
              );
            }),
          );
        }
      ),
    );
  }
}
