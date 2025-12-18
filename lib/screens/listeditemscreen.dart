import 'package:flutter/material.dart';

import '../data/found_item_repository.dart';
import '../models/found_item.dart';

class ListedItemsScreen extends StatefulWidget {
  const ListedItemsScreen({super.key});

  @override
  State<ListedItemsScreen> createState() => _ListedItemsScreenState();
}

class _ListedItemsScreenState extends State<ListedItemsScreen> {
  late Future<List<FoundItem>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = FoundItemRepository.instance.getAll();
  }

  Future<void> _reload() async {
    setState(() {
      _futureItems = FoundItemRepository.instance.getAll();
    });
  }

  Future<void> _markClaimed(FoundItem item) async {
    await FoundItemRepository.instance.delete(item.id);
    if (mounted) {
      _reload();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item marked as claimed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text('Browse items'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<FoundItem>>(
          future: _futureItems,
          builder: (BuildContext context, AsyncSnapshot<List<FoundItem>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            final List<FoundItem> items = snapshot.data ?? <FoundItem>[];
            if (items.isEmpty) {
              return Center(
                child: Text(
                  'No found items yet',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (BuildContext context, int index) {
                  final FoundItem item = items[index];
                  return _FoundItemCard(
                    item: item,
                    onClaimed: () => _markClaimed(item),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FoundItemCard extends StatelessWidget {
  final FoundItem item;
  final VoidCallback onClaimed;

  const _FoundItemCard({required this.item, required this.onClaimed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.inventory_2_outlined, color: Colors.grey, size: 32),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                if (item.description.isNotEmpty)
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade700, height: 1.2),
                  ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    const Icon(Icons.place_outlined, size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.location.isEmpty ? 'Location not specified' : item.location,
                        style: const TextStyle(color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: onClaimed,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: const Color(0xFF27AE60),
                  ),
                  child: const Text('Mark as claimed'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(item.date, style: const TextStyle(fontSize: 12, color: Colors.black87)),
              Text(item.time, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}


