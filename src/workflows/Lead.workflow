<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Vroom_Admin_Web_Lead_Support_Request_Email_Alert</fullName>
        <ccEmails>hello@vroom.org</ccEmails>
        <description>Vroom Admin Web Lead Support Request Email Alert</description>
        <protected>false</protected>
        <senderAddress>hello@vroom.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/VroomAdmin_Text_EmailTemplate</template>
    </alerts>
    <alerts>
        <fullName>Vroom_Web_Lead_Support_Request_Email_Alert</fullName>
        <description>Vroom Web Lead Support Request Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>hello@vroom.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Vroom_Text_EmailTemplate</template>
    </alerts>
</Workflow>
