@EndUserText.label: 'Booking Processor Projection Views'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: {
  headerInfo: { typeName: 'Booking',
                typeNamePlural: 'Bookings',
                title: { type: #STANDARD, value: 'BookingID' } } }

@Search.searchable: true
define view entity YCDSV_C_BOOKING_PROCESSOR
  //  provider contract transactional_query
  as projection on YCDSV_I_BOOKING
{
      @UI.facet: [ { id:            'Booking',
                       purpose:       #STANDARD,
                       type:          #IDENTIFICATION_REFERENCE,
                       label:         'Booking',
                       position:      10 },
                     { id:            'BookingSupplement',
                       purpose:       #STANDARD,
                       type:          #LINEITEM_REFERENCE,
                       label:         'Booking Supplement',
                       position:      20,
                       targetElement: '_BookSuppl'} ]

      @Search.defaultSearchElement: true
  key TravelId,
      @UI: { lineItem:       [ { position: 20, importance: #HIGH } ],
               identification: [ { position: 20 } ] }
      @Search.defaultSearchElement: true
  key BookingId,
      @UI: { lineItem:       [ { position: 30, importance: #HIGH } ],
           identification: [ { position: 30 } ] }
      BookingDate,
      @UI: { lineItem:       [ { position: 40, importance: #HIGH } ],
          identification: [ { position: 40 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Customer_StdVH', element: 'CustomerID' }, useForValidation: true}]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      CustomerId,
      _Customer.LastName        as CustomerName,
      @UI: { lineItem:       [ { position: 50, importance: #HIGH } ],
          identification: [ { position: 50 } ] }
      @Consumption.valueHelpDefinition: [
          { entity: {name: '/DMO/I_Flight_StdVH', element: 'AirlineID'},
            additionalBinding: [ { localElement: 'FlightDate',   element: 'FlightDate',   usage: #RESULT},
                                 { localElement: 'ConnectionId', element: 'ConnectionID', usage: #RESULT},
                                 { localElement: 'FlightPrice',  element: 'Price',        usage: #RESULT},
                                 { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT } ],
            useForValidation: true }
        ]
      @ObjectModel.text.element: ['CarrierName']
      CarrierId,
      _Carrier.Name             as CarrierName,
      @UI:{ lineItem:      [{ position: 60 ,importance: #HIGH }],
           identification: [{ position: 60 ,importance: #LOW }]  }
      @Consumption.valueHelpDefinition: [
         { entity:{name: '/DMO/I_Flight_StdVH',element: 'ConnectionID' },
         additionalBinding: [{ localElement: 'FlightDate', element: 'FlightDate',   usage: #RESULT },
                          { localElement: 'CarrierId', element: 'AirlineID',   usage: #FILTER_AND_RESULT},
                          { localElement: 'FlightPrice',element: 'Price',   usage: #RESULT},
                          { localElement: 'CurrencyCode', element: 'CurrencyCode',   usage: #RESULT} ],
                           useForValidation: true } ]
      ConnectionId,
      @UI: { lineItem:       [ { position: 70, importance: #HIGH } ],
       identification: [ { position: 70 } ] }
      @Consumption.valueHelpDefinition: [
          { entity: {name: '/DMO/I_Flight_StdVH', element: 'FlightDate'},
            additionalBinding: [ { localElement: 'CarrierId',    element: 'AirlineID',    usage: #FILTER_AND_RESULT},
                                 { localElement: 'ConnectionId', element: 'ConnectionID', usage: #FILTER_AND_RESULT},
                                 { localElement: 'FlightPrice',  element: 'Price',        usage: #RESULT},
                                 { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT } ],
            useForValidation: true }
        ]
      FlightDate,
      @UI: { lineItem:       [ { position: 80, importance: #HIGH } ],
            identification: [ { position: 80 } ] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_CurrencyStdVH', element: 'Currency' }, useForValidation: true }]
      CurrencyCode,
      @UI: { lineItem:       [ { position: 90, importance: #HIGH, label: 'Status' } ],
       identification: [ { position: 90, label: 'Status' } ],
       textArrangement: #TEXT_ONLY }
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Booking_Status_VH', element: 'BookingStatus' }}]
      @ObjectModel.text.element: ['BookingStatusText']
      BookingStatus,
      @UI.hidden: true
      _BookingStatus._Text.Text as BookingStatusText : localized,
      @UI.hidden: true
      LastChangedAt,
      /* Associations */

      //   _Connection,
      _Travel  :redirected to parent YCDSV_C_TRAVEL_PROCESSOR ,
      _BookSuppl : redirected to composition child YCDSV_C_BOOKSUPPL,
      _Customer,
      _Carrier,
      _BookingStatus
}
