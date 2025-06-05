import React, { useEffect, useState } from 'react';

function App() {
  const [customers, setCustomers] = useState([]);
  const [form, setForm] = useState({ name: '', email: '' });

  // Fetch customers on load
  useEffect(() => {
    fetch('/customers')
      .then(res => res.json())
      .then(setCustomers)
      .catch(console.error);
  }, []);

  // Handle form submit
  const handleSubmit = (e) => {
    e.preventDefault();
    fetch('/customers', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(form),
    })
      .then(res => res.json())
      .then(newCustomer => {
        setCustomers([...customers, newCustomer]);
        setForm({ name: '', email: '' });
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
      <form onSubmit={handleSubmit}>
        <input
          placeholder="Name"
          value={form.name}
          onChange={e => setForm({ ...form, name: e.target.value })}
        />
        <input
          placeholder="Email"
          value={form.email}
          onChange={e => setForm({ ...form, email: e.target.value })}
        />
        <button type="submit">Add</button>
      </form>
    </div>
  );
}

export default App;
