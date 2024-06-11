import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';

import '../Widgets/NavBar.dart';
import '../../Routes/PageNames.dart';
import '../../Models/User.dart';
import '../../Controllers/UserController.dart';
import '../../Controllers/AuthController.dart';

class DataUsers extends StatelessWidget {
  DataUsers({super.key});
  final userC = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: "Data Users"),
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
                      Get.toNamed(PageNames.AddUser);
                      userC.isRoot.value = true;
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
                              "TAMBAH USER",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )))),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<UserController>(
              builder: (userC) {
                return Expanded(
                  child: DataTable2(
                    columnSpacing: 1,
                    border: const TableBorder(),
                    columns: const [
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('Username')),
                      DataColumn(label: Text('Level')),
                      DataColumn(label: Text('PBSI')),
                      DataColumn(label: Text('Aksi')),
                    ],
                    rows:
                        List<DataRow>.generate(userC.totalUser.value, (index) {
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
                          Text("${data.pbsi}"),
                        ),
                        DataCell(
                          GetBuilder<AuthController>(
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
                                          userC.deleteUser(data.id!, data.email!);
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ]);
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
