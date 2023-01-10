drop table member;

create table member(
	no int not null auto_increment,
    email varchar(100) not null,
    password varchar(64) not null,
    name varchar(100) not null,
    department varchar(100),
    
    primary key(no)
);
desc member;

alter table member add column juminbunho char(13) not null;
desc member;

alter table member drop juminbunho;
desc member;

alter table member add column juminbunho char(13) not null after email;
desc member;

alter table member change column department dept varchar(200) not null;
desc member;

alter table member add self_intro text;
desc member;

alter table member drop juminbunho;
desc member;

-- insert
insert into member
values (null, 'shin@kasukabe.boys', password('1234'), '신짱구','개발팀', null);
select * from member;

insert into member(no, email, name, dept, password)
values (null, 'kim@kasukabe.boys', '김철수', '개발팀', password('1234'));
select * from member;

-- update
update member
set dept='영업팀'
where no = 2;
select * from member;

-- delete
delete
from member
where no = 2;
select * from member;

-- transaction
-- insert, update, delete에만 해당.
select @@autocommit;
-- autocommit = 0 이면 자동으로 서버에 커밋 하지 않음
-- autocommit = 0 이면 자동으로 서버에 커밋
set autocommit = 0; 
commit;