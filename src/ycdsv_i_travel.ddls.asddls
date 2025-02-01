@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Booking Data Root Views'
define root view entity YCDSV_I_TRAVEL
  as select from /dmo/travel_m as Travel
  composition [0..*] of YCDSV_I_BOOKING as _Booking
  association [0..1] to /DMO/I_Agency            as _Agency        on $projection.AgencyId = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer          as _Customer      on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency               as _Currency      on $projection.CurrencyCode = _Currency.Currency
  association [1..1] to /DMO/I_Overall_Status_VH as _OverallStatus on $projection.OverallStatus = _OverallStatus.OverallStatus
{
  key travel_id       as TravelId,
      agency_id       as AgencyId,
      customer_id     as CustomerId,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee     as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price     as TotalPrice,
      currency_code   as CurrencyCode,
      description     as Description,
      overall_status  as OverallStatus,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by as LastChangedBy,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt,
      //* Association //
      _Booking,
      _Agency,
      _Customer,
      _Currency,
      _OverallStatus
}
