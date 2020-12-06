import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/repository/auth_repository.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogoutDialog extends StatelessWidget {

  final GetSizeConfig sizeConfig = Get.find();
  final AuthRepository authController = Get.find();
  final GetStorage localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Confirm Logout?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizeConfig.getSize(28)
              ),
            ),
          ),
          SizedBox(height: sizeConfig.height * 15,),
          Container(
            height: sizeConfig.height * 80,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[400],width: 2),
                )
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey[400],width: 2),
                          )
                      ),
                      child: Center(
                        child: Text(
                          'No',
                          style: TextStyle(
                              fontSize: sizeConfig.getSize(22)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      authController.signOut();
                      localStorage.remove('userValues');
                      localStorage.erase();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey[400],width: 2),
                          )
                      ),
                      child: Center(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              fontSize: sizeConfig.getSize(22)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
