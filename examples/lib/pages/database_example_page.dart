import 'package:wt_action_button/action_process_indicator.dart';
import 'package:wt_app_scaffold_examples/actions/database_action.dart';
import 'package:wt_app_scaffold_examples/models/product.dart';
import 'package:wt_app_scaffold_examples/widgets/product_list_tile.dart';
import 'package:wt_firepod/wt_firepod.dart';

class DatabaseExamplePage extends ConsumerWidget {
  const DatabaseExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databaseAction = ref.read(DatabaseAction.provider);
    final database = ref.read(FirebaseProviders.database);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              databaseAction.component(label: 'Read from Database'),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 200,
                child: databaseAction.indicator(type: IndicatorType.linear),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: FirepodListView(
                  query: database.ref('v1/product').orderByChild('id'),
                  snapshotToModel: Product.from.snapshot,
                  itemBuilder: (product, _, __) => ProductListTile(
                    product: product,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: databaseAction.component(
          floating: true, noLabel: true), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
