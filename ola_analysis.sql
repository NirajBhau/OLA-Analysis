create database ola

use ola

select * from dbo.Bookings

--retrieve all sucessfull bookings

create view Successful_bookings As
Select * from dbo.Bookings where Booking_Status = 'Success'

select * FRom dbo.Successful_bookings


--2. Find the average ride distance for each vehicle type:

alter Table dbo.Bookings
alter column Ride_Distance int

create view avg_RideDistance as
select Vehicle_Type ,AVG(Ride_Distance) as avg_ridedistance
from dbo.Bookings
group by Vehicle_Type

select * from dbo.avg_RideDistance



--3. Get the total number of cancelled rides by customers:

select count(*) from dbo.Bookings where Booking_status='Canceled by Customer'


--4. List the top 5 customers who booked the highest number of rides:

create view top_Customer as
SELECT TOP 5 Customer_ID, COUNT(Booking_ID) AS total_rides
FROM Bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC;



--5. Get the number of rides cancelled by drivers due to personal and car-related issues:

select Count(*) from Bookings as Cancel_Due_to_personal
where Canceled_Rides_by_Driver='Personal & Car related issue' 



--6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

create view min_max_ratings as
select MAX(Driver_Ratings) as max_rating,
MIN(Driver_Ratings) as min_rating
from Bookings where Vehicle_Type='Prime Sedan'

select * from min_max_ratings

--7. Retrieve all rides where payment was made using UPI:

create view payment_method_upi as
select * from Bookings where Payment_Method='UPI'

select * from dbo.payment_method_upi

--8. Find the average customer rating per vehicle type:

alter table dbo.Bookings
alter column Customer_Rating int



create view avg_customer_rating as
select Vehicle_Type, AVG(Customer_Rating) as cust_rating
from Bookings
Group by Vehicle_Type

--9. Calculate the total booking value of rides completed successfully:

create view total_value_sucess_booking as
select SUM(Booking_Value) as Total_sucess_value
from Bookings where Booking_Status='Success'

select * from total_value_sucess_booking

--10. List all incomplete rides along with the reason:


Create View Incomplete_Rides_Reason As
SELECT Booking_ID, Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = 'Yes';

select * from dbo.Incomplete_Rides_Reason


--changing null with 0 
UPDATE Bookings
SET Customer_Rating = CAST(0 AS FLOAT)
WHERE Customer_Rating IS NULL;

ALTER TABLE Bookings 
ALTER COLUMN Driver_Ratings FLOAT;


--changing null with 0 driver rating
UPDATE Bookings
SET Driver_Ratings = CAST(0 AS FLOAT)
WHERE Driver_Ratings IS NULL;


select * from dbo.Bookings


UPDATE Bookings
SET 
    Customer_Rating = CASE WHEN Customer_Rating = 'null' THEN '0' ELSE Customer_Rating END,
    Driver_Ratings = CASE WHEN Driver_Ratings = 'null' THEN '0' ELSE Driver_Ratings END;

ALTER TABLE Bookings 
ALTER COLUMN Customer_Rating FLOAT;

ALTER TABLE Bookings 
ALTER COLUMN Driver_Ratings FLOAT;
