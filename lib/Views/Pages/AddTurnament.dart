import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/NavBar.dart';
import '../../Controllers/TurnamenContoller.dart';


class AddTurnamner extends StatelessWidget {
  AddTurnamner({super.key});
  final _formKey = GlobalKey<FormState>();
  final turC = Get.find<TurnamenController>();
  DateTime? datePick;

  Future<void> _datePick (BuildContext context)async{
    DateTime? datepick = await showDatePicker(
      context: context, 
      initialDate: turC.date.value,
      firstDate: DateTime(DateTime.now().year), 
      lastDate: DateTime(DateTime.now().year+1));
      turC.setDate(datepick!);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: const NavBar(title: "Tambah Turnamen"),
      body: GetBuilder<TurnamenController>(
        builder: (turC) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Nama Turnamen",
                          label: Text("Nama Turnamen")
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Data Wajib Di Isi";
                          }
                        },
                        onSaved: (value){
                          turC.nama.value = value!;
                        },
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        maxLines: null,
                        decoration: const InputDecoration(
                          
                          hintText: "Keterangan",
                          label: Text("Keterangan")
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Data Wajib Di Isi";
                          }
                        },
                        onSaved: (value){
                          turC.ket.value = value!;
                        },
                      ),
                      const SizedBox(height: 10,),
                      const Row(
                        children: [
                          Text("Level Turnamen"),
                        ],
                      ),
                      DropdownButtonFormField(items: const [
                        DropdownMenuItem(
                          child: Text("Level A"),
                          value: "Level A",
                        )
                        ,
                        DropdownMenuItem(
                          child: Text("Level B"),
                          value: "Level B",
                        )
                        ,
                        DropdownMenuItem(
                          child: Text("Level C"),
                          value: "Level C",
                        )
                        ,
                        DropdownMenuItem(
                          child: Text("Level D"),
                          value: "Level D",
                        )
                      ],
                      value: "Level A",
                      onChanged: (value) {
                        print(value);
                      },
                      ),
                      const SizedBox(height: 10,),
                      const Row(
                        children: [
                          Text("Tanggal Turnamen"),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "${turC.dateShow}",
                          suffix: const Icon(Icons.calendar_month),
                        ),
                        readOnly: true,
                        onTap: ()=> _datePick(context),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();

                          turC.addData();
                        }
                      }, child: const Text("Tambah Data")),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    ));
  }
}