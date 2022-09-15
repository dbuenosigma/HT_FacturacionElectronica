CREATE OR REPLACE PROCEDURE SP_FAC_UPD_DATOS_CLIENTE_FE(P_DOC_ID VARCHAR2, P_COMPANIA VARCHAR2, P_RUC VARCHAR2, P_DV VARCHAR2, P_DIRECCION VARCHAR2, P_TELEFONO VARCHAR2, P_EMAIL VARCHAR2, P_COD_UBICACION VARCHAR2) AS
  
  L_DESCRIPCION VARCHAR2(200);
  L_CLIENT_ID   VARCHAR2(50);
  L_RUC         VARCHAR2(50);
  
BEGIN
  
  SELECT DESCRIPCION, CLIENT_ID, RUC
    INTO L_DESCRIPCION, L_CLIENT_ID, L_RUC
    FROM tbl_fac_trx a, tbl_fac_tipo_cliente b
   where a.client_ref_id = b.codigo
     and other3 in (SELECT CODIGO FROM TBL_FAC_DGI_DOCUMENTS
                       WHERE ID = P_DOC_ID
                         AND COMPANIA = P_COMPANIA)
     AND COMPANY_ID = P_COMPANIA
     AND ROWNUM = 1
  ;
    
  IF (L_DESCRIPCION = 'MEDICO') THEN
    UPDATE TBL_ADM_MEDICO
       SET IDENTIFICACION = P_RUC
         , DIGITO_VERIFICADOR = P_DV
         , DIRECCION = P_DIRECCION
         , TELEFONO = P_TELEFONO
         , E_MAIL = P_EMAIL
         , CODIGO_UBICACION_FE = P_COD_UBICACION
     WHERE CODIGO = L_CLIENT_ID;
     COMMIT;
  ELSIF (L_DESCRIPCION = 'ASEGURADOS' OR L_DESCRIPCION = 'EMPRESA - CUENTAS HOSPITAL') THEN
    UPDATE TBL_ADM_EMPRESA
       SET RUC = P_RUC
         , DIGITO_VERIFICADOR = P_DV
         , DIRECCION = P_DIRECCION
         , TELEFONO = P_TELEFONO
         , E_MAIL = P_EMAIL
         , CODIGO_UBICACION_FE = P_COD_UBICACION
     WHERE CODIGO = L_CLIENT_ID;
     COMMIT;
  ELSIF (L_DESCRIPCION = 'EMPLEADOS' OR L_DESCRIPCION = 'EMPLEADO') THEN
    UPDATE TBL_PLA_EMPLEADO
       SET DIGITO_VERIFICADOR = P_DV
         , CASA__DIR = P_DIRECCION
         , TELEFONO_CASA = P_TELEFONO
         , EMAIL = P_EMAIL
         , CODIGO_UBICACION_FE = P_COD_UBICACION
     WHERE PROVINCIA || '-' || SIGLA || '-' || TOMO || '-' || ASIENTO = P_RUC;
    COMMIT;
  ELSIF (L_DESCRIPCION = 'CTAS X COBRAR OTROS') THEN
    UPDATE TBL_ADM_PACIENTE
       SET DIGITO_VERIFICADOR = P_DV
         , RESIDENCIA_DIRECCION = P_DIRECCION
         , TELEFONO = P_TELEFONO
         , E_MAIL = P_EMAIL
         , CODIGO_UBICACION_FE = P_COD_UBICACION
     WHERE PROVINCIA || '-' || TOMO || '-' || ASIENTO = P_RUC;
     COMMIT;
  END IF;
 EXCEPTION
    WHEN OTHERS THEN NULL;
END SP_FAC_UPD_DATOS_CLIENTE_FE;