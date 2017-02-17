------------------------------------------------------------------
--  VIEW v_contact
------------------------------------------------------------------

CREATE OR REPLACE VIEW v_contact
AS
   SELECT concat('P_', p.pe_id) AS contact_id,
          p.pe_name AS pe_name,
          p.or_name AS or_name,
          p.op_sort AS c_sort,
          'P' AS contact_type,
          b1.bo_number AS tel_office,
          b2.bo_number AS tel_mobile,
          b3.bo_number AS fax_number,
          b4.bo_number AS email,
          b5.bo_number AS tel_home,
          concat('null',
                 ifnull(b1.bo_number, ''),
                 ifnull(b2.bo_number, ''),
                 ifnull(b3.bo_number, ''),
                 ifnull(b4.bo_number, ''),
                 ifnull(b5.bo_number, ''))
             AS null_number,
          concat(',',
                 ifnull(b1.bo_number, ''),
                 ',',
                 ifnull(b2.bo_number, ''),
                 ',',
                 ifnull(b3.bo_number, ''),
                 ',',
                 ifnull(b4.bo_number, ''),
                 ',',
                 ifnull(b5.bo_number, ''),
                 ',')
             AS tel_number,
          b1.bo_id AS bo_id_1,
          b1.bo_state AS bo_state_1,
          b2.bo_id AS bo_id_2,
          b2.bo_state AS bo_state_2,
          b3.bo_id AS bo_id_3,
          b3.bo_state AS bo_state_3,
          b4.bo_id AS bo_id_4,
          b4.bo_state AS bo_state_4,
          b5.bo_id AS bo_id_5,
          b5.bo_state AS bo_state_5,
          p.pe_id AS pe_id,
          p.pe_poids AS pe_poids,
          p.pe_type AS pe_type,
          p.or_type AS or_type,
          p.pe_del AS pe_del,
          p.or_id AS or_id
     FROM v_person p
               LEFT JOIN c_address_book b1
                  ON     b1.pe_id = p.pe_id
                       AND b1.bo_usertype = 1
                       AND b1.bo_type = 1
              LEFT JOIN c_address_book b2
                 ON     b2.pe_id = p.pe_id
                      AND b2.bo_usertype = 1
                      AND b2.bo_type = 2
             LEFT JOIN c_address_book b3
                ON     b3.pe_id = p.pe_id
                     AND b3.bo_usertype = 1
                     AND b3.bo_type = 3
            LEFT JOIN c_address_book b4
               ON     b4.pe_id = p.pe_id
                    AND b4.bo_usertype = 1
                    AND b4.bo_type = 4
           LEFT JOIN c_address_book b5
              ON     b5.pe_id = p.pe_id
                   AND b5.bo_usertype = 1
                   AND b5.bo_type = 5
   UNION
   SELECT concat('O_', o.or_id) AS contact_id,
          o.or_name AS pe_name,
          o.or_name AS or_name,
          concat(o.oo_sort, 1000) AS c_sort,
          'O' AS contact_type,
          b1.bo_number AS tel_office,
          NULL AS tel_mobile,
          b3.bo_number AS fax_number,
          b4.bo_number AS email,
          NULL AS tel_home,
          concat('null',
                 ifnull(b1.bo_number, ''),
                 ifnull(b3.bo_number, ''),
                 ifnull(b4.bo_number, ''))
             AS null_number,
          concat(',',
                 ifnull(b1.bo_number, ''),
                 ',',
                 ifnull(b3.bo_number, ''),
                 ',',
                 ifnull(b4.bo_number, ''),
                 ',')
             AS tel_number,
          b1.bo_id AS bo_id_1,
          b1.bo_state AS bo_state_1,
          NULL AS bo_id_2,
          NULL AS bo_state_2,
          b3.bo_id AS bo_id_3,
          b3.bo_state AS bo_state_3,
          b4.bo_id AS bo_id_4,
          b4.bo_state AS bo_state_4,
          NULL AS bo_id_5,
          NULL AS bo_state_5,
          NULL AS pe_id,
          NULL AS pe_poids,
          NULL AS pe_type,
          o.or_type AS or_type,
          NULL AS pe_del,
          o.or_id AS or_id
     FROM v_organ o
             LEFT JOIN c_address_book b1
                ON    b1.or_id = o.or_id
                     AND b1.bo_usertype = 2
                     AND b1.bo_type = 1
            LEFT JOIN c_address_book b3
               ON    b3.or_id = o.or_id
                    AND b3.bo_usertype = 2
                    AND b3.bo_type = 3
           LEFT JOIN c_address_book b4
              ON     b4.or_id = o.or_id
                   AND b4.bo_usertype = 2
                   AND b4.bo_type = 4

