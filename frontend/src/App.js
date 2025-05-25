import React, { useState } from 'react';
import CustomerList from './components/CustomerList';
import CustomerForm from './components/CustomerForm';
function App() {
  const [customers, setCustomers] = useState([]);

  const addCustomer = newCustomer => {
    setCustomers(prev => [...prev, newCustomer]);
  };

  return (
    <div className="App">
      <h1>React Frontend for Microservices</h1>
      <CustomerForm onAdd={addCustomer} />
      <CustomerList />
    </div>
  );
}

export default App;
