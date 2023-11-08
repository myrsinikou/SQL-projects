-- View the whole dataset
select *
from sleep_health_and_lifestyle_dataset;

-- Find all the different occupations
select distinct Occupation
from sleep_health_and_lifestyle_dataset;

-- Find the number of each occupation
select Occupation,count(Occupation)
from sleep_health_and_lifestyle_dataset
group by Occupation
order by count(Occupation) Desc;

-- Find BMI Category by Gender
select BMI_Category,count(BMI_Category),Gender
from sleep_health_and_lifestyle_dataset
group by BMI_Category, Gender
order by Gender;

-- Find the occupation, sleep duration and physical activity level for physical activity level more than 50
select Occupation, Sleep_Duration,Physical_Activity_Level
from sleep_health_and_lifestyle_dataset
having Physical_Activity_Level>50;

-- Find quality of sleep and age for people older than 40
select Quality_Of_Sleep, Age
from sleep_health_and_lifestyle_dataset
where Age>40
order by Quality_Of_Sleep desc;

-- Find Occupation and quality of sleep for people who have the minimum sleep duration
select Occupation,Quality_of_Sleep
from sleep_health_and_lifestyle_dataset
where Sleep_Duration=(select min(Sleep_Duration)from sleep_health_and_lifestyle_dataset);

-- Find occupation, age and physical activity level for people who have the maximum quality of sleep
select Occupation,Age,Physical_Activity_Level
from sleep_health_and_lifestyle_dataset
where Quality_Of_Sleep=(select max(Quality_Of_Sleep) from sleep_health_and_lifestyle_dataset)
order by Physical_Activity_Level desc;

-- Find sleep duration and quality of sleep for people who have stress level more than 7 and no sleeping disorders
select Sleep_Duration, Quality_Of_Sleep
from sleep_health_and_lifestyle_dataset
where Stress_Level>7 and Sleep_Disorder='None';

-- Find how many people have each sleeping disorder
select Sleep_Disorder, count(Sleep_Disorder)
from sleep_health_and_lifestyle_dataset
group by Sleep_Disorder;

-- Find the number of men and women for each stress level
select Stress_Level,Gender ,count(Gender)
from sleep_health_and_lifestyle_dataset
group by Stress_Level, Gender 
order by Stress_Level;

-- Find the number of cases for each stress level and Occupation
select Stress_Level, Occupation, count(Occupation)
from sleep_health_and_lifestyle_dataset
group by Stress_Level , Occupation 
order by Occupation,count(Occupation)desc ;

-- Find the average age for each sleeping disorder
select Sleep_Disorder,Avg(Age)
from sleep_health_and_lifestyle_dataset
group by Sleep_Disorder ;
