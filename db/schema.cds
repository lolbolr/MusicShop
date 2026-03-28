namespace music.store;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {
    music.store.InstrumentCategory,
    music.store.InstrumentStatus,
    music.store.PartType,
    music.store.EmployeeRole,
    music.store.IncidentSeverity,
    music.store.IncidentStatus
} from './common.cds';

@assert.unique.Instruments: [serialNumber]
entity Instruments : cuid, managed {
    name         : String                          @mandatory;
    model        : Association to InstrumentModels @mandatory;
    serialNumber : String(60)                      @mandatory;
    purchaseDate : Date;
    status       : InstrumentStatus default 'ACTIVE';
    incidents    : Association to many RepairIncidents
                       on incidents.instrument = $self;
}

@assert.unique.InstrumentModels: [
    modelName,
    version
]
entity InstrumentModels : cuid, managed {
    modelName : String(80);
    version   : Integer;
    category  : InstrumentCategory @mandatory;
    brand     : String(80);
    supplier  : String(10);
    part      : Association to many InstrumentModelsParts
                    on part.instrumentModel = $self;

    virtual instrumentCount: Integer;
}

@assert.unique.Parts: [sku]
entity Parts : cuid, managed {
    name            : String(100) @mandatory;
    partType        : PartType    @mandatory;
    manufacturer    : String(80);
    sku             : String(40)  @mandatory;
    unitPrice       : Decimal(9, 2);
    uom             : String(3) default 'EA';
    quantity        : Integer;
    instrumentModel : Association to many InstrumentModelsParts
                          on instrumentModel.part = $self;
}

@assert.unique.InstrumentModelParts: [
    instrumentModel,
    part
]
entity InstrumentModelsParts : cuid, managed {
    instrumentModel : Association to InstrumentModels @mandatory;
    part            : Association to Parts            @mandatory;
    quantity        : Integer default 1;
}

@assert.unique.Employees: [email]
entity Employees : cuid, managed {
    firstName         : String(60)   @mandatory;
    lastName          : String(60)   @mandatory;
    email             : String(120)  @mandatory;
    phone             : String(30);
    role              : EmployeeRole @mandatory;
    active            : Boolean default true;
    address           : Composition of one EmployeeAddress
                            on address.employee = $self;
    assignedIncidents : Association to many RepairIncidents
                            on assignedIncidents.assignedTo = $self;
}

entity EmployeeAddress : cuid, managed {
    employee   : Association to Employees @mandatory;
    street     : String(120);
    city       : String(60);
    state      : String(60);
    postalCode : String(20);
    country    : String(2);
}

@assert.unique.RepairIncidents: [incidentNo]
entity RepairIncidents : cuid, managed {
    incidentNo  : String(20)                 @mandatory;
    instrument  : Association to Instruments @mandatory;
    assignedTo  : Association to Employees;
    severity    : IncidentSeverity default 'MEDIUM';
    status      : IncidentStatus default 'OPEN';
    summary     : String(200)                @mandatory;
    description : LargeString;
    reportedAt  : Timestamp default $now;
    resolvedAt  : Timestamp;
    relatedBP   : String(10);
}
