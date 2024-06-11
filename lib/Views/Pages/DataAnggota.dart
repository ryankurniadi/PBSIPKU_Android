import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/User.dart';
import '../../Routes/PageNames.dart';
import '../Widgets/NavBar.dart';
import '../../Controllers/AnggotaController.dart';
import '../../Controllers/AuthController.dart';

class DataAnggota extends StatelessWidget {
  DataAnggota({super.key});
  final anggotaC = Get.put(AnggotaController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: NavBar(title: "Data Anggota ${anggotaC.pbsi}"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            //shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            //
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.toNamed(PageNames.AddAnggota);
                        // userC.isRoot.value = true;
                      },
                      child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xff197500), Color(0xff007529)],
                                stops: [0, 1],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "TAMBAH ANGGOTA",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )))),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<AnggotaController>(
                builder: (userC) {
                  return Expanded(
                    child: DataTable2(
                      columnSpacing: 1,
                      border: const TableBorder(),
                      columns: const [
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('Username')),
                        DataColumn(label: Text('Jabatan')),
                        DataColumn(label: Text('Level')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: List<DataRow>.generate(userC.totalUser.value,
                          (index) {
                        User data = userC.dataUser[index];
                        return DataRow(cells: [
                          DataCell(
                            Text("${data.nama}"),
                          ),
                          DataCell(
                            Text("${data.username}"),
                          ),
                          DataCell(
                            Text("${data.level}"),
                          ),
                          DataCell(
                            Text("${data.skill}"),
                          ),
                          DataCell(GetBuilder<AuthController>(
                            builder: (authC) {
                              if (data.email == authC.authEmail.value) {
                                return const SizedBox();
                              } else {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.key),
                                            Text("Reset Password")
                                          ],
                                        )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          anggotaC.deleteUser(data.id!, data.email!);
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                );
                              }
                            },
                          ))
                        ]);
                      }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
