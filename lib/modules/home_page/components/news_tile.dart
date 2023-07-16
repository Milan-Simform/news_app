import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
 
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Container(
            height: 130,
            width: 130,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withAlpha(200),
            ),
            
            child: Image.network(
              'https://bloximages.newyork1.vip.townnews.com/cadillacnews.com/content/tncms/custom/image/2f32a658-47ab-11e7-abb1-ef25bc001cf2.png?resize=600%2C99',
              width: 200,
              height: 200,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,16,8,16),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Sports',
                    style: Theme.of(context).textTheme.bodyMedium,
                    ), Text('just now',
                    style: Theme.of(context).textTheme.bodyMedium,
                    )],
                  ),
                  Text(
                    'Lorem ipsum very dangerous khiladi ravindra jadeja. Lorem ipsum very dangerous khiladi ravindra jadeja.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    children: [
                      Text('Sports',
                    style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
