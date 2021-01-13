import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class SelectOption extends StatelessWidget {
  final bool isLoading;
  final bool isDisabled;
  final bool hasError;
  final bool enableFilter;
  final String modalTitle;
  final String placeholder;
  final String selectText;
  final String value;
  final List<S2Choice<String>> choiceItems;
  final Function(S2SingleState<String>) onChange;

  const SelectOption({
    Key key,
    this.isLoading = false,
    this.isDisabled = false,
    this.hasError = false,
    this.enableFilter = false,
    this.modalTitle = 'Options',
    this.placeholder = 'Choose one',
    this.selectText = 'Select an option',
    @required this.value,
    @required this.choiceItems,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.single(
      modalConfig: S2ModalConfig(filterAuto: true, useFilter: enableFilter),
      modalType: S2ModalType.fullPage,
      modalTitle: modalTitle,
      placeholder: placeholder,
      modalHeaderStyle: S2ModalHeaderStyle(
        textStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      tileBuilder: (context, state) {
        return GestureDetector(
          onTap: isLoading || isDisabled ? null : () => state.showModal(),
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: hasError ? Border.all(color: Colors.red) : null,
              borderRadius: BorderRadius.circular(4),
            ),
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
                        state.valueTitle ?? placeholder,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
      choiceItems: choiceItems,
      onChange: onChange,
    );
  }
}
