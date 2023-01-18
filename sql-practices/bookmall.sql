-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
--       User
-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
select * from user;
desc user;

select no, name, phone, email, password from user;
insert into user values(null, '홍길동', '010-0100-0100', 'jildong@naver.com', '아버지를아버지라');


-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
--     Category
-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
select * from category;
desc category;

select no, type from category;
insert into category values(null, '소설');


-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
--       Book
-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
select * from book;
desc book;

select no, title, price, category_no from book;
insert into book values (null, '홍길동전', 35000, 1);


-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
--       Cart
-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
select * from cart;
desc cart;

select c.no, a.no, b.no, b.title, b.price, c.count 
from user a join book b join cart c 
on a.no = c.user_no and b.no = c.book_no 
where a.no = 1;

insert into cart values (null, 2, 1, 1);


-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
--       Orders
-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
select * from orders;
desc orders;

select b.no, a.no, a.name, a.email, b.price, b.address 
from user a join orders b 
on a.no = b.user_no 
where a.no = 1;
    
insert into orders values(null, (
									select sum(a.count * b.price)
									from cart a join book b join user c
									on a.book_no = b.no
									and a.user_no = c.no
                                    where a.user_no = 1
									), '떡잎마을', 1);


-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
--     Order_book
-- @@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@
select * from order_book;
desc order_book;

select a.no, a.count, a.book_no, a.orders_no, c.title
from order_book a join orders b join book c
on a.orders_no = b.no
and a.book_no = c.no
where orders_no = 1;

insert into order_book 
select null, c.count, d.no, b.no
from user a join orders b join cart c join book d
	on a.no = b.user_no
    and b.user_no = c.user_no
    and c.book_no = d.no
where a.no = 1 and b.no = 1;