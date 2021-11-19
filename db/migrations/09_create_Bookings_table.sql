CREATE TABLE bookings (
    id  serial,
    space_id varchar(30),
    user_id varchar(30),
    host_id varchar(30),
    start_date varchar(20),
    nights varchar(3)
);