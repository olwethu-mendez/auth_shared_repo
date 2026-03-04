part of '../library.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({
    super.key,
    required this.supportedCodes,
    required this.phoneNumberController,
    required this.countryCodeController,
    required this.localCode,
  });

  final List<String> supportedCodes;
  final TextEditingController phoneNumberController;
  final TextEditingController countryCodeController;
  final String localCode;

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: DropdownButtonFormField<String>(
              // Use the validated localCode
              initialValue: widget.supportedCodes.contains(widget.localCode)
                  ? widget.localCode
                  : widget.supportedCodes.first,
              decoration: InputDecoration(semanticCounterText: "Country Code dropdown field"),
              items: widget.supportedCodes.map((code) {
                return DropdownMenuItem(
                  value: code,
                  child: Row(
                    children: [
                      CountryFlag.fromPhonePrefix(code, theme: const ImageTheme(height: 16, width: 24)),
                      const SizedBox(width: 8),
                      Text(code),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    //widget.localCode = val;
                    widget.countryCodeController.text = val;
                  });
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: widget.phoneNumberController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                labelText: "Phone Number",
                semanticCounterText: "Phone number input field",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
