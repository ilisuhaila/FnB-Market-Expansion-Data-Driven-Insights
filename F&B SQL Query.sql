-- [MySQL] F&B Market Expansion Data-Driven Insights

select * from dim_cities;
select * from dim_repondents;
select * from fact_survey_responses;

-- Demographic Insights - Who prefers energy drink more? (male/female/non-binary?)

select Gender, count(Gender) as Gender_Count
from dim_repondents
group by gender
order by Gender_Count desc;

-- Demographic Insights - Which age group prefers energy drinks more?

select age, count(age) as AgeGroup_Count
from dim_repondents
group by age
order by AgeGroup_Count desc;

-- Demographic Insights - Which type of marketing reaches the most Youth (15-30)?

select s.Marketing_channels, count(distinct(s.Respondent_ID)) as Count
from fact_survey_responses s
join dim_respondents r on s.Respondent_ID = r.Respondent_ID
where Age in ('15-18', '19-30')
group by Marketing_channels
order by count desc;

-- Consumer Preferences: What are the preferred ingredients of energy drinks among respondents?

select Ingredients_expected, count(distinct (Respondent_ID)) as Count
from fact_survey_responses
group by Ingredients_expected
order by Count desc;

-- Consumer Preferences: What packaging preferences do respondents have for energy drinks?

select Packaging_preference, count(distinct (Respondent_ID)) as Count 
from fact_survey_responses
group by Packaging_preference
order by Count desc;

-- Competition Analysis: Who are the current market leaders?

select Current_brands, count(distinct (Respondent_ID)) as Count
from fact_survey_responses
group by Current_brands
order by Count desc;

-- Competition Analysis: What are the primary reasons consumers prefer those brands over ours?

select Reasons_for_choosing_brands as Reason, count(distinct (Respondent_ID)) as Count
from fact_survey_responses
group by Reason
order by Count desc;

-- Marketing Channels and Brand Awareness: Which marketing channel can be used to reach more customers?

select Marketing_channels, count(distinct (Respondent_ID)) as Count
from fact_survey_responses
group by Marketing_channels
order by count desc;

-- Marketing Channels and Brand Awareness: How effective are different 
-- marketing strategies and channels in reaching our customers?

select Marketing_channels,
		round((count(distinct (Respondent_ID)) /
			(select count(distinct (Respondent_ID))
			from fact_survey_responses))
            * 100,2) as Effectiveness
from fact_survey_responses
group by Marketing_channels 
order by Effectiveness desc;

-- Brand Penetration: What do people think about our brand? (overall rating)
-- 1 (Poor), 2 (Below Average), 3 (Average), 4 (Good), 5 (Excellent)

select Taste_experience as Rating,
		round(count(distinct Respondent_ID) / 
        (select count(distinct Respondent_ID) 
        from fact_survey_responses)
		* 100, 2) Rating_Percentage
from fact_survey_responses
group by Rating
order by Rating_Percentage desc;

-- Brand Penetration: Which cities do we need to focus more on?

select c.City, count(distinct s. Respondent_ID) as Respondent_Count,
		sum(case when s.Heard_before = 'Yes' then 1 else 0 end) as Heard_Before_Count, 
        round((sum(case when s.heard_before = 'Yes' then 1 else 0 end)
		/ (count(distinct (s. Respondent_ID))))
		*100, 2) as Heard_Percentage
from fact_survey_responses s
join dim_respondents r
on s.respondent_id = r.respondent_id
join dim_cities c
on c.city_id = r.city_id
group by City
order by Heard_Percentage desc;

-- Purchase Behavior: Where do respondents prefer to purchase energy drinks?

select Purchase_location, count(distinct Respondent_ID) as Count, 
		round(count(distinct Respondent_ID) /
        (select count(distinct Respondent_ID) 
        from fact_survey_responses) 
        * 100, 2) as Percentage
from fact_survey_responses 
group by Purchase_location
order by Percentage desc;

-- Purchase Behavior: What are the typical consumption situations for energy drinks among respondents?

select Typical_consumption_situations as Situations, count(distinct Respondent_ID) as Count, 
		round(count(distinct Respondent_ID) /
        (select count(distinct Respondent_ID) 
        from fact_survey_responses) 
        * 100, 2) as Percentage
from fact_survey_responses 
group by Situations
order by Percentage desc;

-- Purchase Behavior: What factors influence respondents' purchase decisions, 
-- such as price range and limited edition packaging?

select Price_range, Limited_edition_packaging,
		round((count(distinct Respondent_ID)) /
        ( select count(distinct Respondent_ID)
        from fact_survey_responses)
        * 100, 2) as Respondent_Percentage
from fact_survey_responses
group by Price_range, Limited_edition_packaging
order by Price_range, Respondent_Percentage desc;

-- Product Development Which area of business should we focus more on our product development? 
-- (Branding/taste/availability)

select 'Brand Perception' as Category, Brand_perception as Subcategory,
		round((count(distinct Respondent_ID)) /
        (select count(distinct Respondent_ID) from fact_survey_responses)
        * 100, 2) as Respondent_Percentage
from fact_survey_responses
group by Brand_perception

UNION ALL

select 'Taste Experience' as Category, Taste_experience as Subcategory,
		round(count(distinct Respondent_ID) / 
        (select count(distinct Respondent_ID) from fact_survey_responses
        where Tried_before = 'Yes') *100, 2) AS Respondent_Percentage
from fact_survey_responses
where Tried_before = 'Yes'
group by Taste_experience

UNION ALL

select 'Reasons for Choosing Brands' as Category, Reasons_for_choosing_brands AS Subcategory,
		round((count(distinct Respondent_ID)) /
        (select count(distinct Respondent_ID)from fact_survey_responses)
        * 100, 2) as Respondent_Percentage
from fact_survey_responses
where Reasons_for_choosing_brands IN ('Availability', 'Taste/flavor preference', 'Brand reputation', 'Effectiveness')
group by Reasons_for_choosing_brands
order by Category, Respondent_Percentage desc;
