using music.store as db from '../db/schema';

service InvMan {

    entity Parts        as projection on db.Parts;
    entity PartRequests as projection on db.PartRequests
        actions {
            action approve() returns String;
            action reject() returns String;
        };
}

/*
annotate InvMan.PartRequests with @restrict: [
    { grant: 'READ', to: 'inventoryManager' },
    { grant: 'approve', to: 'inventoryManager' },
    { grant: 'reject', to: 'inventoryManager' }
];

annotate InvMan.Parts with @restrict: [
    { grant: 'READ', to: 'inventoryManager' }
];
*/