------------------------------------------------------------------
--  VIEW v_organ
------------------------------------------------------------------

CREATE OR REPLACE VIEW v_organ
AS
     SELECT DISTINCT o.or_id,
                     o.or_address,
                     o.or_englishname,
                     o.or_latitude,
                     o.or_longitude,
                     o.or_name,
                     o.or_no,
                     o.or_sname,
                     o.or_type,
                     o.or_zipcode,
                     o.pid,
                     o.or_sort AS or_sort,
                     concat(100 + ifnull(o4.or_sort, 0),
                            100 + ifnull(o3.or_sort, 0),
                            100 + ifnull(o2.or_sort, 0),
                            100 + ifnull(o1.or_sort, 0),
                            100 + o.or_sort)
                        AS oo_sort
       FROM c_organ o
                LEFT JOIN c_organ o1 ON o.pid = o1.or_id
               LEFT JOIN c_organ o2 ON o1.pid = o2.or_id
              LEFT JOIN c_organ o3 ON o2.pid = o3.or_id
             LEFT JOIN c_organ o4 ON o3.pid = o4.or_id
   ORDER BY oo_sort;