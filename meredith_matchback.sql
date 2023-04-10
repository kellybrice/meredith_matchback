select
    distinct
    c.first_name || ' ' || d.last_name as full_name,
    ' ' as business_name,
    b.address1 as address_line1,
    b.address2 as address_line2,
    b.city as city_name,
    b.state_abbreviation as state_province,
    '\'' || substring(b.zipcode,1,5) as postal_code,have to remove the ' in excel before sending
    a.order_completed_at_date as date_value,
    '' as char_value1,
    '' as char_value2,
    '' as char_value3,
    '' as numeric_value1,
    '' as numeric_value2,
    '' as numeric_value3
from
    elsa.f_orders a
left join
    elsa.dim_billing_address b
on (a.billing_address_id = b.billing_address_id)
left join
    elsa_pii.first_name_map c
on (b.first_name_hash = c.first_name_hash)
left join
    elsa_pii.last_name_map d
on (b.last_name_hash = d.last_name_hash)
where a.order_completed_at_date >= '2022-11-11' and a.order_completed_at_date <= '2023-01-13'
and a.is_free_order = 0
and b.country = 'United States'
--and a.store_id = 1
and b.address1 is not null
