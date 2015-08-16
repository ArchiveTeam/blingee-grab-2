dofile("urlcode.lua")
dofile("table_show.lua")

local url_count = 0
local tries = 0
local item_type = os.getenv('item_type')
local item_value = os.getenv('item_value')

local downloaded = {}
local addedtolist = {}
local users = {}

local title = nil

-- Do not download following urls:
downloaded["http://blingee.com/favicon.gif"] = true
downloaded["http://blingee.com/javascripts/all_min.js?1341491407"] = true
downloaded["http://partner.googleadservices.com/gampad/google_service.js"] = true
downloaded["http://blingee.com/stylesheets/blingee_v2.css?1414542910"] = true
downloaded["http://blingee.com/stylesheets/ratings.css?1341491499"] = true
downloaded["http://blingee.com/images/web_ui/logo.png"] = true
downloaded["http://blingee.com/images/web_ui/button_search.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon44_facebook.gif?1341491498"] = true
downloaded["http://blingee.com/images/web_ui/icon44_myspace.gif?1341491498"] = true
downloaded["http://blingee.com/images/web_ui/icon44_twitter.gif?1341491498"] = true
downloaded["http://blingee.com/images/web_ui/icon44_tumblr.gif?1341491498"] = true
downloaded["http://blingee.com/images/web_ui/icon44_pinterest.gif?1341491498"] = true
downloaded["http://blingee.com/images/web_ui/icon44_share1.gif?1341491498"] = true
downloaded["http://blingee.com/account/login"] = true
downloaded["http://blingee.com/images/web_ui/icons/tick.gif"] = true
downloaded["http://blingee.com/images/web_ui/partners/fxguru_160x160_animated.gif"] = true
downloaded["http://edge.quantserve.com/quant.js"] = true
downloaded["http://blingee.com/"] = true
downloaded["http://blingee.com/iepngfix.htc"] = true
downloaded["http://blingee.com/stylesheets/csshover3.htc"] = true
downloaded["http://blingee.com/images/web_ui/bodyfill.gif"] = true
downloaded["http://blingee.com/images/web_ui/button_green_big.gif"] = true
downloaded["http://blingee.com/images/web_ui/header_ourfriends_slant.gif"] = true
downloaded["http://blingee.com/images/web_ui/header_ourfriends_round.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabFill.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabLeft.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabRight.gif"] = true
downloaded["http://blingee.com/images/web_ui/navSelectedLeft.gif"] = true
downloaded["http://blingee.com/images/web_ui/navSelectedRight.gif"] = true
downloaded["http://blingee.com/images/web_ui/bucket.jpg"] = true
downloaded["http://blingee.com/images/image_background.gif"] = true
downloaded["http://blingee.com/images/web_ui/button_makeablingee_home.gif"] = true
downloaded["http://blingee.com/images/web_ui/star.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_view_all.gif"] = true
downloaded["http://blingee.com/images/web_ui/icons/script.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_enter_arrow.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_vote.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_goodiebag.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_credits.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_surveys.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_offers.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_cellphone.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_homephone.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_friends.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_creditcard.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_stats_white.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon48_surveys.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon48_offers.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon48_cellphone.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon48_homephone.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon48_creditcard.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon48_blingee_plus.png"] = true
downloaded["http://blingee.com/images/web_ui/icon48_blingee_plus.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon48_home.png"] = true
downloaded["http://blingee.com/images/web_ui/icon48_home.gif"] = true
downloaded["http://blingee.com/images/web_ui/contest_winner_home.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon36_module_groups.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon36_module_star.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon36_module_compete.gif"] = true
downloaded["http://blingee.com/images/web_ui/spotlight_bg.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_first.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_second.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_third.gif"] = true
downloaded["http://blingee.com/images/web_ui/button_yellow.gif"] = true
downloaded["http://blingee.com/images/web_ui/buttonfill_yellow.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_share_myspace_hi5_bebo.gif"] = true
downloaded["http://blingee.com/images/web_ui/bullet_bling.gif"] = true
downloaded["http://blingee.com/images/web_ui/bullet_edit.gif"] = true
downloaded["http://blingee.com/images/web_ui/icons/medal_gold.gif"] = true
downloaded["http://blingee.com/images/web_ui/bullet_alert.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon11_star.gif"] = true
downloaded["http://blingee.com/images/web_ui/combg.gif"] = true
downloaded["http://blingee.com/images/web_ui/comhead.gif"] = true
downloaded["http://blingee.com/images/web_ui/comtl.gif"] = true
downloaded["http://blingee.com/images/web_ui/combr.gif"] = true
downloaded["http://blingee.com/images/web_ui/comfoot.gif"] = true
downloaded["http://blingee.com/images/web_ui/compost.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_dafault.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_goodie.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_get_code.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_edit.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_contests.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_blingee_logo.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_group.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_favorite.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_spotlight.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_home_yellow.gif"] = true
downloaded["http://blingee.com/images/web_ui/bullet_favorite.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_stats.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_redbullet.gif"] = true
downloaded["http://blingee.com/images/web_ui/pink_shade.gif"] = true
downloaded["http://blingee.com/images/web_ui/group_list_divider.gif"] = true
downloaded["http://blingee.com/images/web_ui/giantbutton.gif"] = true
downloaded["http://blingee.com/images/web_ui/adbg.gif"] = true
downloaded["http://blingee.com/images/web_ui/adhead.gif"] = true
downloaded["http://blingee.com/images/web_ui/adfoot.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_pinkbullet.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon32_credits.png"] = true
downloaded["http://blingee.com/images/web_ui/icon32_credits.gif"] = true
downloaded["http://blingee.com/images/web_ui/liright.gif"] = true
downloaded["http://blingee.com/images/web_ui/li.gif"] = true
downloaded["http://blingee.com/images/web_ui/lia.gif"] = true
downloaded["http://blingee.com/images/web_ui/progressbar_leftcap.gif"] = true
downloaded["http://blingee.com/images/web_ui/progressbar_rightcap.gif"] = true
downloaded["http://blingee.com/images/web_ui/progressbar_incomplete.gif"] = true
downloaded["http://blingee.com/images/web_ui/progressbar_current.gif"] = true
downloaded["http://blingee.com/images/web_ui/progressbar_complete.gif"] = true
downloaded["http://blingee.com/images/web_ui/sharetabs_body_full_fill.gif"] = true
downloaded["http://blingee.com/images/web_ui/sharetabs_body_menued_fill.gif"] = true
downloaded["http://blingee.com/images/web_ui/sharetabs_getcodes.gif"] = true
downloaded["http://blingee.com/images/web_ui/sharetabs_getcodes_full.gif"] = true
downloaded["http://blingee.com/images/web_ui/sharetabs_email.gif"] = true
downloaded["http://blingee.com/images/web_ui/sharetabs_body_full_bottom.gif"] = true
downloaded["http://blingee.com/images/web_ui/sharetabs_body_menued_bottom.gif"] = true
downloaded["http://blingee.com/images/web_ui/bullet_display.gif"] = true
downloaded["http://blingee.com/images/web_ui/icons/arrow_right.gif"] = true
downloaded["http://blingee.com/images/web_ui/prem_month.gif"] = true
downloaded["http://blingee.com/images/web_ui/prem_year.gif"] = true
downloaded["http://blingee.com/images/web_ui/credits_package_100.gif"] = true
downloaded["http://blingee.com/images/web_ui/credits_package_500.gif"] = true
downloaded["http://blingee.com/images/web_ui/prem_button.gif"] = true
downloaded["http://blingee.com/images/web_ui/embedded_header_background.png"] = true
downloaded["http://blingee.com/images/web_ui/badgealbum_headerbg_top.gif"] = true
downloaded["http://blingee.com/images/web_ui/badgealbum_headerbg_main.gif"] = true
downloaded["http://blingee.com/images/web_ui/badgealbum_headerbg_bottom.gif"] = true
downloaded["http://blingee.com/images/web_ui/badgealbum_headerbg_pinkbotborder.gif"] = true
downloaded["http://blingee.com/images/web_ui/bulletonyellow.jpg"] = true
downloaded["http://blingee.com/images/web_ui/bulletonpink.jpg"] = true
downloaded["http://blingee.com/images/web_ui/badgealbum_headerbg_wide_top.gif"] = true
downloaded["http://blingee.com/images/web_ui/badgealbum_headerbg_wide_main.gif"] = true
downloaded["http://blingee.com/images/web_ui/badgealbum_headerbg_wide_bottom.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_joingroup.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_userblock.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_block.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_email.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_edit.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_credit_bucket.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_comment.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_gift.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_blingee.gif"] = true
downloaded["http://blingee.com/images/web_ui/icons/sort.gif"] = true
downloaded["http://blingee.com/images/web_ui/input.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon45_share_skyrock.gif"] = true
downloaded["http://blingee.com/images/web_ui/hint_left.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon33_credits.gif"] = true
downloaded["http://blingee.com/images/web_ui/spotlight_list_fill.gif"] = true
downloaded["http://blingee.com/images/web_ui/spotlight_head.jpg"] = true
downloaded["http://blingee.com/images/web_ui/icon16_twirlie_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/user_panel_top.gif"] = true
downloaded["http://blingee.com/images/web_ui/user_panel_bottom.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_bullet_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_email_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_comment_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_friends_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_profile_edit.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_competition_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_spotlight_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/facebook.gif"] = true
downloaded["http://blingee.com/images/web_ui/gradient_med_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_account_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_prefs_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_default_picture.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_stamps_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icons/trophy.gif"] = true
downloaded["http://blingee.com/images/web_ui/icons/postcard.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_favorites_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_favoritestamps_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_comment_trans.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon16_groups_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/pitch_bullet.gif"] = true
downloaded["http://blingee.com/images/web_ui/greenfade.gif"] = true
downloaded["http://blingee.com/images/web_ui/download_arrow_small.gif"] = true
downloaded["http://blingee.com/images/web_ui/download_arrow.gif"] = true
downloaded["http://blingee.com/images/web_ui/install_logo.gif"] = true
downloaded["http://blingee.com/images/web_ui/install_box_arrow_top.gif"] = true
downloaded["http://blingee.com/images/web_ui/step_fill.gif"] = true
downloaded["http://blingee.com/images/web_ui/install_no_arrow.jpg"] = true
downloaded["http://blingee.com/images/web_ui/install_arrow_up.jpg"] = true
downloaded["http://blingee.com/images/web_ui/icon42_alert.gif"] = true
downloaded["http://blingee.com/images/web_ui/bullet_blingee_small.gif"] = true
downloaded["http://blingee.com/images/web_ui/button_gray.gif"] = true
downloaded["http://blingee.com/images/web_ui/gradiant_green_to_red_w50.png"] = true
downloaded["http://blingee.com/images/web_ui/postcardsmenu_title.gif"] = true
downloaded["http://blingee.com/images/web_ui/postcardsmenu_current.gif"] = true
downloaded["http://blingee.com/images/web_ui/postcardsmenu_subtitle.gif"] = true
downloaded["http://blingee.com/images/web_ui/postcardsmenu_list_on.gif"] = true
downloaded["http://blingee.com/images/web_ui/postcardsmenu_list_arrow_pink.gif"] = true
downloaded["http://blingee.com/images/web_ui/header_greentab_left.gif"] = true
downloaded["http://blingee.com/images/web_ui/header_greentab_right.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabRight_new.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabFill_blue.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabLeft_blue.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabRight_blue.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabFill_green.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabLeft_green.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabRight_green.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabFill_gold.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabLeft_gold.gif"] = true
downloaded["http://blingee.com/images/web_ui/navTabRight_gold.gif"] = true
downloaded["http://blingee.com/images/web_ui/facebook/play.gif"] = true
downloaded["http://blingee.com/images/web_ui/icons/application_side_contract.gif"] = true
downloaded["http://blingee.com/images/web_ui/icons/arrow_out.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/homebg.png"] = true
downloaded["http://blingee.com/images/web_ui/canvas/box_1.jpg"] = true
downloaded["http://blingee.com/images/web_ui/canvas/button_1.jpg"] = true
downloaded["http://blingee.com/images/web_ui/canvas/browser_290x240.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/orangebg.jpg"] = true
downloaded["http://blingee.com/images/web_ui/canvas/button_2_bottom.jpg"] = true
downloaded["http://blingee.com/images/web_ui/canvas/button_2_top.jpg"] = true
downloaded["http://blingee.com/images/web_ui/canvas/browser_290x265.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/feature_heading_1.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/pinkbg.jpg"] = true
downloaded["http://blingee.com/images/web_ui/canvas/button_3.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/browser_550x460.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/ff_instructions/icon_38x36.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/ff_instructions/top.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/ff_instructions/close_button.gif"] = true
downloaded["http://blingee.com/images/web_ui/canvas/button_4.gif"] = true
downloaded["http://blingee.com/images/web_ui/challenge/module.gif"] = true
downloaded["http://blingee.com/images/web_ui/challenge/topicons1.gif"] = true
downloaded["http://blingee.com/images/web_ui/challenge/topicons2.gif"] = true
downloaded["http://blingee.com/images/web_ui/challenge/noselection.gif"] = true
downloaded["http://blingee.com/images/web_ui/challenge/submit1.gif"] = true
downloaded["http://blingee.com/images/web_ui/challenge/vote.jpg"] = true
downloaded["http://blingee.com/images/web_ui/challenge/shadow.png"] = true
downloaded["http://blingee.com/images/web_ui/feed/more_gradient.gif"] = true
downloaded["http://blingee.com/images/web_ui/feed/more_arrow.gif"] = true
downloaded["http://blingee.com/images/web_ui/feed/blingee_zoom.gif"] = true
downloaded["http://blingee.com/images/web_ui/feed/ratings_feed.gif"] = true
downloaded["http://blingee.com/images/web_ui/feed/icon_16_comment.gif"] = true
downloaded["http://blingee.com/images/web_ui/feed/button_comment.gif"] = true
downloaded["http://blingee.com/images/web_ui/feed/icon_16_magnify.gif"] = true
downloaded["http://blingee.com/images/web_ui/feed/icon_16_home.gif"] = true
downloaded["http://blingee.com/images/web_ui/feed/icon_16_report.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon50_header_trophy.gif"] = true
downloaded["http://blingee.com/images/web_ui/icon50_header_medal.gif"] = true
downloaded["http://blingee.com/images/web_ui/ratings/star_rating.gif"] = true
downloaded["http://blingee.com/account/login"] = true
downloaded["http://cdn.gigya.com/wildfire/js/wfapiv2.js"] = true
downloaded["http://blingee.com/images/web_ui/myspace.gif"] = true
downloaded["http://blingee.com/images/web_ui/hi5.gif"] = true
downloaded["http://pixel.quantserve.com/pixel/p-24j7Vl-p0r5bY.gif"] = true

read_file = function(file)
  if file then
    local f = assert(io.open(file))
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

line_num = function(linenum, filename)
  local num = 0
  for line in io.lines(filename) do
    num = num + 1
    if num == linenum then
      return line
    end
  end
end

wget.callbacks.download_child_p = function(urlpos, parent, depth, start_url_parsed, iri, verdict, reason)
  local url = urlpos["url"]["url"]
  local html = urlpos["link_expect_html"]
  
  if downloaded[url] == true or addedtolist[url] == true then
    return false
  end
  
  if (downloaded[url] ~= true or addedtolist[url] ~= true) then
    if string.match(urlpos["url"]["host"], "blingee%.com") and string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9]") and not (string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9][a-z0-9]") or string.match(urlpos["url"]["host"], "scorecardresearch%.com") or string.match(urlpos["url"]["host"], "tumblr%.com") or string.match(urlpos["url"]["host"], "facebook%.com") or string.match(urlpos["url"]["host"], "pinterest%.com") or string.match(urlpos["url"]["host"], "nl%.blingee%.com") or string.match(urlpos["url"]["host"], "de%.blingee%.com") or string.match(urlpos["url"]["host"], "es%.blingee%.com") or string.match(urlpos["url"]["host"], "fr%.blingee%.com") or string.match(urlpos["url"]["host"], "it%.blingee%.com") or string.match(urlpos["url"]["host"], "pt%.blingee%.com") or string.match(urlpos["url"]["host"], "ru%.blingee%.com") or string.match(urlpos["url"]["host"], "ja%.blingee%.com") or string.match(urlpos["url"]["host"], "ko%.blingee%.com") or string.match(url, "lang=[a-z][a-z]")) and not (string.match(url, "scorecardresearch%.com") or string.match(url, "blingee%.com/rating/vote") or string.match(url, "blingee%.com/inappropriate_thing/vote") or string.match(url, "blingee%.com/facebook_connect/") or string.match(url, "blingee%.com/ecard/create") or string.match(url, "blingee%.com/blingee/email_friend/") or string.match(url, "blingee%.com/partner/") or string.match(url, "fb%-host%.static%.blingee%.com") or string.match(url, "/blingee/get_code/") or string.match(url, "share_myspace")) then
      addedtolist[url] = true
      return true
    elseif html == 0 and not (string.match(url, "scorecardresearch%.com") or string.match(url, "%?%?%?") or string.match(url, "/images[0-9]+/content/") or string.match(url, "/images/content/")) then
      addedtolist[url] = true
      return true
    else
      return false
    end
  end
end


wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  local html = nil

  if downloaded[url] ~= true then
    downloaded[url] = true
  end
 
  local function check(url)
    if (downloaded[url] ~= true and addedtolist[url] ~= true) and ((string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9]") and not (string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9][a-z0-9]") or string.match(url, "tumblr%.com") or string.match(url, "facebook%.com") or string.match(url, "pinterest%.com") or string.match(url, "nl%.blingee%.com") or string.match(url, "de%.blingee%.com") or string.match(url, "es%.blingee%.com") or string.match(url, "fr%.blingee%.com") or string.match(url, "it%.blingee%.com") or string.match(url, "pt%.blingee%.com") or string.match(url, "ru%.blingee%.com") or string.match(url, "ja%.blingee%.com") or string.match(url, "ko%.blingee%.com") or string.match(url, "lang=[a-z][a-z]"))) or string.match(url, "https?://bln%.gs")) and not (string.match(url, "scorecardresearch%.com") or string.match(url, "/images[0-9]+/content/") or string.match(url, "/images/content/") or string.match(url, "%?%?%?") or string.match(url, "blingee%.com/rating/vote") or string.match(url, "blingee%.com/inappropriate_thing/vote") or string.match(url, "blingee%.com/facebook_connect/") or string.match(url, "blingee%.com/ecard/create") or string.match(url, "blingee%.com/blingee/email_friend/") or string.match(url, "blingee%.com/partner/") or string.match(url, "fb%-host%.static%.blingee%.com") or string.match(url, "/blingee/get_code/") or string.match(url, "share_myspace")) then
      if string.match(url, "&amp;") then
        table.insert(urls, { url=string.gsub(url, "&amp;", "&") })
        addedtolist[url] = true
        addedtolist[string.gsub(url, "&amp;", "&")] = true
      else
        table.insert(urls, { url=url })
        addedtolist[url] = true
      end
    end
  end

  if item_type == "10profiles" and string.match(url, "blingee%.com/badge/view/42/user/") then
    html = read_file(file)
    if string.match(html, '"/profile/[^"]+"') then
      username = string.match(html, '"(/profile/[^"]+)"')
      table.insert(users, username)
      check("http://blingee.com"..username)
      check("http://blingee.com"..username.."/statistics")
      check("http://blingee.com"..username.."/circle")
      check("http://blingee.com"..username.."/badges")
      check("http://blingee.com"..username.."/comments")
      io.stdout:write("Username is "..string.match(username, "/profile/(.+)")..".  \n")
      io.stdout:flush()
    else
      io.stdout:write("Skipping deleted/private profile. \n")
      io.stdout:flush()
    end
  end
  
  if string.match(string.match(url, "https?://([^/]+)/"), "blingee%.com") and string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9]") and not string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9][a-z0-9]") then
    html = read_file(file)
--    if string.match(url, "http://blingee%.com/blingee/view/525151[0-9][0-9]") and not string.match(url, "http://blingee%.com/blingee/view/525151[0-9][0-9].") then
--      title = string.match(html, '<h1>([^<]+)</h1>')
--      io.stdout:write("Title: "..title..".  \n")
--      io.stdout:flush()
--    end
--    for newurl in string.gmatch(html, '"og:image"%s+content="([^"]+)"') do
--      if (downloaded[newurl] ~= true and addedtolist[newurl] ~= true) then
--      io.stdout:write("	"..newurl..".  \n")
--      io.stdout:flush()
--        table.insert(urls, { url=newurl })
--        addedtolist[newurl] = true
--      end
--    end
    for newurl in string.gmatch(html, '"image_src"%s+href="([^"]+)"') do
      if (downloaded[newurl] ~= true and addedtolist[newurl] ~= true) and string.match(url, "http://blingee%.com/blingee/view/525151[0-9][0-9]") and not string.match(url, "http://blingee%.com/blingee/view/525151[0-9][0-9].") then
        table.insert(urls, { url=newurl.."?4" })
        addedtolist[newurl] = true
      end
    end
    for newtitle, newurl in string.gmatch(html, 'title="([^"]+)"%s+src="([^"]+)"') do
      if newtitle == title and (downloaded[newurl] ~= true and addedtolist[newurl] ~= true) then
      io.stdout:write("	"..newtitle..".  \n")
      io.stdout:write("	"..newurl..".  \n")
      io.stdout:flush()
        table.insert(urls, { url=newurl })
        addedtolist[newurl] = true
      end
    end
    for newurl, newtitle in string.gmatch(html, 'src="([^"]+)"%s+title="([^"]+)"') do
      if newtitle == title and (downloaded[newurl] ~= true and addedtolist[newurl] ~= true) then
      io.stdout:write("	"..newtitle..".  \n")
      io.stdout:write("	"..newurl..".  \n")
      io.stdout:flush()
        table.insert(urls, { url=newurl })
        addedtolist[newurl] = true
      end
    end
    for newurl in string.gmatch(html, '"(https?://[^"]+)"') do
      check(newurl)
    end
    for newurl in string.gmatch(html, "'(https?://[^']+)'") do
      check(newurl)
    end
    for newurl in string.gmatch(html, '("/[^"]+)"') do
      if string.match(newurl, '"//') then
        check(string.gsub(newurl, '"//', 'http://'))
      elseif not string.match(newurl, '"//') then
        check(string.match(url, "(https?://[^/]+)/")..string.match(newurl, '"(/.+)'))
      end
    end
    for newurl in string.gmatch(html, "('/[^']+)'") do
      if string.match(newurl, "'//") then
        check(string.gsub(newurl, "'//", "http://"))
      elseif not string.match(newurl, "'//") then
        check(string.match(url, "(https?://[^/]+)/")..string.match(newurl, "'(/.+)"))
      end
    end
  end
  
  return urls
end
  

wget.callbacks.httploop_result = function(url, err, http_stat)
  -- NEW for 2014: Slightly more verbose messages because people keep
  -- complaining that it's not moving or not working
  status_code = http_stat["statcode"]
  
  url_count = url_count + 1
  io.stdout:write(url_count .. "=" .. status_code .. " " .. url["url"] .. ".  \n")
  io.stdout:flush()

  if (status_code >= 200 and status_code <= 399) then
    if string.match(url.url, "https://") then
      local newurl = string.gsub(url.url, "https://", "http://")
      downloaded[newurl] = true
    else
      downloaded[url.url] = true
    end
  end

  if string.match(url["url"], "blingee%.com/rating/vote") or string.match(url["url"], "blingee%.com/inappropriate_thing/vote") or string.match(url["url"], "blingee%.com/facebook_connect/") or string.match(url["url"], "blingee%.com/ecard/create") or string.match(url["url"], "blingee%.com/blingee/email_friend/") or string.match(url["url"], "blingee%.com/partner/skyrock_post_widget") or string.match(url["url"], "blingee%.com/partner/bebo_post_widget") then
    return wget.actions.EXIT
  end

  if status_code == 302 or status_code == 301 then
    os.execute("python check302.py '"..url["url"].."'")
    if io.open("302file", "r") == nil then
      if string.match(url["url"], item_value) and string.match(url["host"], "blingee%.com") then
        io.stdout:write("Something went wrong!! ABORTING  \n")
        io.stdout:flush()
        return wget.actions.ABORT
      end
    end
    local redirfile = io.open("302file", "r")
    local fullfile = redirfile:read("*all")
    local numlinks = 0
    for newurl in string.gmatch(fullfile, "https?://") do
      numlinks = numlinks + 1
    end
    local foundurl = line_num(2, "302file")
    if numlinks > 1 then
--      io.stdout:write("Found "..foundurl.." after redirect")
--      io.stdout:flush()
      if downloaded[foundurl] == true or addedtolist[foundurl] == true then
--        io.stdout:write(", this url has already been downloaded or added to the list to be downloaded, so it is skipped.  \n")
--        io.stdout:flush()
        redirfile:close()
        os.remove("302file")
        return wget.actions.EXIT
      elseif not string.match(foundurl, "https?://") then
        if string.match(url["url"], item_value) and string.match(url["host"], "blingee%.com") then
          io.stdout:write("Something went wrong!! ABORTING  \n")
          io.stdout:flush()
          return wget.actions.ABORT
        end
      end
      redirfile:close()
      os.remove("302file")
--      io.stdout:write(".  \n")
--      io.stdout:flush()
    end
  end
  
  if status_code >= 500 or
    (status_code >= 400 and status_code ~= 404 and status_code ~= 403) then

    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")

    tries = tries + 1

    if tries >= 6 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      tries = 0
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  elseif status_code == 0 then

    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")
    
    tries = tries + 1

    if tries >= 3 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      tries = 0
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  end

  tries = 0

  local sleep_time = 0

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end
