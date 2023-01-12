-- emaillist

-- insert
insert into emaillist
values(null, '짱', '구', 'Jgu@gmail.com');

-- delete
delete 
from emaillist
where email = 'Jgu@gmail.com';

-- list
select no, first_name, last_name, email
from emaillist
order by no desc;