from flask import Flask , render_template, request, redirect, url_for
import data as Database
import sys
import json

app  = Flask(__name__)
user = []


@app.route('/home', methods=['POST', 'GET'])
def home():

    return render_template('index.html')


@app.route('/products', methods=['POST', 'GET'])
def products():
    products = Database.get_product()

    value= -1 #default value
    if request.method == "POST":  
        value = request.form
        
        if value['value'] == '0' :
            products = Database.get_product()
        else:
            products = Database.get_product_by_category(value['value'])

    return render_template('products.html', products = products)


@app.route('/employee')
def employee():
    employee = Database.employee()
    return render_template('employee.html', employees=employee)


@app.route('/report-order', methods=['POST', 'GET'])
def report_order():
    order = Database.get_order()
    
    value= -1 #default value
    if request.method == "POST":  
        value = request.form
        if value['orderValue'] == '0' and  value['deliveryValue'] == '0':
            order = Database.get_order()
        
        elif value['deliveryValue'] != '0'and value['orderValue'] == '0':
            order = Database.get_order_filter_by_delivary(value['deliveryValue'])
        
        elif value['orderValue'] != '0' and value['deliveryValue'] == '0':
            order = Database.get_order_list(value['orderValue'])
        
        elif value['orderValue'] != '0' and value['deliveryValue'] != '0':
            order = Database.get_order_list_and_filter_by_delivary(value['orderValue'], value['deliveryValue'])
        else :
            order = Database.get_order()

    print(order)
    return render_template('report-order.html',  report_orders = order)


@app.route('/report-sell')
def report_sell():
    return render_template('report-sell.html')


@app.route('/add-product', methods=['POST', 'GET'])
def add_product():
    
    if request.method == "POST":  
        data = request.form
        print("data", data)
        
        if not isdigit(data['id']) or not isdigit(data['price']) or not isdigit(data['quantity']):
            message = "Invalid input"
            print(message)
            render_template('add-product.html', message=message)
        else :
            Database.insert_product(data)
            return redirect(url_for('products'))

    return render_template('add-product.html')


@app.route('/edit-product')
def edit_product():
    return render_template('edit.html')
    
    
@app.route('/accounts')
def accounts():
    return render_template('accounts.html')

    
@app.route('/login', methods=['POST', 'GET'])
def login():
    message = ''
    
    if request.method == "POST":  
        value = request.form
        print(value)
        if value['username'] == 'fleur_masson@outlook.com' and value['password'] == 'wer1234' : 
            message = "Login successfully!"
            print(message)
            return redirect(url_for('home'))
        else:
            message = "Email or pass incorrect! Please try again!"
            print(message)
            return render_template('login.html', message = message) 

    return render_template('login.html')

    
if __name__ == "__main__":
    app.run()