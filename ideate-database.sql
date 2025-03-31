CREATE DATABASE IDEATE;

USE IDEATE;

CREATE TABLE IF NOT EXISTS General_Member (
    member_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    member_name varchar(50) NOT NULL,
    member_major varchar(20) NOT NULL,
    member_year INTEGER NOT NULL,
    member_email varchar(75) NOT NULL
);

CREATE TABLE IF NOT EXISTS Advisor (
    advisor_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    advisor_name varchar(50) NOT NULL,
    advisor_email varchar(75) NOT NULL
);

CREATE TABLE IF NOT EXISTS Office_Hours (
    session_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    session_date DATE NOT NULL,
    session_startTime DATETIME,
    session_endTime DATETIME,
    advisor_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id)
);

CREATE TABLE IF NOT EXISTS Member_Advisor (
    member_id INTEGER NOT NULL,
    advisor_id INTEGER NOT NULL,
    INDEX member_id_member_advisor (member_id),
    INDEX advisor_id_member_advisor (advisor_id),
    PRIMARY KEY(member_id, advisor_id),
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id),
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id)
);

CREATE TABLE IF NOT EXISTS Group_Meeting (
    meeting_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    meeting_date DATE NOT NULL,
    meeting_startTime DATETIME,
    meeting_endTime DATETIME
);

CREATE TABLE IF NOT EXISTS Member_Meeting (
    member_id INTEGER NOT NULL,
    meeting_id INTEGER NOT NULL,
    INDEX member_id_member_meeting (member_id),
    INDEX meeting_id_member_meeting (meeting_id),
    PRIMARY KEY(member_id, meeting_id),
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id),
    CONSTRAINT FOREIGN KEY (meeting_id) REFERENCES Group_Meeting (meeting_id)
);


CREATE TABLE IF NOT EXISTS Guest_Speaker (
    speaker_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    speaker_name varchar(50) NOT NULL,
    speaker_phone varchar(20),
    speaker_email varchar(75) NOT NULL,
    advisor_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id)
);

CREATE TABLE IF NOT EXISTS Executive_Member (
    exec_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    exec_name varchar(50) NOT NULL,
    exec_email varchar(75) NOT NULL,
    exec_gradYear TINYINT NOT NULL,
    exec_position varchar(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Event (
    event_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    event_title varchar(50),
    event_date DATE NOT NULL,
    event_startTime DATETIME,
    event_endTime DATETIME,
    num_RSVPS SMALLINT,
    exec_id INTEGER NOT NULL,
    speaker_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (exec_id) REFERENCES Executive_Member (exec_id),
    CONSTRAINT FOREIGN KEY (speaker_id) REFERENCES Guest_Speaker (speaker_id) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Member_Event (
    member_id INTEGER NOT NULL,
    event_id INTEGER NOT NULL,
    INDEX member_id_member_event (member_id),
    INDEX event_id_member_event (event_id),
    PRIMARY KEY(member_id, event_id),
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id),
    CONSTRAINT FOREIGN KEY (event_id) REFERENCES Event (event_id)
);

CREATE TABLE IF NOT EXISTS Member_Application (
    app_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_submitted DATETIME,
    app_link varchar(255) NOT NULL,
    exec_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (exec_id) REFERENCES Executive_Member (exec_id)
);

CREATE TABLE IF NOT EXISTS Client (
    client_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_name varchar(50) NOT NULL,
    client_email varchar(75) NOT NULL,
    exec_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (exec_id) REFERENCES Executive_Member (exec_id)
);

CREATE TABLE IF NOT EXISTS Prospective_Client (
    prospective_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    prospective_name varchar(50) NOT NULL,
    prospective_companyName varchar(50) NOT NULL,
    prospective_email varchar(75) NOT NULL,
    exec_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (exec_id) REFERENCES Executive_Member (exec_id)
);

CREATE TABLE IF NOT EXISTS Proposal (
    proposal_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    document_link varchar(255) NOT NULL,
    proposal_description varchar(255),
    advisor_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id)
);

CREATE TABLE IF NOT EXISTS Project (
    project_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    project_description varchar(255) NOT NULL,
    project_startDate DATE,
    project_endDate DATE,
    advisor_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id),
    CONSTRAINT FOREIGN KEY (client_id) REFERENCES Client (client_id)
);

CREATE TABLE IF NOT EXISTS Member_Project (
    member_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,
    INDEX member_id_member_project (member_id),
    INDEX project_id_member_project (project_id),
    PRIMARY KEY(member_id, project_id),
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id),
    CONSTRAINT FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Ticket (
    ticket_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ticket_status varchar(50) NOT NULL,
    ticket_description varchar(255),
    project_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Status_Update (
    update_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    update_description varchar(255) NOT NULL,
    update_dateTime DATETIME NOT NULL,
    project_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id)
);


INSERT INTO General_Member (member_name, member_major, member_year, member_email)
VALUES
('Harry Potter', 'Defense Against the Dark Arts', 2025, 'harry.potter@hogwarts.com'),
('Ron Weasley', 'Magical Creatures', 2024, 'ron.weasley@hogwarts.com'),
('Hermione Granger', 'Charms', 2023, 'hermione.granger@hogwarts.com');

INSERT INTO Advisor (advisor_name, advisor_email)
VALUES
('Albus Dumbledore', 'albus.dumbledore@hogwarts.com'),
('Minerva McGonagall', 'minerva.mcgonagall@hogwarts.com');

INSERT INTO Office_Hours (session_date, session_startTime, session_endTime, advisor_id)
VALUES
('2025-04-10', '2025-04-10 14:00:00', '2025-04-10 16:00:00', 1),
('2025-04-12', '2025-04-12 10:00:00', '2025-04-12 12:00:00', 2);

INSERT INTO Member_Advisor (member_id, advisor_id)
VALUES
(1, 1),
(2, 2),
(3, 1);

INSERT INTO Group_Meeting (meeting_date, meeting_startTime, meeting_endTime)
VALUES
('2025-04-15', '2025-04-15 15:00:00', '2025-04-15 16:30:00'),
('2025-04-20', '2025-04-20 17:00:00', '2025-04-20 18:30:00');

INSERT INTO Member_Meeting (member_id, meeting_id)
VALUES
(1, 1),
(2, 2),
(3, 1);

INSERT INTO Guest_Speaker (speaker_name, speaker_phone, speaker_email, advisor_id)
VALUES
('Tom Seaver', '123-456-7890', 'tom.seaver@mets.com', 1),
('David Wright', '987-654-3210', 'david.wright@mets.com', 2);

INSERT INTO Executive_Member (exec_name, exec_email, exec_gradYear, exec_position)
VALUES
('Keith Hernandez', 'keith.hernandez@mets.com', 2025, 'President'),
('Mike Piazza', 'mike.piazza@mets.com', 2024, 'Vice President');

INSERT INTO Event (event_title, event_date, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id)
VALUES
('Quidditch Strategies', '2025-05-01', '2025-05-01 18:00:00', '2025-05-01 19:30:00', 50, 1, 1),
('Potions Workshop', '2025-06-10', '2025-06-10 14:00:00', '2025-06-10 16:00:00', 100, 2, 2);

INSERT INTO Member_Event (member_id, event_id)
VALUES
(1, 1),
(2, 2),
(3, 1);

INSERT INTO Member_Application (date_submitted, app_link, exec_id)
VALUES
('2025-03-15 12:00:00', 'http://hogwarts.com/application1', 1),
('2025-03-16 13:00:00', 'http://hogwarts.com/application2', 2);

INSERT INTO Client (client_name, client_email, exec_id)
VALUES
('Nimbus Racing Brooms', 'contact@nimbusbrooms.com', 1),
('Weasleys Wizard Wheezes', 'info@weasleyswheezes.com', 2);

INSERT INTO Prospective_Client (prospective_name, prospective_companyName, prospective_email, exec_id)
VALUES
('Jacob deGrom', 'Mets Training', 'jacob.degrom@mets.com', 1),
('Francisco Lindor', 'Mets Outreach', 'francisco.lindor@mets.com', 2);

INSERT INTO Proposal (document_link, proposal_description, advisor_id)
VALUES
('http://hogwarts.com/proposal1', 'Proposal for magical AI project', 1),
('http://hogwarts.com/proposal2', 'Proposal for self-stirring cauldrons', 2);

INSERT INTO Project (project_description, project_startDate, project_endDate, advisor_id, client_id)
VALUES
('AI-based Sorting Hat Enhancement', '2025-04-01', '2025-12-01', 1, 1),
('Automated Broomstick Repair System', '2025-05-01', '2025-11-01', 2, 2);

INSERT INTO Member_Project (member_id, project_id)
VALUES
(1, 1),
(2, 2),
(3, 1);

INSERT INTO Ticket (ticket_status, ticket_description, project_id)
VALUES
('Open', 'Sorting Hat malfunction during decision-making', 1),
('In Progress', 'Optimize broomstick maintenance algorithm', 2);

INSERT INTO Status_Update (update_description, update_dateTime, project_id, member_id)
VALUES
('Enhanced Sorting Hat logic completed', '2025-03-25 10:00:00', 1, 1),
('Broomstick repair system prototype built', '2025-03-28 14:00:00', 2, 2);
