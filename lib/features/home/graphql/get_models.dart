String getModelsQuery = r'''
query GetModels($locale: I18NLocaleCode) {
  models(locale: $locale, filters:  {
      business:  {
        title:  {
            gt: "0",    
        }
      },
  }, sort: ["business.createdAt:asc"]) {
    label
    slug,
    }
}
''';
