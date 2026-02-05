# Homework 3: Data Warehousing

## Question 1. What is count of records for the 2024 Yellow Taxi Data? (1 point)

## Answer 1.

``SELECT COUNT(*)
    FROM `rides_dataset.rides` ``

<img width="235" height="148" alt="image" src="https://github.com/user-attachments/assets/5ac30d7b-6137-4590-b646-c7448da83d9b" />


## Question 2. What is the estimated amount of data that will be read when this query is executed on the External Table and the Table? (1 point)

## Answer 2.

<img width="272" height="90" alt="image" src="https://github.com/user-attachments/assets/e189ed85-7d4a-457b-b58f-1e73f4dee4af" />

## Question 3. Why are the estimated number of Bytes different? (1 point)

## Answer 3. 

<img width="693" height="95" alt="image" src="https://github.com/user-attachments/assets/560f87b4-4095-49eb-a98a-6bd76483f157" />

## Question 4. How many records have a fare_amount of 0? (1 point)

## Answer 4.

``SELECT COUNT(*) AS zero_fare_count
FROM `gcp-data-warehouse-486419.rides_dataset.rides`
WHERE fare_amount = 0; ``

<img width="248" height="157" alt="image" src="https://github.com/user-attachments/assets/36c7256c-6303-45f0-8a93-6523b45e21ec" />

## Question 5. What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy) (1 point)


## Answer 5.

<img width="477" height="30" alt="image" src="https://github.com/user-attachments/assets/b2546ca5-4308-4e18-a684-16074db73748" />


## Question 6. Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive). Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values? (1 point)

## Answer 6.

``SELECT DISTINCT vendor_id
FROM `gcp-data-warehouse-486419.rides_dataset.rides`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';``

<img width="322" height="41" alt="image" src="https://github.com/user-attachments/assets/b7c1c175-3ebd-4c69-83f5-6b8db884178f" />

``SELECT DISTINCT vendor_id
FROM `gcp-data-warehouse-486419.rides_dataset.rides_partitioned`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';``

<img width="302" height="25" alt="image" src="https://github.com/user-attachments/assets/2ea11153-8c14-4101-ba9e-410fcd4aaaad" />

## Question 7. Where is the data stored in the External Table you created? (1 point)

## Answer 7. 

<img width="118" height="27" alt="image" src="https://github.com/user-attachments/assets/f5f221bd-a86b-4428-9f4b-f5ead5d23f13" />

## Question 8. It is best practice in Big Query to always cluster your data: (1 point)

## Answer 8. 

<img width="67" height="26" alt="image" src="https://github.com/user-attachments/assets/cf659045-e7f1-472c-b140-6da9882adc69" />

## Question 9. Write a `SELECT count(*)` query FROM the materialized table you created. How many bytes does it estimate will be read? Why? (not graded)

## Answer 9.

This query will process 0 B when run.
BigQuery can answer COUNT(*) using the table’s metadata (stored row count) instead of reading all rows, so it does not need to scan the data and the estimate is 0 bytes.


























