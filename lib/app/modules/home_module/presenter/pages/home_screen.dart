import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/components/image_picker.dart';
import 'package:flutter_leap_v2/shared/utils/app_state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/stores/avatar_store.dart';
import 'package:loomi_ui_flutter/loomi_ui.dart';

import '../../../../../shared/utils/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageViewController = PageController();
  final store = GetIt.I.get<AvatarStore>();
  @override
  void didChangeDependencies() {
    log(store.appState.toString());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      store.auth();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () async {
              showChooseCameraOrFilesModal(
                context: context,
                imageAdded: (file) async {
                  await store.createAvatar(
                    image: file,
                  );
                  setState(() {});
                },
              );
            },
            child: const Icon(Icons.camera),
          )
        ],
      ),
      backgroundColor: CustomColors.grey20,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Observer(
          builder: (context) {
            return store.appState == AppState.loading
                ? const Center(
                    child: DefaultLoader(
                      color: Colors.red,
                    ),
                  )
                : const Center(
                    child: Text(
                      "Não foi criado nenhum avatar",
                    ),
                  );
          },
        ),
      ),
    );
  }
}
