import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_study/provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp())); //まずここ
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("MyAppの再描画");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build直下の再描画");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer(
                builder: (BuildContext context, WidgetRef ref, child) {
                  print("Consumerウィジェット。第一の数字の再描画");
                  final int firstCounter = ref.watch(firstCountProvider);
                  return Text(
                    '$firstCounter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              ElevatedButton(
                  onPressed: () =>
                      ref.read(firstCountProvider.notifier).state++,
                  child: Text("第一のボタン！")),
            ],
          ),
          const SecondButtonWidget(),
                       //ここから
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Builder(builder: (context) {
                    print("Consumerなし。第三の数字の再描画");
                    final int thirdCounter = ref.watch(thirdCountProvider);
                    return Text(
                      '$thirdCounter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  }),
                  ElevatedButton(
                      onPressed: () =>
                          ref.read(thirdCountProvider.notifier).state++,
                      child: Text("第三ボタン")),
                ],
              ),
              //ここまでを追加
        ],
      ),
    );
  }
}

class SecondButtonWidget extends ConsumerWidget {
  const SecondButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Builder(builder: (context) {
          print("Consumerなし。第二の数字の再描画");
          final int secondCounter = ref.watch(secondCountProvider);
          return Text(
            '$secondCounter',
            style: Theme.of(context).textTheme.headlineMedium,
          );
        }),
        ElevatedButton(
            onPressed: () => ref.read(secondCountProvider.notifier).state++,
            child: Text("第二のボタン！"))
      ],
    );
  }
}
