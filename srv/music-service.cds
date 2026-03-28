using music.store as db from '../db/schema';
using {API_BUSINESS_PARTNER as s4} from './external/API_BUSINESS_PARTNER.cds';

//using { sap.common.CodeList } from '@sap/cds/common';

service BusinessPartner {

    entity A_BusinessPartner as
        projection on s4.A_BusinessPartner {
            key BusinessPartner,
                BusinessPartnerFullName
        };

}

service MusicService @(requires: 'authenticated-user') {
    entity Instruments      as projection on db.Instruments;
    entity InstrumentModels as projection on db.InstrumentModels;
    entity Parts            as projection on db.Parts;
    entity InstrumentParts  as projection on db.InstrumentModelsParts;
    entity Employees        as projection on db.Employees;
    entity RepairIncidents  as projection on db.RepairIncidents
    actions {
        action assignTechnician(employeeID : UUID) returns String;
    };

    function dispSupp(myString: String) returns String;

}
annotate MusicService.Parts : unitPrice with @assert: (case
                                                         when unitPrice < 0
                                                              then 'Negative price not allowed'
                                                         when unitPrice > 1000
                                                              then 'Too expensive'
                                                     end);

/*
service HR @(restrict: [
        {
            grant: 'READ',
            to   : 'hr'
        }
    ])
{
    
    entity Employees       as projection on db.Employees;
    entity EmployeeAddress as projection on db.EmployeeAddress;
}

service Technician {
    entity Instruments     as projection on db.Instruments;
    entity InstrumentModel as projection on db.InstrumentModels;
    entity Parts           as projection on db.Parts;
    entity InstrumentParts as projection on db.InstrumentModelsParts;
    entity RepairIncidents as projection on db.RepairIncidents;
}


annotate MusicService.Instruments with @(odata.draft.enabled);

annotate Technician.Parts : unitPrice with @assert: (case
                                                         when unitPrice < 0
                                                              then 'Negative price not allowed'
                                                         when unitPrice > 1000
                                                              then 'Too expensive'
                                                     end);                                              
*/