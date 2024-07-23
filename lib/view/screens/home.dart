import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Quotogram",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Get.toNamed("favorite_page");
                },
                icon: Icon(
                  Icons.favorite,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        body: LocalQuote(),
      ),
    );
  }
}

class LocalQuote extends StatefulWidget {
  const LocalQuote({super.key});

  @override
  State<LocalQuote> createState() => _LocalQuoteState();
}

class _LocalQuoteState extends State<LocalQuote> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Obx(
          () => IndexedStack(
            index: controller.cindex.value,
            children: [
              ListView.builder(
                itemCount: controller.qList.isNotEmpty
                    ? controller.qList[0].happiness?.length ?? 0
                    : 0,
                itemBuilder: (context, index) {
                  var qqList = controller.qList[0].happiness;

                  return InkWell(
                    onTap: () {
                      Get.toNamed("detail", arguments: [qqList[index], index]);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      height: 100,
                      color: Colors.black12,
                      child: Center(
                        child: Text(
                          qqList![index],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}