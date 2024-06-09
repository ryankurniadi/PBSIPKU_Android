import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/NavBar.dart';
import '../../Controllers/PBSIController.dart';

class AddPBSI extends StatelessWidget {
  AddPBSI({super.key});
  final _formKey = GlobalKey<FormState>();
  final pbsiC = Get.find<PBSIController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const NavBar(title: "Data PBSI Pekanbaru"),
        body: ListView(
          children: [
            const Center(
              child: Text("TAMBAH DATA PBSI"),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width/3),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Wajib Di Isi";
                        }
                        return null;
                      },
                      onSaved: (value){
                        pbsiC.nama.value = value!;
                      },
                      decoration: const InputDecoration(
                        hintText: "Nama PBSI",
                        label: Text("Nama PBSI")
                      ),
                      
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();

                            pbsiC.addData();
                            
                          }
                        }, child: const Text("TAMBAH DATA"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
