import React, { useState } from 'react';

const CustomerForm = ({ onAdd }) => {
  const [name, setName] = useState('');

  const handleSubmit = async e => {
    e.preventDefault();
    const response = await fetch('http://localhost:8081/api/customers', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name })
    });

    if (response.ok) {
      const newCustomer = await response.json();
      onAdd(newCustomer);
      setName('');
    } else {
      alert('Failed to add customer');
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        value={name}
        onChange={e => setName(e.target.value)}
        placeholder="Enter customer name"
      />
      <button type="submit">Add Customer</button>
    </form>
  );
};

export default CustomerForm;
