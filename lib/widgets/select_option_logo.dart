import 'package:cached_network_image/cached_network_image.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_select/smart_select.dart';

class SelectOptionLogo extends StatelessWidget {
  final bool isLoading;
  final bool isDisabled;
  final bool hasError;
  final bool enableFilter;
  final String modalTitle;
  final String placeholder;
  final String selectText;
  final dynamic value;
  final List<S2Choice> choiceItems;
  final Function(S2SingleState) onChange;
  final S2ModalType modalType;

  const SelectOptionLogo({
    Key key,
    this.isLoading = false,
    this.isDisabled = false,
    this.hasError = false,
    this.enableFilter = false,
    this.modalTitle = 'Opções',
    this.placeholder = 'Escolher',
    this.selectText = 'Selecionar',
    @required this.value,
    @required this.choiceItems,
    @required this.onChange,
    this.modalType = S2ModalType.fullPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return SmartSelect.single(
      modalConfig: S2ModalConfig(filterAuto: true, useFilter: enableFilter),
      modalType: modalType,
      modalTitle: modalTitle,
      placeholder: placeholder,
      modalHeaderStyle: S2ModalHeaderStyle(
        textStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      tileBuilder: (context, state) {
        return Ink(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: hasError ? Border.all(color: Colors.red) : null,
            borderRadius: BorderRadius.circular(4),
          ),
          child: InkWell(
            onTap: isLoading || isDisabled ? null : () => state.showModal(),
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectText,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        state.valueTitle?.toUpperCase() ?? placeholder,
                        style: TextStyle(
                          fontSize: 12,
                          color: state.valueTitle != null ? Colors.blue : Colors.grey[600],
                          fontWeight: state.valueTitle != null ? FontWeight.bold : FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                  isLoading
                      ? SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey[500]),
                            strokeWidth: 2.5,
                          ),
                        )
                      : Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[500],
                        ),
                ],
              ),
            ),
          ),
        );
      },
      choiceConfig: S2ChoiceConfig(
        useDivider: true,
        headerStyle: S2ChoiceHeaderStyle(
          textStyle: TextStyle(color: Colors.red),
        ),
      ),
      choiceStyle: S2ChoiceStyle(
        color: Colors.blue,
        activeColor: Colors.blue,
      ),
      value: value,
      choiceSubtitleBuilder: (context, choice, sub) => Text('description'),
      choiceTitleBuilder: (context, choice, title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(choice.title),
          SizedBox(
              height: 30,
              child: CachedNetworkImage(
                imageUrl:
                    'http://procuraonline-dev.pt/assets/img/logos/${removeDiacritics(choice.title.replaceAll(RegExp(' '), '-'))}.png',
                fit: BoxFit.contain,
              )),
        ],
      ),
      choiceItems: choiceItems,
      onChange: onChange,
    );
  }
}
