import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/features/quote/data/models/quote.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote/quote_bloc.dart';

class QuotePageviewWidget extends StatefulWidget {
  const QuotePageviewWidget({required this.quote, super.key});
  final Quote quote;

  @override
  State<QuotePageviewWidget> createState() => _QuotePageviewWidgetState();
}

class _QuotePageviewWidgetState extends State<QuotePageviewWidget> {
  late bool isLiked;
  @override
  void initState() {
    super.initState();
    isLiked = widget.quote.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(-2, -2),
            // color: Colors.white.withOpacity(0.2),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  context.read<QuotesBloc>().add(ToggleLike(widget.quote));
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                child: widget.quote.isLiked
                    ? Icon(
                        Icons.favorite,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Icon(
                        Icons.favorite_border_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.quote.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.quote.author,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ],
          ),
          // Center(
          //     child: Text(
          //   widget.quote.text,
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //       fontSize: 22,
          //       color: Theme.of(context).colorScheme.onPrimaryContainer),
          // )),
        ],
      ),
    );
  }
}
