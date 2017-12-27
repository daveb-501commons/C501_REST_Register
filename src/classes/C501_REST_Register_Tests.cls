@istest
class C501_REST_Register_Tests {

    static testmethod void C501_REST_All() {

        Test.startTest();

        C501_REST_Register.doPost('', 'email', 'name', true, 'message');
        C501_REST_Register.doPost('source', '', 'name', null, null);
        C501_REST_Register.doPost('source', 'email', '', true, 'message');
        C501_REST_Register.doPost('source', 'email', 'name', true, '');
        C501_REST_Register.doPost('SUPPORT_REQUEST', 'daveb@501commons.org', '', true, 'message');
        C501_REST_Register.doPost('SUPPORT_REQUEST', 'daveb@501commons.org', 'Dave', true, 'message');

        Test.stopTest();
   }
}