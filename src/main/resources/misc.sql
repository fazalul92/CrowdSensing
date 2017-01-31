/*
 * A select query involving required fields
 */
select ua.uid, u.gid, u.group_type, ua.testcase_count,time_to_sec(ua.timetaken)/60,
  ua.difficulty, ua.enjoyment, ua.boredom, ua.confidence, ua.anxiety
from users u, userdata_admin ua
where ua.timetaken is not null and u.id = ua.uid;

/*
 * Insert into userdata_admin the the counts of test cases
 */
insert into userdata_admin(uid, testcase_count)
select t.uid, count(t.uid) from testcases t, users u 
where u.id > 381 and u.completion_code is not null and u.id = t.uid 
group by u.id;

/*
 * Update the userdata_admin from postsurvey_responses
 */
update userdata_admin 
inner join postsurvey_responses on userdata_admin.uid = postsurvey_responses.user_id
set userdata_admin.anxiety = postsurvey_responses.description
where postsurvey_responses.question_id = 7 and uid > 381;

/*
 * Update the userdata_admin from postsurvey_responses, converting string to int
 */
update userdata_admin 
inner join postsurvey_responses on userdata_admin.uid = postsurvey_responses.user_id
set userdata_admin.difficulty = (
   case postsurvey_responses.description 
    when 'Easy' then 1
    when 'Very easy' then 2
    when 'Medium' then 3
    when 'High' then 4
    when 'Very high' then 5
   end 
  )
where postsurvey_responses.question_id = 2 and uid > 381;

/*
 * Providing bonus
 */
update userdata_admin set bonus_amt_cents = 300 where testcase_count >= 9 and uid > 381;

update userdata_admin set bonus_amt_cents = 200 where testcase_count = 8 and uid > 381;

update userdata_admin set bonus_amt_cents = 150 where testcase_count in (5, 6, 7) and uid > 381;

update userdata_admin set bonus_amt_cents = 100 where testcase_count = 4 and uid > 381;

update userdata_admin set bonus_amt_cents = 50 where testcase_count = 3 and uid > 381;