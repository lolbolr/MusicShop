using music.store as db from '../db/schema';

service MusicService @(requires: 'authenticated-user') {
    entity Instruments      as projection on db.Instruments;
    entity InstrumentModels as projection on db.InstrumentModels;
    entity Parts            as projection on db.Parts;
    entity InstrumentParts  as projection on db.InstrumentModelsParts;
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