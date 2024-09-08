# [DAX] F&B Market Expansion Data Driven Insights

#### Brand Perception - Positive/Neutral
        = VAR TotalResponses = COUNTROWS(fact_survey_responses)
          VAR BrandingPositiveCount = CALCULATE(COUNTROWS(fact_survey_responses), 
          fact_survey_responses[Brand_perception] IN {"Positive", "Neutral"})
          RETURN
          BrandingPositiveCount & " (" & FORMAT(BrandingPositiveCount / TotalResponses * 100, "0.00") & "%)"

#### Taste Experience - Good/Excellent
        = VAR TotalResponses = COUNTROWS(fact_survey_responses)
          VAR TasteGoodOrExcellentCount = CALCULATE(COUNTROWS(fact_survey_responses), 
          fact_survey_responses[Taste_experience] IN {"4", "5"})
          RETURN
          TasteGoodOrExcellentCount & " (" & FORMAT(TasteGoodOrExcellentCount / TotalResponses * 100, "0.00") & "%)"

#### Choice Factor: Availability
        = VAR TotalResponses = COUNTROWS(fact_survey_responses)
          VAR AvailabilityCount = CALCULATE(COUNTROWS(fact_survey_responses),
          fact_survey_responses[Reasons_for_choosing_brands] = "Availability")
          RETURN
          AvailabilityCount & " (" & FORMAT(AvailabilityCount / TotalResponses * 100, "0.00") & "%)"

#### Choice Factor: Brand Reputation
        = VAR TotalResponses = COUNTROWS(fact_survey_responses)
          VAR BrandCount = CALCULATE(COUNTROWS(fact_survey_responses),
          fact_survey_responses[Reasons_for_choosing_brands] = "Brand reputation")
          RETURN
          BrandCount & " (" & FORMAT(BrandCount / TotalResponses * 100, "0.00") & "%)"

#### Choice Factor: Taste/Flavor Preferences       
        = VAR TotalResponses = COUNTROWS(fact_survey_responses)
          VAR PrefCount = CALCULATE(COUNTROWS(fact_survey_responses),
          fact_survey_responses[Reasons_for_choosing_brands] = "Taste/flavor Preference")
          RETURN
          PrefCount & " (" & FORMAT(PrefCount / TotalResponses * 100, "0.00") & "%)"

#### Choice Factor: Effectiveness
        = VAR TotalResponses = COUNTROWS(fact_survey_responses)
          VAR EFFCount = CALCULATE(COUNTROWS(fact_survey_responses),
          fact_survey_responses[Reasons_for_choosing_brands] = "Effectiveness")
          RETURN
          EFFCount & " (" & FORMAT(EFFCount / TotalResponses * 100, "0.00") & "%)"
