SELECT TOP (1000) [image_id]
      ,[event_id]
      ,[image_url]
      ,[image_title]
  FROM [TickifyDB].[dbo].[EventImages]

SELECT * FROM EventImages

DELETE EventImages
WHERE image_id = 3

SELECT * FROM EventImages
WHERE event_id = 2