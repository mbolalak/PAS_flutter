import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/feat_controller.dart';

class featpage extends StatelessWidget {
  featpage({super.key});

  final controller = Get.put(FeatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.listProduk.length,
          itemBuilder: (context, index) {
            final team = controller.listProduk[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: team.strBadge.isNotEmpty
                    ? Image.network(
                        team.strBadge,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.sports_soccer, size: 40),
                      )
                    : const Icon(Icons.sports_soccer, size: 40),
                title: Text(
                  team.strTeam,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(team.strStadium),
              ),
            );
          },
        );
      }),
    );
  }
}
