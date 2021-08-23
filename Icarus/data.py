import psycopg2
from psycopg2.extras import DictCursor
import sys

connection = psycopg2.connect(user     = "postgres",
                              password = "1234321A@m",
                              host     = "localhost",
                              port     = "5432",
                              database = "Icarus")


cursor = connection.cursor(cursor_factory = DictCursor)


def get_product():
    cursor.execute("select * from store join goods on store.id_goods = goods.code_id")
    record = cursor.fetchall()

    return record

def get_product_by_category(category):
    query = "select * from store join goods on store.id_goods = goods.code_id where type ='"+category+"'"
    cursor.execute(query)
    record = cursor.fetchall()
    return record

def insert_product(data):
    print(data)
    print("insert_product")
    query = "insert into goods values ("+data['id']+",2,"+"'"+data['name']+"'"+","+data['price']+","+"'"+data['production_date']+"'"+","+"'"+data['Expiration_date']+"'"+","+"'"+data['origin']+"'"+","+"'"+data['value']+"'"+")"
     
    print(query)
    cursor.execute(query)
    connection.commit()

    query_ = "insert into store values (11,"+data['id']+","+ data['quantity']+")"
    print(query_)
    cursor.execute(query_)
    
    connection.commit()


def get_order():
    query = "select * from my_order join delivery on my_order.delivery_id = delivery.code"
    cursor.execute(query)
    record = cursor.fetchall()
    return record


def get_order_list(order_status):
    query = "select * from my_order join delivery on my_order.delivery_id = delivery.code  where order_status = '"+order_status+"'"
    cursor.execute(query)
    record = cursor.fetchall()
    return record


def get_order_filter_by_delivary(delivery_status):
    query = "select * from my_order join delivery on my_order.delivery_id = delivery.code  where delivery_status = '"+delivery_status+"'"
    cursor.execute(query)
    record = cursor.fetchall()
    return record

def get_order_list_and_filter_by_delivary(order_status, delivery_status):
    query = "select * from my_order join delivery on my_order.delivery_id = delivery.code  where delivery_status = '"+delivery_status+"' and order_status ='" + order_status +"'"
    cursor.execute(query)
    record = cursor.fetchall()
    return record

def employee():
    query = "select * from employee"
    cursor.execute(query)
    record = cursor.fetchall()
    return record