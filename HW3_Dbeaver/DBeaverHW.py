import psycopg2
import names
conn = psycopg2.connect(dbname='qa_ddl_24_121',
                        user='user_24_121',
                        password='123',
                        host='159.69.151.133',
                        port='5056')
cursor = conn.cursor()


a = names.get_first_name()
for i in range(70):
    if conn:
        a = names.get_full_name()
        full_name = "'" + a + "'"
        print(full_name)
        insert_query = 'insert into public.employees(employee_name)'\
                        'values (' + full_name + ')'

        cursor.execute(insert_query)
        conn.commit()
cursor.close()

for i in range(0,15):
    if conn:
        salary_item = str(1000 + i * 100)
        insert_query = 'insert into public.salary(monthly_salary)'\
                        'values (' + salary_item + ')'
        cursor.execute(insert_query)
        conn.commit()
cursor.close()