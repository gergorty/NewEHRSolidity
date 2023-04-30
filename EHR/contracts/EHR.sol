// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract EHR {
    struct Patient {
        uint id;
        string name;
        uint age;
        string gender;
        string bloodType;
        uint[] reportIds;
    }
    
    struct Report {
        uint id;
        string patientName;
        string doctorName;
        string reportType;
        string description;
        string date;
    }
    
    mapping (uint => Patient) public patients;
    mapping (uint => Report) public reports;
    
    uint public patientCount;
    uint public reportCount;
    
    function addPatient(string memory _name, uint _age, string memory _gender, string memory _bloodType) public {
        patientCount++;
        patients[patientCount] = Patient(patientCount, _name, _age, _gender, _bloodType, new uint[](0));
    }
    
    function addReport(string memory _patientName, string memory _doctorName, string memory _reportType, string memory _description, string memory _date) public {
        reportCount++;
        reports[reportCount] = Report(reportCount, _patientName, _doctorName, _reportType, _description, _date);
        patients[patientCount].reportIds.push(reportCount);
    }
    
    function getPatientReportIds(uint _patientId) public view returns (uint[] memory) {
        return patients[_patientId].reportIds;
    }
    
    function getReportById(uint _reportId) public view returns (string memory, string memory, string memory, string memory, string memory) {
        Report memory r = reports[_reportId];
        return (r.patientName, r.doctorName, r.reportType, r.description, r.date);
    }
}
