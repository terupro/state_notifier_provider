import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

// クラスの作成（StateNotifier）
class myNotifier extends StateNotifier<List<String>> {
  myNotifier() : super([]);
  // 状態を操作するメソッドを用意
  void addString(String stringToAdd) {
    state = [...state, stringToAdd]; // 上から順番に表示
  }
}

// プロバイダーの作成（StateNotifierProvider）
final myProvider = StateNotifierProvider((ref) => myNotifier());

class MyApp extends ConsumerWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 監視する
    final listOfString = ref.watch(myProvider) as List;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              // 内容の表示
              ...listOfString.map(
                (string) => Text(string),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                // 内容の作成
                ref.read(myProvider.notifier).addString(controller.text);
                controller.text = "";
              },
              icon: const Icon(Icons.add),
            ),
          ],
          title: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'なんか打ち込んでみて',
            ),
          ),
        ),
      ),
    );
  }
}


// StateProviderでは、State変数で状態を管理する