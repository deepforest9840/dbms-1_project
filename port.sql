CREATE TABLE exim (
    id VARCHAR(255) PRIMARY KEY 
    location VARCHAR(255),
    name varchar(255)
);


INSERT INTO exim (id, location, name) VALUES ('1001', 'BANGLADESH', 'CSEDU');
insert into exim values("1002","SINGAPORE","FERROCADIA");



create table ship_company(
	id varchar(255) primary key,
	name varchar(255),
	location varchar(255)
);

INSERT INTO ship_company (id, name, location) VALUES
    ('1001', 'EVER GREEN', 'TAIWAN'),
    ('1002', 'MAERSK', 'DENMARK'),
    ('1003', 'YANG MING', 'CHINA'),
    ('1004','SOTABDIK-27','CSEDU');
    

CREATE TABLE container (
    id VARCHAR(255),
    company_id VARCHAR(255),
    active_status   varchar(255),
    PRIMARY KEY (id, company_id),
    weight int,
    FOREIGN KEY (company_id) REFERENCES ship_company(id)
);

 insert into container values
 ('1001','1001','ACTIVE',100),
 ('1001','1002','INACTIVE',200),
 ('1002','1001','SERVICE',300),
 ('1003','1001','SERVICE',50),
 ('1003','1002','SERVICE',60);
 
 
 
 
 
 
                            Oracle version 
                            
                            
                            
                             exim table:1
 
CREATE TABLE exim (
    id VARCHAR2(255) PRIMARY KEY,
    location VARCHAR2(255),
    name VARCHAR2(255)
);

INSERT INTO exim (id, location, name) VALUES ('1001', 'BANGLADESH', 'CSEDU');
INSERT INTO exim VALUES ('1002', 'SINGAPORE', 'FERROCADIA');

 
                          ship_company table:2
 
 
CREATE TABLE ship_company (
    id VARCHAR2(255) PRIMARY KEY,
    name VARCHAR2(255),
    location VARCHAR2(255)
);

INSERT INTO ship_company VALUES ('1001', 'EVER GREEN', 'TAIWAN');
INSERT INTO ship_company VALUES ('1002', 'MAERSK', 'DENMARK');
INSERT INTO ship_company VALUES ('1003', 'YANG MING', 'CHINA');
INSERT INTO ship_company VALUES ('1004', 'SOTABDIK-27', 'CSEDU');

                          container table:3
 
CREATE TABLE container (
    id VARCHAR2(255),
    company_id VARCHAR2(255),
    active_status VARCHAR2(255),
    sizee NUMBER,
    PRIMARY KEY (id, company_id),
    FOREIGN KEY (company_id) REFERENCES ship_company(id)
);

INSERT INTO container VALUES ('1001', '1001', 'ACTIVE', 100);
INSERT INTO container VALUES ('1001', '1002', 'INACTIVE', 200);
INSERT INTO container VALUES ('1002', '1002', 'ACTIVE', 300);
INSERT INTO container VALUES ('1003', '1002', 'ACTIVE', 300);
INSERT INTO container VALUES ('1002', '1001', 'SERVICE', 300);
INSERT INTO container VALUES ('1003', '1001', 'SERVICE', 50);


			 port table:4
 			
 CREATE TABLE port (
    id VARCHAR2(255) PRIMARY KEY,
    name VARCHAR2(255),
    location VARCHAR2(255),
    area  number
);

insert into port  values ('2001','Geelong','Austrailia','8000');
insert into port  values ('2002','Milner Bay','Austrailia','9000');
insert into port  values ('2003','Chittagong','BanglaDesh','11000');
insert into port  values ('2004','Jurong','Singapore','7000');
insert into port  values ('2005','Singapore','Singapore','13000');
insert into port  values ('2006','Shenzhen','China','38000');


		freight forward table  (ff):5

CREATE TABLE ff (
    f_id VARCHAR2(50) PRIMARY KEY,
    container_id VARCHAR2(50),
    company_id VARCHAR2(50),
    exp_id VARCHAR2(50),
    imp_id VARCHAR2(50),
    port_id VARCHAR2(50),
    element varchar2(50),
    neet_weight number,
    driver_id varchar2(50),
    truck_id varchar2(50),
    loading_time  TIMESTAMP,
    arrival_time TIMESTAMP,
    
    CONSTRAINT fk_container FOREIGN KEY (container_id,company_id) REFERENCES container(id,company_id),
    
    CONSTRAINT fk_exim_exp FOREIGN KEY (exp_id) REFERENCES exim(id),
    CONSTRAINT fk_exim_imp FOREIGN KEY (imp_id) REFERENCES exim(id),
    CONSTRAINT fk_port FOREIGN KEY (port_id) REFERENCES port(id)
);
            
            
              procedure..............
             
             
           
 CREATE OR REPLACE PROCEDURE update_container_status(
 		p_container_id varchar2,
 		p_company_id varchar2
 )
 	as
 	BEGIN
 		UPDATE container
 		set active_status='SERVICE'
 		where id=p_container_id
 		and company_id=p_company_id;
 		
 		
 	Exception
 		when no_data_found then 
 			raise_application_error(-20001,'container not found');
 		when others then
 			raise_application_error(-20002,'an error occured'||sqlerrm);
 	End ;
 	
 	
             
             
             
      

				trigger.........





CREATE OR REPLACE TRIGGER ff_insert_trigger
BEFORE INSERT ON ff
FOR EACH ROW
DECLARE
    v_active_status VARCHAR2(10);
BEGIN
    -- Check if the container is active
    SELECT active_status INTO v_active_status
    FROM container
    WHERE id = :NEW.container_id
      AND company_id = :NEW.company_id;

    -- If container is not active, raise an exception
    IF v_active_status <> 'ACTIVE' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Container is not active. Insert operation aborted.');
    END IF;

    -- Call the procedure to update container status
    update_container_status(:NEW.container_id, :NEW.company_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Container not found.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'An error occurred: ' || SQLERRM);
END ff_insert_trigger;
/


INSERT INTO ff (f_id, container_id, company_id, exp_id, imp_id, port_id, element,neet_weight,driver_id,truck_id,loading_time, arrival_time)
VALUES ('1001', '1001', '1001', '1001', '1001', '2003', 'Normal',5000,'100001','200001',CURRENT_TIMESTAMP, TIMESTAMP '2024-12-12 12:30:00');

INSERT INTO ff (f_id, container_id, company_id, exp_id, imp_id, port_id, element,neet_weight,driver_id,truck_id,loading_time, arrival_time)
VALUES ('1002', '1003', '1002', '1001', '1001', '2003', 'Normal',5000,'100001','200001',CURRENT_TIMESTAMP, TIMESTAMP '2024-12-12 12:30:00');



								          incoming_Yard table:6........................
		
CREATE TABLE incoming_yard (
    id VARCHAR(3) primary key,
    total number
);
						
INSERT INTO incoming_yard (id, total) VALUES ('A', 80000);
INSERT INTO incoming_yard(id, total) VALUES ('B', 90000);
INSERT INTO incoming_yard(id, total) VALUES ('C', 50000);
INSERT INTO incoming_yard(id, total) VALUES ('D', 80000);
INSERT INTO incoming_yard(id, total) VALUES ('E', 80000);
INSERT INTO incoming_yard(id, total) VALUES ('F', 80000);
INSERT INTO incoming_yard(id, total) VALUES ('G', 80000);
INSERT INTO incoming_yard(id, total) VALUES ('H', 80000);
INSERT INTO incoming_yard(id, total) VALUES ('I', 80000);
INSERT INTO incoming_yard(id, total) VALUES ('J', 80000);

								

									CraneDrivers table:7


CREATE TABLE crane_drivers (
    id VARCHAR2(20) PRIMARY KEY,
    name VARCHAR2(100)
    
);


insert into crane_drivers values('1001','Faiyak');
insert into crane_drivers values('1002','zisan');
insert into crane_drivers values('1003','rafin');
insert into crane_drivers values('1004','araf');
insert into crane_drivers values('1005','tiger');

												
												
									harbor_pilots table:8

CREATE TABLE harbor_pilots (
    id VARCHAR2(20) PRIMARY KEY,
    name VARCHAR2(100)
   
);

insert into harbor_pilots values('2001','Faiyak');
insert into harbor_pilots values('2002','zisan');
insert into harbor_pilots values('2003','rafin');
insert into harbor_pilots values('2004','araf');
insert into harbor_pilots values('2005','tiger');



						unload_incoming_yard table:9
						
						
CREATE TABLE unload_incoming_yard (
    f_id VARCHAR2(50),
    yard_id VARCHAR2(3),
    crane_driver_id VARCHAR2(20),
    u_time TIMESTAMP,
    PRIMARY KEY (f_id),
   
         CONSTRAINT fk_ex FOREIGN KEY (yard_id) REFERENCES incoming_yard(id),
   CONSTRAINT fk_exim_imfddp FOREIGN KEY (f_id) REFERENCES ff(f_id)
    
);




						trigger to unload container on incoming_yard.
						
CREATE OR REPLACE TRIGGER insert_unload_incoming_yard
BEFORE INSERT ON unload_incoming_yard
FOR EACH ROW
DECLARE
    v_container_id VARCHAR2(50);
    v_company_id VARCHAR2(50);
    v_container_size VARCHAR2(50);
    v_total_size NUMBER;
    v_last_u_time TIMESTAMP;
BEGIN
    -- Find container_id and company_id using f_id from ff table
    SELECT container_id, company_id
    INTO v_container_id, v_company_id
    FROM ff
    WHERE f_id = :NEW.f_id;

    SELECT sizee
    INTO v_container_size
    FROM container
    WHERE id = v_container_id
      AND company_id = v_company_id;

    -- Find total size using the yard id from the yard table
    SELECT total
    INTO v_total_size
    FROM incoming_yard
    WHERE id = :NEW.yard_id;

    -- Check if (total - sizee) is greater than or equal to 0
    IF (v_total_size - v_container_size) >= 0 THEN
        -- Check if there is a match in unload_incoming_container with the new crane_driver_id
        SELECT MAX(u_time)
        INTO v_last_u_time
        FROM unload_incoming_yard
        WHERE crane_driver_id = :NEW.crane_driver_id;

        IF v_last_u_time IS NULL OR :NEW.u_time > v_last_u_time + INTERVAL '2' HOUR THEN
            
            UPDATE yard
            SET total = v_total_size - v_container_size
            WHERE id = :NEW.yard_id;
        ELSE
            -- Raise an exception if the condition is not met
            RAISE_APPLICATION_ERROR(-20002, 'New u_time must be greater than the last matched u_time plus 2 hours.');
        END IF;
    ELSE
        -- Raise an exception if the condition is not met
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient yard space for the container.');
    END IF;
END;


/




					
insert into unload_incoming_yard values('1001','A','1001',CURRENT_TIMESTAMP);
insert into unload_incoming_yard values('1002','A','1002',CURRENT_TIMESTAMP);




								ship table:10
								
CREATE TABLE ship (
    ship_id VARCHAR2(50),
    company_id VARCHAR2(50),
    ship_name VARCHAR2(100),
    capacity_size NUMBER,
    capacity_weight NUMBER,
    status VARCHAR2(20),
    PRIMARY KEY (ship_id, company_id),
    foreign key(company_id) references ship_company(id)
);

insert into ship values('1001','1001','pirates of caribbean',50000,80000,'ACTIVE');
insert into ship values('1002','1001','CORAL',57000,87000,'ACTIVE');
insert into ship values('1003','1001','shark bait',40000,81000,'ACTIVE');
insert into ship values('1003','1001','unsinkable',30000,82000,'ACTIVE');
insert into ship values('1004','1001','the kraken',90000,88000,'ACTIVE');
insert into ship values('1005','1001','hammerhead',10000,84000,'INACTIVE');
insert into ship values('1006','1001','long weekend',20000,89000,'ACTIVE');
insert into ship values('1002','1002','CORAL',57000,87000,'ACTIVE');
insert into ship values('1003','1002','shark bait',40000,81000,'ACTIVE');
insert into ship values('1003','1003','unsinkable',30000,82000,'ACTIVE');
insert into ship values('1004','1003','the kraken',90000,88000,'ACTIVE');
insert into ship values('1005','1004','hammerhead',10000,84000,'INACTIVE');
insert into ship values('1006','1004','long weekend',20000,89000,'ACTIVE');


									anchorage table:11
									
									
	create table anchorage(
	
		id varchar(3) primary key,
		status  varchar(20)
	
	
	
	
	);								
					
insert into anchorage values('a1','empty');
insert into anchorage values('b1','empty');
insert into anchorage values('c1','empty');
insert into anchorage values('d1','empty');
insert into anchorage values('a2','empty');
insert into anchorage values('b2','empty');
insert into anchorage values('c2','empty');
insert into anchorage values('d2','empty');
insert into anchorage values('a3','empty');
insert into anchorage values('b3','empty');
insert into anchorage values('c3','empty');
insert into anchorage values('d3','empty');
									
									
											
								Sailing table:12

CREATE TABLE sailing (
    s_id VARCHAR2(50),
    ship_id VARCHAR2(50),
    company_id VARCHAR2(50),
    captain_id VARCHAR2(50),
    anchorage_id varchar(3),
    to_location VARCHAR2(100),
    anchorage_time TIMESTAMP,
    dept_time TIMESTAMP,
    PRIMARY KEY (s_id),
    FOREIGN KEY (ship_id, company_id) REFERENCES ship(ship_id, company_id),
    FOREIGN KEY (anchorage_id) REFERENCES anchorage(id)
    
);


CREATE OR REPLACE TRIGGER check_and_update_status
BEFORE INSERT ON sailing
FOR EACH ROW
DECLARE
    v_ship_status VARCHAR2(20);
    v_anchorage_status VARCHAR2(20);
BEGIN
    -- Check ship status in the ship table
    SELECT status INTO v_ship_status
    FROM ship
    WHERE ship_id = :NEW.ship_id
      AND company_id = :NEW.company_id;

    IF v_ship_status = 'ACTIVE' THEN
        -- Update ship status to 'Service'
          -- Check anchorage status in the anchorage table
    SELECT status INTO v_anchorage_status
    FROM anchorage
    WHERE id = :NEW.anchorage_id;
          IF v_anchorage_status = 'empty' THEN
        -- Update anchorage status to 'Inactive'
        UPDATE anchorage
        SET status = 'filled'
        WHERE id = :NEW.anchorage_id;
        
        UPDATE ship
        SET status = 'Service'
        WHERE ship_id = :NEW.ship_id
          AND company_id = :NEW.company_id;
        
        
        
    ELSE
        -- Raise an exception if anchorage status is not 'Empty'
        RAISE_APPLICATION_ERROR(-20002, 'Anchorage must be empty to proceed.');
    END IF;
        
        
    ELSE
        -- Raise an exception if ship status is not 'Active'
        RAISE_APPLICATION_ERROR(-20001, 'Ship status must be "Active" to proceed.');
    END IF;

  

  
END;






insert into sailing values('1001','1001','1001','1001','a1','2001',CURRENT_TIMESTAMP,TIMESTAMP '2024-12-12 12:30:00');

insert into sailing values('1002','1002','1002','1002','a2','2003',CURRENT_TIMESTAMP,TIMESTAMP '2024-12-12 12:30:00');



							exim_port table:13
							
							
							
create table exim_port (



	exim_id varchar(50),
	port_id  varchar(50),
	foreign key(exim_id) references exim(id),
	foreign key(port_id) references port(id),
	primary key(exim_id,port_id)
	

);		

insert into exim_port values('1001','2003');
insert into exim_port values('1002','2004');
insert into exim_port values('1002','2005');





							load table:14
		
				
	CREATE TABLE load (
    sailing_id VARCHAR2(50),
    f_id VARCHAR2(50),
    harbor_pilots_id VARCHAR2(50),
    l_time TIMESTAMP,
    PRIMARY KEY (sailing_id, f_id),
    FOREIGN KEY (sailing_id) REFERENCES sailing(s_id),
    FOREIGN KEY (f_id) REFERENCES ff(f_id),
    FOREIGN KEY (harbor_pilots_id) REFERENCES harbor_pilots(id)
);					







CREATE OR REPLACE TRIGGER check_load_time
BEFORE INSERT ON load
FOR EACH ROW
DECLARE
    v_max_l_time TIMESTAMP;
    v_neet_weight NUMBER;
    ship_id_t varchar(50);
    company_id_t varchar(50);
    v_ship_capacity_weight NUMBER;
    sailing_dept_time TIMESTAMP;
BEGIN
    -- Find the max l_time for the specified harbor_pilots_id
    SELECT MAX(l_time) INTO v_max_l_time
    FROM load
    WHERE harbor_pilots_id = :NEW.harbor_pilots_id;

    -- Check if the new l_time is greater than the allowed time
    
     IF v_max_l_time IS NULL OR :NEW.l_time  > v_max_l_time + INTERVAL '2' HOUR THEN
     
     	select dept_time
     	into sailing_dept_time
     	from sailing
     	where s_id=:NEW.sailing_id;
     	
     if :NEW.l_time < sailing_dept_time then
     	
        -- Get the neet_weight using f_id from ff table
        SELECT neet_weight
        INTO v_neet_weight
        FROM ff
        WHERE f_id = :NEW.f_id;

        -- Find the ship_id using sailing_id
        SELECT ship_id
        INTO ship_id_t
        FROM sailing
        WHERE s_id = :NEW.sailing_id;
	
	select company_id 
	into company_id_t
	from ff
	where f_id= :NEW.f_id;
        -- Find the ship's capacity_weight
        SELECT capacity_weight
        INTO v_ship_capacity_weight
        FROM ship
        WHERE ship_id = ship_id_t
          AND company_id = company_id_t;

        -- Check if capacity_weight - neet_weight > 0
        IF v_ship_capacity_weight - v_neet_weight >= 0 THEN
            -- Update the ship's capacity_weight
            UPDATE ship
            SET capacity_weight = v_ship_capacity_weight - v_neet_weight
            WHERE ship_id = ship_id_t
              AND company_id = company_id_t;
        ELSE
            -- Raise an exception if capacity_weight - neet_weight is not greater than or equal to 0
            RAISE_APPLICATION_ERROR(-20002, 'Capacity weight is insufficient for the load.');
        END IF;
        
        
        ELSE
        -- Raise an exception if the condition is not met
        RAISE_APPLICATION_ERROR(-20001, 'New l_time must be less than the ship departure time.');
    END IF; 
        
        
        
    ELSE
        -- Raise an exception if the condition is not met
        RAISE_APPLICATION_ERROR(-20001, 'New l_time must be greater than (2 hours + max l_time).');
    END IF;
END;



insert into load values('1002','1002','2003',CURRENT_TIMESTAMP);






				leave table:15


create table leave(

	sailing_id varchar(50) primary key,
	l_time  TIMESTAMP,

	foreign key(sailing_id) references sailing(s_id)
);



create or replace TRIGGER after_leave_insert
AFTER INSERT ON leave
FOR EACH ROW
DECLARE
    v_an VARCHAR2(3);
BEGIN
    UPDATE sailing
    SET status = 'unavailable'
WHERE s_id = :NEW.sailing_id;

    select anchorage_id into v_an
    from sailing 
    WHERE s_id = :NEW.sailing_id;

    UPDATE anchorage
    SET status = 'empty'
WHERE id = v_an;

END;


INSERT INTO leave (sailing_id, l_time) VALUES ('1001', '2023-11-15 14:30:00');











