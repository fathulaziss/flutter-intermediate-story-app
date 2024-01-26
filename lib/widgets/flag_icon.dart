import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_intermediate_story_app/data/model/localization_model.dart';
import 'package:flutter_intermediate_story_app/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class FlagIcon extends StatelessWidget {
  const FlagIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(Icons.flag, color: Colors.white),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = LocalizationModel.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            onTap: () {
              Provider.of<LocalizationProvider>(context, listen: false)
                  .setLocale(locale);
            },
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
