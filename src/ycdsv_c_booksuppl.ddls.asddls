@EndUserText.label: 'Projection booking supplement'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: { headerInfo: { typeName:       'Booking Supplement',
                     typeNamePlural: 'Booking Supplements',
                     title:          { type: #STANDARD,
                                       label: 'Booking Supplement',
                                       value: 'BookingSupplementID' } } }
@Search.searchable: true
define view entity YCDSV_C_BOOKSUPPL
  as projection on YCDSV_I_BOOKSUPPL
{
      @UI.facet: [ { id:              'BookingSupplement',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Booking Supplement',
                     position:        10 }  ]

      @Search.defaultSearchElement: true
  key TravelId,
      @Search.defaultSearchElement: true
  key BookingId,
      @UI: { lineItem:       [ { position: 10, importance: #HIGH } ],
             identification: [ { position: 10 } ] }
  key BookingSupplementId,
      @UI: { lineItem:       [ { position: 20, importance: #HIGH } ],
            identification: [ { position: 20 } ] }
      @Consumption.valueHelpDefinition: [
          {  entity: {name: '/DMO/I_Supplement_StdVH', element: 'SupplementID' },
             additionalBinding: [ { localElement: 'Price',        element: 'Price',        usage: #RESULT },
                                  { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT }],
             useForValidation: true }
        ]
      @ObjectModel.text.element: ['SupplementDescription']
      SupplementId,
      _SupplementText.Description as SupplementDescription : localized,
      @UI: { lineItem:       [ { position: 30, importance: #HIGH } ],
            identification: [ { position: 30 } ] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_CurrencyStdVH', element: 'Currency' }, useForValidation: true }]
      CurrencyCode,
      @UI.hidden: true
      LastChangedAt,
      /* Associations */
      _Travel  : redirected to YCDSV_C_TRAVEL_PROCESSOR,
      _Booking : redirected to parent YCDSV_C_BOOKING_PROCESSOR,
      _Product
}
