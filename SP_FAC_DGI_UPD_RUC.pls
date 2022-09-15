create or replace procedure sp_fac_dgi_upd_ruc(p_id      in number, p_ruc_cedula in varchar2, p_nombre in varchar2, p_dv in varchar2) is
                                                   
 v_exception          exception;
 msg               varchar2(300); 
begin  
    
   begin 
    update tbl_fac_dgi_documents set ruc_cedula = p_ruc_cedula, cliente = p_nombre, dv = p_dv where id = p_id;
   exception      
    when others  then 
    msg:=sqlerrm;
    raise v_exception;
    
   end;

exception
    when v_exception then
        raise_application_error('-20001','Error. No Se ha actualizar RUC/Cedula...VERIFIQUE!. '||msg);
        
end;