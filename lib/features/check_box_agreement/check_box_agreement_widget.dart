import 'package:flutter/material.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/features/check_box_agreement/check_box_agreement_manager.dart';
import 'package:alsurrah/app_core/app_core.dart';

class CheckBoxAgreement extends StatelessWidget {
  const CheckBoxAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkBoxManager = context.use<CheckBoxManager>();

    return Container(
      margin:const EdgeInsets.only(top: 50),
      child: InkWell(
        onTap: (){
          checkBoxManager.switchStatus();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<bool>(
              initialData: false,
              stream: checkBoxManager.checkBox$,
              builder: (context, snapshot) {
                return Container(
                  height: 20,
                  width: 20,
                  // padding:const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: snapshot.data! ? Colors.greenAccent.withOpacity(.2):Colors.redAccent.withOpacity(.2),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.withOpacity(.8)),
                  ),
                  child: Center(
                    child: snapshot.data! ? const Icon(Icons.check,size: 15,) : const SizedBox(),
                  ),
                );
              }
            ),

            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Text("اقر واتعهد بصحه البيانات في البطاقه المدنيه وأني مساهم حاليا بجمعية السرة التعاونية واقر انا بياناتي صالحة",style: AppFontStyle.descFont,))
          ],
        ),
      ),
    );
  }
}
