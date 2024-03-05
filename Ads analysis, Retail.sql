with facebook_data as (
    select fabd.ad_date, fa.adset_name, fc.campaign_name,
           fabd.spend, fabd.impressions, fabd.reach, fabd.clicks, fabd.leads, fabd.value,
           'Facebook_Ads' as media_source
    from facebook_ads_basic_daily fabd
             left join facebook_adset fa on fa.adset_id = fabd.adset_id
             left join facebook_campaign fc on fc.campaign_id = fabd.campaign_id
),
all_data as (
    select ad_date, adset_name, campaign_name, spend, impressions, reach,
           clicks, leads, value, 'Google_Ads' as media_source
    from google_ads_basic_daily gabd
    union
    select ad_date, adset_name, campaign_name,
          spend, impressions, reach, clicks, leads, value,
           'Facebook_Ads' as media_source
    from facebook_data
)
select ad_date, media_source, campaign_name, adset_name,
       sum(spend) as total_spend,
       sum(impressions) as total_impressions,
       sum(clicks) as total_clicks,
       sum(value) as total_value
from all_data
group by ad_date, media_source, campaign_name, adset_name
order by ad_date;
