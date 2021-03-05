import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class SelectOptionMulti extends StatelessWidget {
  final bool isLoading;
  final bool isDisabled;
  final bool hasError;
  final bool enableFilter;
  final String modalTitle;
  final String placeholder;
  final String selectText;
  final List value;
  final List<S2Choice<dynamic>> choiceItems;
  final Function(S2MultiState<dynamic>) onChange;
  final S2ModalType modalType;

  const SelectOptionMulti({
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
    return SmartSelect.multiple(
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectText,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          state.valueTitle?.join(', ') ?? placeholder,
                          style: TextStyle(
                            fontSize: 12,
                            color: state.valueTitle != null ? Colors.blue : Colors.grey[600],
                            fontWeight: state.valueTitle != null ? FontWeight.bold : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
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
