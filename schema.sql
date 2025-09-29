CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(100),
    hire_date DATE,
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES Employee(employee_id) -- Reflexive 1:N relationship
);

-- Subclasses:
CREATE TABLE Driver (
    employee_id INT PRIMARY KEY,
    license_number VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Conductor (
    employee_id INT PRIMARY KEY,
    certification_date DATE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Mechanic (
    employee_id INT PRIMARY KEY,
    specialization VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE TicketAgent (
    employee_id INT PRIMARY KEY,
    sales_total INT,
    station_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Manager (
    employee_id INT PRIMARY KEY,
    department VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Station (
    station_id INT PRIMARY KEY,
    station_name VARCHAR(255) NOT NULL,
    -- address composite attribute:
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    manager_id INT UNIQUE NOT NULL, -- 1:1 relationship with Manager, total participation on one side
    FOREIGN KEY (manager_id) REFERENCES Manager(employee_id)
);

ALTER TABLE TicketAgent ADD FOREIGN KEY (station_id) REFERENCES Station(station_id);

CREATE TABLE Route (
    route_id INT PRIMARY KEY,
    route_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Train (
    train_id INT PRIMARY KEY,
    model VARCHAR(100),
    capacity INT
);

CREATE TABLE Passenger (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Multivalued Attribute: phone_numbers
CREATE TABLE PassengerPhoneNumbers (
    passenger_id INT,
    phone_number VARCHAR(20),
    PRIMARY KEY (passenger_id, phone_number),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id)
);

CREATE TABLE Trip (
    trip_id INT PRIMARY KEY,
    departure_time DATETIME,
    arrival_time DATETIME,
    route_id INT NOT NULL, -- Total participation for Trip in RunsOn relationship
    train_id INT,
    FOREIGN KEY (route_id) REFERENCES Route(route_id),
    FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

-- Weak Entity: Ticket
CREATE TABLE Ticket (
    passenger_id INT,
    ticket_number INT,
    seat_number VARCHAR(10),
    fare DECIMAL(10, 2),
    trip_id INT,
    PRIMARY KEY (passenger_id, ticket_number), -- Composite key for weak entity Ticket
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id)
);

-- N:M Relationship: Books
CREATE TABLE Books (
    passenger_id INT,
    trip_id INT,
    booking_date DATE, -- Attribute on a relationship
    PRIMARY KEY (passenger_id, trip_id),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id)
);

-- Reflexive relationship IsConnectedTo
CREATE TABLE IsConnectedTo (
    station_id_1 INT,
    station_id_2 INT,
    PRIMARY KEY (station_id_1, station_id_2),
    FOREIGN KEY (station_id_1) REFERENCES Station(station_id),
    FOREIGN KEY (station_id_2) REFERENCES Station(station_id)
);

-- Ternary relationship PerformsMaintenance
CREATE TABLE PerformsMaintenance (
    mechanic_id INT,
    train_id INT,
    station_id INT,
    maintenance_date DATE NOT NULL, -- Attribute on a relationship
    PRIMARY KEY (mechanic_id, train_id, station_id, maintenance_date),
    FOREIGN KEY (mechanic_id) REFERENCES Mechanic(employee_id),
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);