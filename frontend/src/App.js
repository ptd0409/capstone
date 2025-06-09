import React, { useEffect, useState } from 'react';

function App() {
  const [customers, setCustomers] = useState([]);
  const [orders, setOrders] = useState([]);
  const [customerForm, setCustomerForm] = useState({ name: '', email: '' });
  const [orderForm, setOrderForm] = useState({ description: '', amount: '' });

  // Fetch customers
  useEffect(() => {
    fetch('/customers')
      .then(res => res.json())
      .then(setCustomers)
      .catch(console.error);
  }, []);

  // Fetch orders
  useEffect(() => {
    fetch('/orders')
      .then(res => res.json())
      .then(setOrders)
      .catch(console.error);
  }, []);

  // Add customer
  const handleCustomerSubmit = (e) => {
    e.preventDefault();
    fetch('/customers', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(customerForm),
    })
      .then(res => res.json())
      .then(newCustomer => {
        setCustomers([...customers, newCustomer]);
        setCustomerForm({ name: '', email: '' });
      });
  };

  // Add order
  const handleOrderSubmit = (e) => {
    e.preventDefault();
    fetch('/orders', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        description: orderForm.description,
        amount: parseFloat(orderForm.amount)
      }),
    })
      .then(res => res.json())
      .then(newOrder => {
        setOrders([...orders, newOrder]);
        setOrderForm({ description: '', amount: '' });
      });
  };

  return (
    <div style={{ padding: '2rem' }}>
      <h1>Customer List</h1>
      <ul>
        {customers.map((c, i) => (
          <li key={i}>{c.name} ({c.email})</li>
        ))}
      </ul>

      <h2>Add Customer</h2>
      <form onSubmit={handleCustomerSubmit}>
        <input
          placeholder="Name"
          value={customerForm.name}
          onChange={e => setCustomerForm({ ...customerForm, name: e.target.value })}
        />
        <input
          placeholder="Email"
          value={customerForm.email}
          onChange={e => setCustomerForm({ ...customerForm, email: e.target.value })}
        />
        <button type="submit">Add</button>
      </form>

      <hr />

      <h1>Order List</h1>
      <ul>
        {orders.map((o, i) => (
          <li key={i}>{o.description} - ${o.amount}</li>
        ))}
      </ul>

      <h2>Add Order</h2>
      <form onSubmit={handleOrderSubmit}>
        <input
          placeholder="Description"
          value={orderForm.description}
          onChange={e => setOrderForm({ ...orderForm, description: e.target.value })}
        />
        <input
          placeholder="Amount"
          type="number"
          value={orderForm.amount}
          onChange={e => setOrderForm({ ...orderForm, amount: e.target.value })}
        />
        <button type="submit">Add</button>
      </form>
    </div>
  );
}

export default App;
