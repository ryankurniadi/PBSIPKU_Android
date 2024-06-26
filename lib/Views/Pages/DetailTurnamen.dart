import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:pbsipku/Models/User.dart';

import '../../Controllers/UserController.dart';
import '../../Models/Turnamen.dart';
import '../../Controllers/TurnamenContoller.dart';
import '../../Controllers/AuthController.dart';
import '../Widgets/LoadingBarrier.dart';

class DetailTurnamen extends StatelessWidget {
  DetailTurnamen({super.key});
  final authC = Get.find<AuthController>();
  final turC = Get.find<TurnamenController>();
  final userC = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    turC.cekTerdaftar(authC.authUserID.value);
    userC.getPBSIUser(authC.authpbsi.value);
    return SafeArea(
      child: LoadingBarrier(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            //title: const Text("Detail Turnamen"),
            backgroundColor: Colors.transparent,
            elevation: 100,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: GetBuilder<TurnamenController>(
            builder: (_) {
              if (turC.terDaftar.value) {
                return Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "Pengajuan Sudah Dikirim",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                  ),
                );
              }

              return InkWell(
                onTap: () {
                  Get.defaultDialog(
                    title: "Pilih Pasangan",
                    titlePadding: const EdgeInsets.only(top: 10),
                    content: GetBuilder<UserController>(
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            hint: const Text("Pilih Pasangan"),
                            onChanged: (value) {
                              userC.userID2.value = value!;
                            },
                            validator: (value){
                              if(value == null){
                                return "Pasangan Wajib dipilih";
                              }
                              return null;
                            },
                            items: List<DropdownMenuItem>.generate(
                                userC.dataUserPBSI.length, (index) {
                              User data = userC.dataUserPBSI[index];
                              return DropdownMenuItem(
                                value: "${data.id}",
                                child: Text("${data.nama}"),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                    confirm: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                      ),
                      child: const Text("Ajukan Pendaftaran", style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        turC.daftarTur(authC.authUserID.value,
                            userC.userID2.value, authC.authpbsi.value);
                        Get.back();
                      },
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "Ajukan Pendaftaran",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          body: GetBuilder<TurnamenController>(
            builder: (turC) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: turC.dataSatuTur.length,
                itemBuilder: (context, index) {
                  Turnamen data = turC.dataSatuTur[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              title: "Detail Gambar",
                              content: Image.network(data.img!));
                        },
                        child: SizedBox(
                            height: 300,
                            width: Get.width,
                            child: Image.network(
                              data.img!,
                              fit: BoxFit.cover,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: Get.width / 1.18),
                              child: Text(
                                data.nama!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    child: Center(
                                      child: Text(
                                        "${data.level}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "Max Perwakilan ${data.limit} Orang",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Contact Person :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 13),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            data.kontak!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 13),
                                    child: Center(
                                      child: Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: 'Rp. ',
                                                decimalDigits: 0)
                                            .format(data.biaya),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Deskripsi Turnamen: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 14),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.locationDot,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: Get.width / 1.4),
                                            child: Text(
                                              "${data.lokasi}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            HtmlWidget("""${data.ket}"""),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
