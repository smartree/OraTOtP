WHENEVER SQLERROR EXIT SQL.SQLCODE

SET DEFINE ON

SET TERMOUT OFF
WHENEVER SQLERROR CONTINUE
BEGIN
  DVSYS.DBMS_MACADM.DELETE_REALM(REALM_NAME => '&_vUsername');
END;
/
WHENEVER SQLERROR EXIT SQL.SQLCODE
SET TERMOUT ON

BEGIN
  DVSYS.DBMS_MACADM.CREATE_REALM(REALM_NAME => '&_vUsername', DESCRIPTION => 'Control &_vUsername objects access', ENABLED => 'Y', AUDIT_OPTIONS => '1');
  DVSYS.DBMS_MACADM.ADD_OBJECT_TO_REALM(REALM_NAME => '&_vUsername', OBJECT_OWNER => DBMS_ASSERT.ENQUOTE_NAME('&_vUsername', FALSE), OBJECT_NAME => '%', OBJECT_TYPE => '%');
END;
/

prompt Realm created.
