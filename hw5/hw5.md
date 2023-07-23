## Домашнее задание №5
### DML: вставка, обновление, удаление, выборка данных 
##### Author **Alexey Bityugin**
#
**Используемые инструменты**
- VMware Workstation 
- PostgreSQL 15.3 
- pgAdmin

#
**Материалы выполненного ДЗ**

##### 1. Запрос с регулярным выражением.

   select * from prod.customer
   where first_name ~ 'А[ИА]А' and everage_check >= 50000;

   Запрос ищет клиентов у которых имя начинается и заканчивается на А, а в серидине могут встречатся либо И либо А либо вместе, с средним чеком не менее 50000. 

##### 2. Запрос с использованием LEFT JOIN и INNER JOIN.

select * from prod.customer as cs 
    inner join prod.phototype_skin as phs 
        on cs.fk_id_phototype_skin = phs.id_phototype_skin;

Запрос позволяет отобразить у клиентов фототип кожи из справочника.

select * from prod.visit as vi 
    left join prod.order as ord 
        on vi.id_visit = ord.fk_id_visit;

Позволяет бегло оценить наличе единичных визитов.

От порядка перечисления таблиц после FROM напрямую зависит получаемый результат т.к. в зависимости от использования типа соединения интерпретатор будет ожидать конкретные объеткы для последующей обработки.

##### 3. Запрос на добавление данных с выводом информации о добавленных строках.

insert into prod.discount (discount, start_date, end_date)
    values('5', '2023-07-23', '2023-08-23'),
            ('7', '2023-06-01', '2023-11-30'),
            ('3', '2023-01-01', '2023-12-31'),
            ('10', '2023-09-01', '2023-12-31')
returning id_discount, discount, start_date, end_date; 

##### 4. Запрос с обновлением данные используя UPDATE FROM.

alter table prod.customer add column visits int;

update prod.customer
set visits = (select count(*)
	from prod.visit
	where visit.fk_id_customer = customer.id_customer)
where customer.fk_id_customer_type = (select id_customer_type from prod.customer_type where customer_type in ('Gold','Silver'))
returning *;

Добавим общее количество визитов для клиентов категорий Gold и Silver.

##### 5. Запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.

Предположим, что в таблицах prod.customer и prod.customer_type два одинаково названых поля id_customer_type

delete from prod.customer
where exists 
	(select *
	from prod.customer
		join prod.customer_type as ct
			using(id_customer_type)
	where ct.customer_type is null)
returning *;

##### 6. * Пример использования утилиты COPY.
  Подготовка файла с клентами у которых в будущем месяце будут ДР для поздравлений и предложения спец. условий.

copy (select last_name, first_name, birth_date, customer_type, discount, subscription, phone_mob from prod.customer 
    where extract(month from customer.birth_date)=08 
			order by customer.birth_date) 
	to '/mnt/nfs/share/birth_day.csv' with (format csv);