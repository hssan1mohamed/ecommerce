import 'package:ecommerce_training/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controllers/profile_cubit/profile_cubit.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).getUserData();
    return  Scaffold(
        appBar: MyCustomAppBar(text: 'User Profile',),
    body: BlocConsumer<ProfileCubit,ProfileState>(
        listener:(context,state){},
        builder:(context,state) {
          var cubit = ProfileCubit.get(context);
          var data = cubit.profileModel!.user!;
          if (state is LoadingProfile) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorGetUserData) {
            return const Center(child: Text('there is error'),);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                       data.profileImage!),
                  ),
                  SizedBox(height: 20),
                  Text(
                    data.name!,
                    style:TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data.gender!,
                    style:TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                     data.email!,
                      style: TextStyle(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      '+02 ${data.phone!}',
                      style:TextStyle(),
                    ),
                  ),ListTile(
                    leading: Icon(Icons.perm_identity_sharp),
                    title: Text(
                      data.nationalId! ,
                      style:TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality to edit profile
                      // For example, navigate to an edit profile page
                    },
                    style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        'Edit Profile',
                        style:TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          ;
        }));
  }

}


//   Center(
//   child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//   CircleAvatar(
//   radius: 50,
//   backgroundImage: NetworkImage(
//   data.profileImage!.toString()),
//   ),
//   SizedBox(height: 20),
//   Text(
//   data.name!.toString(),
//   style: TextStyle(
//   fontSize: 24,
//   fontWeight: FontWeight.bold,
//   ),
//   ),
//   SizedBox(height: 20),
//   ListTile(
//   leading: Icon(Icons.email),
//   title: Text(data.email!),
//   ),
//   ListTile(
//   leading: Icon(Icons.phone),
//   title: Text('+02${data.phone!} '),
//   ),
//   SizedBox(height: 20),
//   ElevatedButton(
//   onPressed: () {
//   // Add functionality to edit profile
//   // For example, navigate to an edit profile page
//   },
//   child: Text('Edit Profile'),
//   ),
//   ],
//   ),
//   );
//
// })