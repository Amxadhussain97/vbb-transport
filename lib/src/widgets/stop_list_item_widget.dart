import 'package:flutter/material.dart';
import 'package:vbb_transport/src/features/departure/departure_page.dart';
import 'package:vbb_transport/src/features/location/location_page.dart';
import '../models/stop_item_model.dart';

class StopsListItemWidget extends StatelessWidget {
  final Function(StopsItemModel) onToggleFavorite;
  final StopsItemModel item;
  final bool isDeletable;

  const StopsListItemWidget({
    Key? key,
    required this.item,
    required this.onToggleFavorite,
    this.isDeletable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = item.products ?? {};

    return GestureDetector( // Wrap with GestureDetector for onTap support
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeparturePage(queryText: item.id ?? ''),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name ?? "",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      children: products.entries
                          .map(
                            (e) => SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                products[e.key] == true
                                    ? Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                )
                                    : Icon(
                                  Icons.cancel,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(e.key),
                              ],
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    )
                  ],
                ),
              ),
              if (isDeletable)
                IconButton(
                  onPressed: () {
                    onToggleFavorite(item);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              else
                IconButton(
                  onPressed: () {
                    onToggleFavorite(item);
                  },
                  icon: Icon(
                    item.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: item.isFavorite
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}