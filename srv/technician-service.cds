using music.store as db from '../db/schema';

service TechnicianService {
    @readonly
    entity Instruments      as projection on db.Instruments;

    @readonly
    entity InstrumentModels as projection on db.InstrumentModels;

    entity Parts            as projection on db.Parts
        actions {
            action reqParts(quantity: Integer) returns String;
        };

    @readonly
    entity InstrumentParts  as projection on db.InstrumentModelsParts;

    entity RepairIncidents  as projection on db.RepairIncidents
    actions {
        action inprog() returns String;
        action onhold() returns String;
        action resolved() returns String;
        action cancelled() returns String;
    }
    ;

    @readonly
    entity RepairParts      as projection on db.RepairParts;

    @readonly
    entity PartRequests as projection on db.PartRequests;
}

/*
annotate TechnicianService.Parts with @restrict: [
    {
        grant: 'READ',
        to   : 'technician'
    },
    {
        grant: 'reqParts',
        to   : 'technician'
    }
];
*/