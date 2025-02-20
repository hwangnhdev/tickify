SELECT * FROM Events
---------------------------------------------------------------------------------
SELECT TOP 10 * FROM Events ORDER BY created_at DESC
---------------------------------------------------------------------------------
SELECT TOP 10 e.event_id, e.event_name, 
       COALESCE(SUM(od.quantity), 0) AS total_tickets, 
       ei.image_url
FROM Events e
JOIN TicketTypes tt ON e.event_id = tt.event_id
LEFT JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id
LEFT JOIN EventImages ei ON e.event_id = ei.event_id
GROUP BY e.event_id, e.event_name, ei.image_url
ORDER BY total_tickets DESC;
---------------------------------------------------------------------------------
SELECT TOP 10 
    e.event_id, 
    e.event_name, 
    COALESCE(SUM(od.quantity), 0) AS total_tickets, 
    ei.image_url, 
    ei.image_title
FROM Events e
JOIN TicketTypes tt ON e.event_id = tt.event_id
LEFT JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id
LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%'
GROUP BY e.event_id, e.event_name, ei.image_url, ei.image_title
ORDER BY total_tickets DESC;
---------------------------------------------------------------------------------
SELECT TOP 10 e.event_id, e.event_name, 
       COALESCE(SUM(od.quantity), 0) AS total_tickets
FROM Events e
JOIN TicketTypes tt ON e.event_id = tt.event_id
LEFT JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id
GROUP BY e.event_id, e.event_name
ORDER BY total_tickets DESC;
---------------------------------------------------------------------------------
SELECT TOP 10 
    e.event_id, 
    e.category_id, 
    e.event_name, 
    e.location, 
    e.event_type, 
    e.status, 
    e.description, 
    e.start_date, 
    e.end_date, 
    e.created_at, 
    e.updated_at, 
    ei.image_url, 
    ei.image_title
FROM Events e
LEFT JOIN EventImages ei 
    ON e.event_id = ei.event_id 
    AND ei.image_title LIKE '%banner%'
ORDER BY e.created_at DESC;
---------------------------------------------------------------------------------
SELECT TOP 10 
    e.event_id, 
    e.category_id, 
    e.event_name, 
    e.location, 
    e.event_type, 
    e.status, 
    e.description, 
    e.start_date, 
    e.end_date, 
    e.created_at, 
    e.updated_at, 
    ei.image_url, 
    ei.image_title
FROM Events e
LEFT JOIN EventImages ei 
    ON e.event_id = ei.event_id 
    AND ei.image_title LIKE '%banner%'
WHERE e.start_date >= GETDATE()
ORDER BY e.start_date ASC;
---------------------------------------------------------------------------------
WITH AvgPrice AS (
    SELECT AVG(tt.price) AS userBudget
    FROM Orders o
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id
    WHERE o.customer_id = 1
),
SuggestedPrice AS (
    SELECT TOP 10 tt.price AS defaultBudget
    FROM TicketTypes tt
    JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id
    GROUP BY tt.price
    ORDER BY COUNT(*) DESC
),
UserBudget AS (
    SELECT COALESCE((SELECT userBudget FROM AvgPrice), 
                    (SELECT defaultBudget FROM SuggestedPrice), 
                    100.00) AS budget
)
SELECT DISTINCT TOP 10 
    e.event_id, e.category_id, e.event_name, e.location, e.event_type, 
    e.status, e.start_date, e.end_date, e.created_at, e.updated_at, 
    MIN(tt.price) AS min_price, 
    ei.image_url, 
    ei.image_title
FROM Events e
JOIN TicketTypes tt ON e.event_id = tt.event_id
LEFT JOIN EventImages ei 
    ON e.event_id = ei.event_id 
    AND ei.image_title LIKE '%banner%'
CROSS JOIN UserBudget
WHERE tt.price <= UserBudget.budget
GROUP BY e.event_id, e.category_id, e.event_name, e.location, e.event_type, 
         e.status, e.start_date, e.end_date, e.created_at, e.updated_at, 
         ei.image_url, ei.image_title
ORDER BY min_price DESC;
---------------------------------------------------------------------------------
WITH UserCategories AS (
    SELECT DISTINCT e.category_id
    FROM Orders o
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id
    JOIN Events e ON tt.event_id = e.event_id
    WHERE o.customer_id = 1
),
AllCategories AS (
    SELECT category_id FROM Categories
),
CategoriesToRecommend AS (
    SELECT category_id FROM UserCategories
    UNION
    SELECT category_id FROM AllCategories
    WHERE NOT EXISTS (SELECT 1 FROM UserCategories)
)
SELECT TOP 10 
    e.event_id, e.category_id, e.event_name, e.location, e.event_type, 
    e.status, e.start_date, e.end_date, e.created_at, e.updated_at, 
    MIN(tt.price) AS min_price,
    ei.image_url, 
    ei.image_title
FROM Events e
JOIN TicketTypes tt ON e.event_id = tt.event_id
LEFT JOIN EventImages ei 
    ON e.event_id = ei.event_id 
    AND ei.image_title LIKE '%banner%'
WHERE e.category_id IN (SELECT category_id FROM CategoriesToRecommend)
GROUP BY e.event_id, e.category_id, e.event_name, e.location, e.event_type, 
         e.status, e.start_date, e.end_date, e.created_at, e.updated_at, 
         ei.image_url, ei.image_title
ORDER BY min_price DESC;
---------------------------------------------------------------------------------
SELECT * FROM Events 
ORDER BY event_id 
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
---------------------------------------------------------------------------------
SELECT TOP 10 * FROM Events WHERE start_date >= GETDATE() ORDER BY start_date ASC
---------------------------------------------------------------------------------
SELECT e.*, tt.MinPrice 
FROM Events e
JOIN (
    SELECT event_id, MIN(price) AS MinPrice 
    FROM TicketTypes 
    GROUP BY event_id
) tt ON e.event_id = tt.event_id
WHERE tt.MinPrice <= 180.00
ORDER BY tt.MinPrice DESC;
---------------------------------------------------------------------------------
WITH AvgPrice AS (
    -- Tính giá vé trung bình của user nếu họ đã mua vé
    SELECT AVG(tt.price) AS userBudget
    FROM Orders o
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id
    WHERE o.customer_id = 1
),
SuggestedPrice AS (
    -- Nếu user chưa mua vé, lấy mức giá phổ biến trên hệ thống
    SELECT TOP 1 tt.price AS defaultBudget
    FROM TicketTypes tt
    JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id
    GROUP BY tt.price
    ORDER BY COUNT(*) DESC
),
UserBudget AS (
    -- Xác định mức ngân sách sử dụng
    SELECT COALESCE((SELECT userBudget FROM AvgPrice), 
                    (SELECT defaultBudget FROM SuggestedPrice), 
                    100.00) AS budget
)
SELECT DISTINCT 
    e.event_id, e.category_id, e.event_name, e.location, e.event_type, 
    e.status, e.start_date, e.end_date, e.created_at, e.updated_at, 
    MIN(tt.price) AS min_price
FROM Events e
JOIN TicketTypes tt ON e.event_id = tt.event_id
CROSS JOIN UserBudget
WHERE tt.price <= UserBudget.budget
GROUP BY e.event_id, e.category_id, e.event_name, e.location, e.event_type, 
         e.status, e.start_date, e.end_date, e.created_at, e.updated_at
ORDER BY min_price DESC;
---------------------------------------------------------------------------------
WITH UserCategories AS (
    -- Lấy danh mục sự kiện mà khách hàng đã mua vé
    SELECT DISTINCT e.category_id
    FROM Orders o
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id
    JOIN Events e ON tt.event_id = e.event_id
    WHERE o.customer_id = 1
),
AllCategories AS (
    -- Nếu khách hàng chưa có đơn hàng, lấy tất cả category_id
    SELECT category_id FROM Categories
),
CategoriesToRecommend AS (
    -- Chọn category dựa vào lịch sử hoặc toàn bộ nếu chưa có đơn hàng
    SELECT category_id FROM UserCategories
    UNION
    SELECT category_id FROM AllCategories
    WHERE NOT EXISTS (SELECT 1 FROM UserCategories)
)
SELECT TOP 10 
    e.event_id, e.category_id, e.event_name, e.location, e.event_type, 
    e.status, e.start_date, e.end_date, e.created_at, e.updated_at, 
    MIN(tt.price) AS min_price
FROM Events e
JOIN TicketTypes tt ON e.event_id = tt.event_id
WHERE e.category_id IN (SELECT category_id FROM CategoriesToRecommend)
GROUP BY e.event_id, e.category_id, e.event_name, e.location, e.event_type, 
         e.status, e.start_date, e.end_date, e.created_at, e.updated_at
ORDER BY min_price DESC;
---------------------------------------------------------------------------------
SELECT DISTINCT e.category_id, c.category_name
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id
JOIN Events e ON tt.event_id = e.event_id
JOIN Categories c ON e.category_id = c.category_id
WHERE o.customer_id = 1;
---------------------------------------------------------------------------------
WITH EventPagination AS (
                SELECT ROW_NUMBER() OVER (ORDER BY created_at ASC) AS rownum, *
                FROM Events
                )
                SELECT * FROM EventPagination WHERE rownum BETWEEN 1 AND 20
---------------------------------------------------------------------------------
WITH EventPagination AS (
    SELECT ROW_NUMBER() OVER (ORDER BY e.created_at ASC) AS rownum, e.*
    FROM Events e
)
SELECT ep.*, ei.*
FROM EventPagination ep
LEFT JOIN EventImages ei 
ON ep.event_id = ei.event_id 
WHERE ep.rownum BETWEEN 1 AND 50
AND ei.image_title LIKE '%banner%';


SELECT COUNT(*) FROM Events ep
LEFT JOIN EventImages ei 
ON ep.event_id = ei.event_id 
WHERE ei.image_title LIKE '%banner%';
---------------------------------------------------------------------------------
SELECT * FROM Events
WHERE event_id = 1

SELECT * FROM EventImages
WHERE event_id = 1 AND image_title LIKE '%banner%';

SELECT * FROM Categories
INNER JOIN Events ON Categories.category_id = Events.category_id
WHERE event_id = 1
---------------------------Search Event------------------------------------------------------
SELECT * FROM Events
WHERE event_name LIKE '%Rock Festival%'
---------------------------Filter Event------------------------------------------------------
SELECT Categories.*, OrderDetails.*, EventImages.*, Orders.*, Events.*, Vouchers.*
FROM Orders INNER JOIN
OrderDetails ON Orders.order_id = OrderDetails.order_id INNER JOIN
Vouchers ON Orders.voucher_id = Vouchers.voucher_id CROSS JOIN
Categories INNER JOIN
Events ON Categories.category_id = Events.category_id INNER JOIN
EventImages ON Events.event_id = EventImages.event_id


--
SELECT e.*

FROM Events e

WHERE 1=1

AND (e.category_id IN (1)) -- if categories are selected

AND (e.location LIKE 'Downtown Plaza') -- if location is provided

AND (e.start_date >= '2025-12-15 00:00:00.000' AND e.end_date <= '2025-12-25 00:00:00.000') -- date range

AND EXISTS (

SELECT 1

FROM TicketTypes tt

WHERE tt.event_id = e.event_id

AND tt.price < 150 -- for below 150 case

)

AND EXISTS (

SELECT 1

FROM Orders o

JOIN OrderDetails od ON o.order_id = od.order_id

JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id

WHERE tt.event_id = e.event_id

AND o.voucher_id IS NOT NULL

) -- if vouchers filter is applied

---------------Filter Event------------------------------------------
SELECT DISTINCT e.* 
FROM Events e
LEFT JOIN TicketTypes t ON e.event_id = t.event_id
LEFT JOIN Vouchers v ON v.voucher_id IS NOT NULL
WHERE 1 = 1
AND e.category_id = 1
AND e.location LIKE 'Open Arena'
--AND e.start_date >= '2025-06-20 00:00:00.000' AND e.end_date <= '2025-06-21 00:00:00.000'
AND t.price BETWEEN 150 AND 300
AND v.voucher_id IS NOT NULL
---------------Filter Event------------------------------------------
SELECT DISTINCT e.event_id, e.category_id, e.event_name, e.location,
                e.event_type, e.status, e.description,
                CAST(e.start_date AS DATE) AS start_date, CAST(e.end_date AS DATE) AS end_date,
                CAST(e.created_at AS DATE) AS created_at, CAST(e.updated_at AS DATE) AS updated_at,
				ei. *
                FROM Events e
                LEFT JOIN TicketTypes t ON e.event_id = t.event_id
				LEFT JOIN EventImages ei ON ei.event_id = e.event_id
                WHERE 1 = 1 AND ei.image_title LIKE '%banner%' 
				AND e.category_id IN (1, 2)
				AND e.location LIKE 'Tech Hub'
				AND e.start_date >= '2025-07-25' AND e.end_date <= '2025-07-26'
				AND t.price < 150
				AND e.event_name LIKE '%AI & Robotics Summit%'
---------------View All Category------------------------------------------
SELECT * FROM Categories
---------------Create Category------------------------------------------
INSERT INTO Categories (category_name, description, created_at)
VALUES ('Music', 'This is category for music', GETDATE())
---------------Update Category------------------------------------------
UPDATE Categories
SET category_name = 'Music',
    description = 'This is category for music and for young',
    updated_at = GETDATE()
WHERE category_id = 7
---------------Update Category------------------------------------------
DELETE Categories
WHERE category_id = 9
---------------Get Category By Category Name------------------------------------------
SELECT * FROM Categories
WHERE category_name = 'Concert'