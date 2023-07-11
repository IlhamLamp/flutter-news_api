import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget articalItem(article , context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image:NetworkImage('${article['urlToImage']}'),
            fit: BoxFit.cover,


          ),

        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                '${article['title']}',
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,

                ),
              ),
            ],
          ),
        ),
      )
    ],
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(
    child: Divider(
      height: 10,
      thickness: 2,
      color: Colors.grey,
      indent: 10,
      endIndent: 10,


    ),
  ),
);

Widget articleBuilder(list , context) => ConditionalBuilder(
    condition: list.length>0 ,
    builder:(context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index) => articalItem(list[index],context),
        separatorBuilder: (context,index) => myDivider(),
        itemCount: list.length ) ,
    fallback: (context)=> Center(child: CircularProgressIndicator()));




Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
   Function? onSubmit,
   Function? onChange,
   Function? onTap,
  bool isclicable=true,
  required Function validator,
  required String label,
  required IconData prefix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s)
      {
        onSubmit!(s);
      },
      onChanged: (s)
      {
        onChange!(s);
      },
      // validator
      onTap: ()
      {
        onTap!();
      },
      validator: (s)
      {
        validator(s);
      },
      enabled: isclicable ,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );


void navigateTo(context , widget) => Navigator.push(
  context,
    MaterialPageRoute(builder: (context) => widget)
);
