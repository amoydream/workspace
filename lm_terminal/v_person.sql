--  VIEW v_person
------------------------------------------------------------------

CREATE OR REPLACE VIEW v_person
AS
     SELECT p.pe_id,
            p.pe_name,
            o.or_name,
            concat(o.oo_sort, (100 + p.pe_sort)) AS op_sort,
            p.pe_sort,
            p.pe_address,
            p.pe_birthday,
            p.pe_educational,
            p.pe_homeaddress,
            p.pe_identity,
            p.pe_leader,
            p.pe_nationality,
            p.pe_nativeplace,
            p.pe_political,
            p.pe_profession,
            p.pe_remark,
            p.pe_sex,
            p.pe_type,
            p.pe_workdate,
            p.pe_zipcode,
            p.or_id,
            p.po_id,
            p.pe_poids,
            o.or_type,
            p.pe_del
       FROM (c_organ_person p
             JOIN v_organ o ON ((p.or_id = o.or_id)))
   ORDER BY op_sort