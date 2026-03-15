namespace music.store;

type InstrumentCategory : String enum{
    GUITAR; VIOLIN; FLUTE; DRUMS; OTHERS;
};

type InstrumentStatus : String enum{
    ACTIVE; IN_REPAIR; RETIRED;
};

type PartType : String enum{
    STRING; REED; OTHER;
};
type EmployeeRole : String enum{
    SALES; REPAIR; MANAGER;
};
type IncidentSeverity : String enum{
    LOW; MEDIUM; HIGH; CRITICAL;
};
type IncidentStatus : String enum{
    OPEN; IN_PROGRESS; RESOLVED; CANCELED;
};

