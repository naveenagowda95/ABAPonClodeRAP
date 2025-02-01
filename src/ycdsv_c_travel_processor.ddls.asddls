@EndUserText.label: 'Projection View for Processor'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: {
  headerInfo: { typeName: 'Travel',
                typeNamePlural: 'Travels',
                title: { type: #STANDARD, value: 'TravelId' } } }
@Search.searchable: true
define root view entity YCDSV_C_TRAVEL_PROCESSOR
  provider contract transactional_query
  as projection on YCDSV_I_TRAVEL
{
      @UI.facet: [{ id: 'Travel',
                    purpose: #STANDARD,
                    type:  #IDENTIFICATION_REFERENCE,
                    label: 'Travel',
                    position: 10},
                    {
                    id : 'Booking',
                    purpose: #STANDARD,
                    type:  #LINEITEM_REFERENCE,
                    label: 'Booking',
                    position: 20,
                    targetElement: '_Booking'   }]
      @UI: {
      lineItem:       [ { position: 10, importance: #HIGH } ,
          { type: #FOR_ACTION, dataAction: 'copyTravel', label: 'Copy Travel' } ],
      identification: [ { position: 10, label: 'Travel ID' } ] }
      @Search.defaultSearchElement: true
  key TravelId,
      @UI: {
        lineItem:       [ { position: 20, importance: #HIGH } ],
        identification: [ { position: 20 } ],
        selectionField: [ { position: 20 } ] }
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Agency_StdVH', element: 'AgencyID'  }, useForValidation: true }]
      @ObjectModel.text.element: ['AgencyName']
      @Search.defaultSearchElement: true
      AgencyId,
      _Agency.Name              as AgencyName,
      @UI: {
       lineItem:       [ { position: 30, importance: #HIGH } ],
       identification: [ { position: 30 } ],
       selectionField: [ { position: 30 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Customer_StdVH', element: 'CustomerID' }, useForValidation: true}]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      CustomerId,
      _Customer.LastName        as CustomerName,
      @UI: {
       lineItem:       [ { position: 40, importance: #MEDIUM } ],
       identification: [ { position: 40 } ] }
      BeginDate,
      @UI: {
      lineItem:       [ { position: 41, importance: #MEDIUM } ],
      identification: [ { position: 41 } ] }
      EndDate,
      @UI: {
      identification: [ { position: 42 } ] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @UI: {
      lineItem:       [ { position: 43, importance: #MEDIUM } ],
      identification: [ { position: 43, label: 'Total Price' } ] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_CurrencyStdVH', element: 'Currency' }, useForValidation: true }]
      CurrencyCode,
      @UI: {
       identification:[ { position: 46 } ]  }
      Description,
      @UI: {
      lineItem:       [ { position: 50, importance: #HIGH } ],
      identification: [ { position: 45, label: 'Status' } ],
      selectionField: [{ position: 40 }],
      textArrangement: #TEXT_ONLY
      }
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Overall_Status_VH', element: 'OverallStatus' }}]
      @ObjectModel.text.element: ['OverallStatusText']
      OverallStatus,
      @UI.hidden: true
      _OverallStatus._Text.Text as OverallStatusText : localized,
      @UI.hidden: true
      CreatedBy,
      @UI: {
      lineItem: [{ position: 60 }] }
      CreatedAt,
      @UI: {
      identification: [{ position: 70 }] }
      LastChangedBy,
      @UI.hidden: true
      LastChangedAt,
      /* Associations */
      // _Agency,
      _Booking : redirected to composition child YCDSV_C_BOOKING_PROCESSOR,
      _Agency,
      _Currency,
      _Customer,
      _OverallStatus
}
