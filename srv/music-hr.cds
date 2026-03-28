using music.store as db from '../db/schema';

service MusicHR 
/*
@(restrict: [
        {
            grant: 'READ',
            to   : 'hr'
        }
    ])
    */
{
    
    entity Employees       as projection on db.Employees;
    entity EmployeeAddress as projection on db.EmployeeAddress;
}