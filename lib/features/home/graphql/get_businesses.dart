String getBusinessesQuery = r'''
query GetBusinesses($locale: I18NLocaleCode, $filters: BusinessFiltersInput) {
  businesses(locale: $locale, filters: $filters) {
    title
    description
    model {
      label
    }
    content
    image {
      url {
        url
      }
    }
  }
}
''';
