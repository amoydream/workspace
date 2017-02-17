------------------------------------------------------------------
--  TABLE c_address_book
------------------------------------------------------------------

CREATE TABLE c_address_book
(
   bo_id         int(11),
   bo_index      int(11),
   bo_number     varchar(20),
   bo_remark     varchar(100),
   bo_state      varchar(1),
   bo_type       varchar(1),
   bo_usertype   varchar(1),
   or_id         int(11),
   pe_id         int(11)
);


