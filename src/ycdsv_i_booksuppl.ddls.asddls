@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Suppliment'
define view entity YCDSV_I_BOOKSUPPL
  as select from /dmo/booksuppl_m as BookingSupplement
  association        to parent YCDSV_I_BOOKING as _Booking        on  $projection.TravelId  = _Booking.TravelId
                                                                  and $projection.BookingId = _Booking.BookingId
  association [1..1] to YCDSV_I_TRAVEL         as _Travel         on  $projection.TravelId = _Travel.TravelId
  association [1..1] to /DMO/I_Supplement      as _Product        on  $projection.SupplementId = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText  as _SupplementText on  $projection.SupplementId = _SupplementText.SupplementID
{
  key BookingSupplement.travel_id             as TravelId,
  key BookingSupplement.booking_id            as BookingId,
  key BookingSupplement.booking_supplement_id as BookingSupplementId,
      BookingSupplement.supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingSupplement.price                 as Price,
      BookingSupplement.currency_code         as CurrencyCode,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      BookingSupplement.last_changed_at       as LastChangedAt,
      _Booking,
      _Travel,
      _Product,
      _SupplementText
}
